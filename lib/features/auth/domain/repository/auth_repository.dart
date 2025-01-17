import 'package:dartz/dartz.dart';
import 'package:fitness_tracker/core/error/failure.dart';
import 'package:fitness_tracker/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity entity);

  Future<Either<Failure, String>> loginUser(String userName, String password);

  // Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
