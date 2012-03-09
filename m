From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 13/17] staging: tidspbridge: remove dev_init() and dev_exit()
Date: Fri,  9 Mar 2012 01:03:48 +0100
Message-ID: <3e2fd084f9cb97370f666142ddb88e869f26bf24.1331250369.git.vjaquez@igalia.com>
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

The dev module has a dev_init() and a dev_exit() whose only purpose is
to keep a reference counting which is not used at all.

This patch removes these functions and the reference count variable.

There is no functional changes.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 .../staging/tidspbridge/include/dspbridge/dev.h    |   27 ------------=
------
 drivers/staging/tidspbridge/pmgr/dev.c             |   29 ------------=
--------
 drivers/staging/tidspbridge/pmgr/dspapi.c          |   22 ++----------=
---
 3 files changed, 3 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/dev.h b/driv=
ers/staging/tidspbridge/include/dspbridge/dev.h
index f92b4be..fa2d79e 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dev.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dev.h
@@ -478,33 +478,6 @@ extern int dev_get_bridge_context(struct dev_objec=
t *hdev_obj,
 				      **phbridge_context);
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D dev_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Decrement reference count, and free resources when reference c=
ount is
- *      0.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      DEV is initialized.
- *  Ensures:
- *      When reference count =3D=3D 0, DEV's private resources are fre=
ed.
- */
-extern void dev_exit(void);
-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D dev_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize DEV's private state, keeping a reference count on e=
ach call.
- *  Parameters:
- *  Returns:
- *      TRUE if initialized; FALSE if error occurred.
- *  Requires:
- *  Ensures:
- *      TRUE: A requirement for the other public DEV functions.
- */
-extern bool dev_init(void);
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D dev_insert_proc_object =3D=3D=3D=3D=3D=3D=
=3D=3D
  *  Purpose:
  *      Inserts the Processor Object into the List of PROC Objects
diff --git a/drivers/staging/tidspbridge/pmgr/dev.c b/drivers/staging/t=
idspbridge/pmgr/dev.c
index c5e627c..6234ffb 100644
--- a/drivers/staging/tidspbridge/pmgr/dev.c
+++ b/drivers/staging/tidspbridge/pmgr/dev.c
@@ -81,9 +81,6 @@ struct drv_ext {
 	char sz_string[MAXREGPATHLENGTH];
 };
=20
-/*  ----------------------------------- Globals */
-static u32 refs;		/* Module reference count */
-
 /*  ----------------------------------- Function Prototypes */
 static int fxn_not_implemented(int arg, ...);
 static int init_cod_mgr(struct dev_object *dev_obj);
@@ -649,32 +646,6 @@ int dev_get_bridge_context(struct dev_object *hdev=
_obj,
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D dev_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Decrement reference count, and free resources when reference c=
ount is
- *      0.
- */
-void dev_exit(void)
-{
-	refs--;
-}
-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D dev_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize DEV's private state, keeping a reference count on e=
ach call.
- */
-bool dev_init(void)
-{
-	bool ret =3D true;
-
-	if (ret)
-		refs++;
-
-	return ret;
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D dev_notify_clients =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Notify all clients of this device of a change in device status=
=2E
diff --git a/drivers/staging/tidspbridge/pmgr/dspapi.c b/drivers/stagin=
g/tidspbridge/pmgr/dspapi.c
index b9ca24c..9ef1ad9 100644
--- a/drivers/staging/tidspbridge/pmgr/dspapi.c
+++ b/drivers/staging/tidspbridge/pmgr/dspapi.c
@@ -265,11 +265,8 @@ void api_exit(void)
 {
 	api_c_refs--;
=20
-	if (api_c_refs =3D=3D 0) {
-		/* Release all modules initialized in api_init(). */
-		dev_exit();
+	if (api_c_refs =3D=3D 0)
 		mgr_exit();
-	}
 }
=20
 /*
@@ -280,23 +277,10 @@ void api_exit(void)
 bool api_init(void)
 {
 	bool ret =3D true;
-	bool fdev;
-	bool fmgr;
-
-	if (api_c_refs =3D=3D 0) {
-		/* initialize driver and other modules */
-		fmgr =3D mgr_init();
-		fdev =3D dev_init();
-		ret =3D fdev && fmgr;
-		if (!ret) {
=20
-			if (fmgr)
-				mgr_exit();
+	if (api_c_refs =3D=3D 0)
+		ret =3D mgr_init();
=20
-			if (fdev)
-				dev_exit();
-		}
-	}
 	if (ret)
 		api_c_refs++;
=20
--=20
1.7.9.1
