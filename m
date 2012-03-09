From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 09/17] staging: tidspbridge: remove msg_mod_init() and msg_exit()
Date: Fri,  9 Mar 2012 01:03:44 +0100
Message-ID: <8d005b6699a0656a581c3a3e9c03d2087ef64008.1331250369.git.vjaquez@igalia.com>
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

The msg module has a msg_mod_init() and a msg_exit() whose only
purpose is to keep a reference counting which is not used at all.

This patch removes these functions and the reference count variable.

There is no functional changes.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 .../staging/tidspbridge/include/dspbridge/msg.h    |   27 ------------=
--------
 drivers/staging/tidspbridge/pmgr/dspapi.c          |    9 +-----
 drivers/staging/tidspbridge/pmgr/msg.c             |   21 ------------=
---
 3 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/msg.h b/driv=
ers/staging/tidspbridge/include/dspbridge/msg.h
index 95778bc..2c8712c 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/msg.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/msg.h
@@ -34,7 +34,6 @@
  *      msg_callback:        Called whenever an RMS_EXIT message is re=
ceived.
  *  Returns:
  *  Requires:
- *      msg_mod_init(void) called.
  *      msg_man !=3D NULL.
  *      hdev_obj !=3D NULL.
  *      msg_callback !=3D NULL.
@@ -52,35 +51,9 @@ extern int msg_create(struct msg_mgr **msg_man,
  *      hmsg_mgr:            Handle returned from msg_create().
  *  Returns:
  *  Requires:
- *      msg_mod_init(void) called.
  *      Valid hmsg_mgr.
  *  Ensures:
  */
 extern void msg_delete(struct msg_mgr *hmsg_mgr);
=20
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D msg_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Discontinue usage of msg_ctrl module.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      msg_mod_init(void) successfully called before.
- *  Ensures:
- *      Any resources acquired in msg_mod_init(void) will be freed whe=
n last
- *      msg_ctrl client calls msg_exit(void).
- */
-extern void msg_exit(void);
-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D msg_mod_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize the msg_ctrl module.
- *  Parameters:
- *  Returns:
- *      TRUE if initialization succeeded, FALSE otherwise.
- *  Ensures:
- */
-extern bool msg_mod_init(void);
-
 #endif /* MSG_ */
diff --git a/drivers/staging/tidspbridge/pmgr/dspapi.c b/drivers/stagin=
g/tidspbridge/pmgr/dspapi.c
index 5b9dcad..5201bed 100644
--- a/drivers/staging/tidspbridge/pmgr/dspapi.c
+++ b/drivers/staging/tidspbridge/pmgr/dspapi.c
@@ -268,7 +268,6 @@ void api_exit(void)
 	if (api_c_refs =3D=3D 0) {
 		/* Release all modules initialized in api_init(). */
 		dev_exit();
-		msg_exit();
 		io_exit();
 		mgr_exit();
 	}
@@ -282,25 +281,21 @@ void api_exit(void)
 bool api_init(void)
 {
 	bool ret =3D true;
-	bool fdev, fmsg, fio;
+	bool fdev, fio;
 	bool fmgr;
=20
 	if (api_c_refs =3D=3D 0) {
 		/* initialize driver and other modules */
 		fmgr =3D mgr_init();
-		fmsg =3D msg_mod_init();
 		fio =3D io_init();
 		fdev =3D dev_init();
-		ret =3D fdev && fmsg && fio;
+		ret =3D fdev && fio;
 		ret =3D ret && fmgr;
 		if (!ret) {
=20
 			if (fmgr)
 				mgr_exit();
=20
-			if (fmsg)
-				msg_exit();
-
 			if (fio)
 				io_exit();
=20
diff --git a/drivers/staging/tidspbridge/pmgr/msg.c b/drivers/staging/t=
idspbridge/pmgr/msg.c
index 077c118..f093cfb 100644
--- a/drivers/staging/tidspbridge/pmgr/msg.c
+++ b/drivers/staging/tidspbridge/pmgr/msg.c
@@ -33,9 +33,6 @@
 #include <msgobj.h>
 #include <dspbridge/msg.h>
=20
-/*  ----------------------------------- Globals */
-static u32 refs;		/* module reference count */
-
 /*
  *  =3D=3D=3D=3D=3D=3D=3D=3D msg_create =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
@@ -92,21 +89,3 @@ void msg_delete(struct msg_mgr *hmsg_mgr)
 			__func__, hmsg_mgr);
 	}
 }
-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D msg_exit =3D=3D=3D=3D=3D=3D=3D=3D
- */
-void msg_exit(void)
-{
-	refs--;
-}
-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D msg_mod_init =3D=3D=3D=3D=3D=3D=3D=3D
- */
-bool msg_mod_init(void)
-{
-	refs++;
-
-	return true;
-}
--=20
1.7.9.1
