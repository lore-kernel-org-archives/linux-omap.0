From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 10/17] staging: tidspbridge: remove io_init() and io_exit()
Date: Fri,  9 Mar 2012 01:03:45 +0100
Message-ID: <059463ad3da393eb5dd45c6069095dfdef1a93b3.1331250369.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The io module has a io_init() and a io_exit() whose only purpose is to
keep a reference counting which is not used at all.

This patch removes these functions and the reference count variable.

There is no functional changes.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/include/dspbridge/io.h |   29 ------------=
--------
 drivers/staging/tidspbridge/pmgr/dspapi.c          |   10 +-----
 drivers/staging/tidspbridge/pmgr/io.c              |   28 ------------=
-------
 3 files changed, 2 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/io.h b/drive=
rs/staging/tidspbridge/include/dspbridge/io.h
index 500bbd7..7505718 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/io.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/io.h
@@ -55,7 +55,6 @@ struct io_attrs {
  *      -EINVAL: Invalid DSP word size (must be > 0).
  *               Invalid base address for DSP communications.
  *  Requires:
- *      io_init(void) called.
  *      io_man !=3D NULL.
  *      mgr_attrts !=3D NULL.
  *  Ensures:
@@ -74,36 +73,8 @@ extern int io_create(struct io_mgr **io_man,
  *      0:        Success.
  *      -EFAULT:    hio_mgr was invalid.
  *  Requires:
- *      io_init(void) called.
  *  Ensures:
  */
 extern int io_destroy(struct io_mgr *hio_mgr);
=20
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D io_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Discontinue usage of the IO module.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      io_init(void) previously called.
- *  Ensures:
- *      Resources, if any acquired in io_init(void), are freed when th=
e last
- *      client of IO calls io_exit(void).
- */
-extern void io_exit(void);
-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D io_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize the IO module's private state.
- *  Parameters:
- *  Returns:
- *      TRUE if initialized; FALSE if error occurred.
- *  Requires:
- *  Ensures:
- *      A requirement for each of the other public CHNL functions.
- */
-extern bool io_init(void);
-
 #endif /* CHNL_ */
diff --git a/drivers/staging/tidspbridge/pmgr/dspapi.c b/drivers/stagin=
g/tidspbridge/pmgr/dspapi.c
index 5201bed..b9ca24c 100644
--- a/drivers/staging/tidspbridge/pmgr/dspapi.c
+++ b/drivers/staging/tidspbridge/pmgr/dspapi.c
@@ -268,7 +268,6 @@ void api_exit(void)
 	if (api_c_refs =3D=3D 0) {
 		/* Release all modules initialized in api_init(). */
 		dev_exit();
-		io_exit();
 		mgr_exit();
 	}
 }
@@ -281,24 +280,19 @@ void api_exit(void)
 bool api_init(void)
 {
 	bool ret =3D true;
-	bool fdev, fio;
+	bool fdev;
 	bool fmgr;
=20
 	if (api_c_refs =3D=3D 0) {
 		/* initialize driver and other modules */
 		fmgr =3D mgr_init();
-		fio =3D io_init();
 		fdev =3D dev_init();
-		ret =3D fdev && fio;
-		ret =3D ret && fmgr;
+		ret =3D fdev && fmgr;
 		if (!ret) {
=20
 			if (fmgr)
 				mgr_exit();
=20
-			if (fio)
-				io_exit();
-
 			if (fdev)
 				dev_exit();
 		}
diff --git a/drivers/staging/tidspbridge/pmgr/io.c b/drivers/staging/ti=
dspbridge/pmgr/io.c
index a56b085..4073c9c 100644
--- a/drivers/staging/tidspbridge/pmgr/io.c
+++ b/drivers/staging/tidspbridge/pmgr/io.c
@@ -30,9 +30,6 @@
 #include <ioobj.h>
 #include <dspbridge/io.h>
=20
-/*  ----------------------------------- Globals */
-static u32 refs;
-
 /*
  *  =3D=3D=3D=3D=3D=3D=3D=3D io_create =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
@@ -94,28 +91,3 @@ int io_destroy(struct io_mgr *hio_mgr)
=20
 	return status;
 }
-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D io_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Discontinue usage of the IO module.
- */
-void io_exit(void)
-{
-	refs--;
-}
-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D io_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize the IO module's private state.
- */
-bool io_init(void)
-{
-	bool ret =3D true;
-
-	if (ret)
-		refs++;
-
-	return ret;
-}
--=20
1.7.9.1
