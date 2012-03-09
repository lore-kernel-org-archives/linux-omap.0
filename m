From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 02/17] staging: tidspbridge: remove cod_init() and cod_exit()
Date: Fri,  9 Mar 2012 01:03:37 +0100
Message-ID: <bdd5754cbc4d29eb4e3bd746e52db8c1b95ac672.1331250369.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.mundo-r.com ([212.51.32.151]:47122 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683Ab2CIAEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 19:04:13 -0500
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org

The cod module has a cod_init() and a cod_exit() whose only purpose is
to keep a reference counting which is not used at all.

This patch removes these functions and the reference count variable.

There is no functional changes.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 .../staging/tidspbridge/include/dspbridge/cod.h    |   29 ------------=
--------
 drivers/staging/tidspbridge/pmgr/cod.c             |   29 ------------=
--------
 drivers/staging/tidspbridge/pmgr/dspapi.c          |    9 +-----
 drivers/staging/tidspbridge/rmgr/dbdcd.c           |   15 +---------
 4 files changed, 3 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/cod.h b/driv=
ers/staging/tidspbridge/include/dspbridge/cod.h
index cb684c1..ba2005d 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/cod.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/cod.h
@@ -100,21 +100,6 @@ extern int cod_create(struct cod_manager **mgr,
 extern void cod_delete(struct cod_manager *cod_mgr_obj);
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D cod_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Discontinue usage of the COD module.
- *  Parameters:
- *      None.
- *  Returns:
- *      None.
- *  Requires:
- *      COD initialized.
- *  Ensures:
- *      Resources acquired in cod_init(void) are freed.
- */
-extern void cod_exit(void);
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D cod_get_base_lib =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Get handle to the base image DBL library.
@@ -243,20 +228,6 @@ extern int cod_get_sym_value(struct cod_manager *c=
od_mgr_obj,
 				    char *str_sym, u32 * pul_value);
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D cod_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize the COD module's private state.
- *  Parameters:
- *      None.
- *  Returns:
- *      TRUE if initialized; FALSE if error occurred.
- *  Requires:
- *  Ensures:
- *      A requirement for each of the other public COD functions.
- */
-extern bool cod_init(void);
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D cod_load_base =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Load the initial program image, optionally with command-line a=
rguments,
diff --git a/drivers/staging/tidspbridge/pmgr/cod.c b/drivers/staging/t=
idspbridge/pmgr/cod.c
index d01fb8e..4007826 100644
--- a/drivers/staging/tidspbridge/pmgr/cod.c
+++ b/drivers/staging/tidspbridge/pmgr/cod.c
@@ -58,8 +58,6 @@ struct cod_libraryobj {
 	struct cod_manager *cod_mgr;
 };
=20
-static u32 refs =3D 0L;
-
 static struct dbll_fxns ldr_fxns =3D {
 	(dbll_close_fxn) dbll_close,
 	(dbll_create_fxn) dbll_create,
@@ -268,17 +266,6 @@ void cod_delete(struct cod_manager *cod_mgr_obj)
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D cod_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Discontinue usage of the COD module.
- *
- */
-void cod_exit(void)
-{
-	refs--;
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D cod_get_base_lib =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Get handle to the base image DBL library.
@@ -395,22 +382,6 @@ int cod_get_sym_value(struct cod_manager *cod_mgr_=
obj, char *str_sym,
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D cod_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize the COD module's private state.
- *
- */
-bool cod_init(void)
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
  *  =3D=3D=3D=3D=3D=3D=3D=3D cod_load_base =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Load the initial program image, optionally with command-line a=
rguments,
diff --git a/drivers/staging/tidspbridge/pmgr/dspapi.c b/drivers/stagin=
g/tidspbridge/pmgr/dspapi.c
index dcf1dab..971e839 100644
--- a/drivers/staging/tidspbridge/pmgr/dspapi.c
+++ b/drivers/staging/tidspbridge/pmgr/dspapi.c
@@ -267,7 +267,6 @@ void api_exit(void)
=20
 	if (api_c_refs =3D=3D 0) {
 		/* Release all modules initialized in api_init(). */
-		cod_exit();
 		dev_exit();
 		chnl_exit();
 		msg_exit();
@@ -289,7 +288,7 @@ void api_exit(void)
 bool api_init(void)
 {
 	bool ret =3D true;
-	bool fdev, fcod, fchnl, fmsg, fio;
+	bool fdev, fchnl, fmsg, fio;
 	bool fmgr, fproc, fnode, fdisp, fstrm, frmm;
=20
 	if (api_c_refs =3D=3D 0) {
@@ -304,8 +303,7 @@ bool api_init(void)
 		fmsg =3D msg_mod_init();
 		fio =3D io_init();
 		fdev =3D dev_init();
-		fcod =3D cod_init();
-		ret =3D fdev && fchnl && fcod && fmsg && fio;
+		ret =3D fdev && fchnl && fmsg && fio;
 		ret =3D ret && fmgr && fproc && frmm;
 		if (!ret) {
=20
@@ -336,9 +334,6 @@ bool api_init(void)
 			if (fdev)
 				dev_exit();
=20
-			if (fcod)
-				cod_exit();
-
 			if (frmm)
 				rmm_exit();
=20
diff --git a/drivers/staging/tidspbridge/rmgr/dbdcd.c b/drivers/staging=
/tidspbridge/rmgr/dbdcd.c
index 8378b7b..12a1d34 100644
--- a/drivers/staging/tidspbridge/rmgr/dbdcd.c
+++ b/drivers/staging/tidspbridge/rmgr/dbdcd.c
@@ -289,7 +289,6 @@ void dcd_exit(void)
=20
 	refs--;
 	if (refs =3D=3D 0) {
-		cod_exit();
 		list_for_each_entry_safe(rv, rv_tmp, &reg_key_list, link) {
 			list_del(&rv->link);
 			kfree(rv->path);
@@ -738,22 +737,10 @@ int dcd_get_library_name(struct dcd_manager *hdcd=
_mgr,
  */
 bool dcd_init(void)
 {
-	bool init_cod;
 	bool ret =3D true;
=20
-	if (refs =3D=3D 0) {
-		/* Initialize required modules. */
-		init_cod =3D cod_init();
-
-		if (!init_cod) {
-			ret =3D false;
-			/* Exit initialized modules. */
-			if (init_cod)
-				cod_exit();
-		}
-
+	if (refs =3D=3D 0)
 		INIT_LIST_HEAD(&reg_key_list);
-	}
=20
 	if (ret)
 		refs++;
--=20
1.7.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
