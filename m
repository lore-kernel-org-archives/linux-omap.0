From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 03/17] staging: tidspbridge: remove proc_init() and proc_exit()
Date: Fri,  9 Mar 2012 01:03:38 +0100
Message-ID: <a7496c4b97282c041bdf9fe04cf4ed9441688179.1331250369.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.mundo-r.com ([212.51.32.151]:47122 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab2CIAEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 19:04:11 -0500
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org

The proc module has a proc_init() and a proc_exit() whose only purpose
is to keep a reference counting which is not used at all.

This patch removes these functions and the reference count variable.

There is no functional changes.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 .../staging/tidspbridge/include/dspbridge/proc.h   |   28 ------------=
--------
 drivers/staging/tidspbridge/pmgr/dspapi.c          |    9 +-----
 drivers/staging/tidspbridge/rmgr/proc.c            |   28 ------------=
--------
 3 files changed, 2 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/proc.h b/dri=
vers/staging/tidspbridge/include/dspbridge/proc.h
index f00dffd..a82380e 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/proc.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/proc.h
@@ -189,20 +189,6 @@ extern int proc_get_resource_info(void *hprocessor=
,
 					 u32 resource_info_size);
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D proc_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Decrement reference count, and free resources when reference c=
ount is
- *      0.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      PROC is initialized.
- *  Ensures:
- *      When reference count =3D=3D 0, PROC's private resources are fr=
eed.
- */
-extern void proc_exit(void);
-
-/*
  * =3D=3D=3D=3D=3D=3D=3D=3D proc_get_dev_object =3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  *  Purpose:
  *      Returns the DEV Hanlde for a given Processor handle
@@ -223,20 +209,6 @@ extern int proc_get_dev_object(void *hprocessor,
 				      struct dev_object **device_obj);
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D proc_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize PROC's private state, keeping a reference count on =
each
- *      call.
- *  Parameters:
- *  Returns:
- *      TRUE if initialized; FALSE if error occurred.
- *  Requires:
- *  Ensures:
- *      TRUE: A requirement for the other public PROC functions.
- */
-extern bool proc_init(void);
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D proc_get_state =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Report the state of the specified DSP processor.
diff --git a/drivers/staging/tidspbridge/pmgr/dspapi.c b/drivers/stagin=
g/tidspbridge/pmgr/dspapi.c
index 971e839..7c20a0f 100644
--- a/drivers/staging/tidspbridge/pmgr/dspapi.c
+++ b/drivers/staging/tidspbridge/pmgr/dspapi.c
@@ -274,7 +274,6 @@ void api_exit(void)
 		strm_exit();
 		disp_exit();
 		node_exit();
-		proc_exit();
 		mgr_exit();
 		rmm_exit();
 	}
@@ -289,12 +288,11 @@ bool api_init(void)
 {
 	bool ret =3D true;
 	bool fdev, fchnl, fmsg, fio;
-	bool fmgr, fproc, fnode, fdisp, fstrm, frmm;
+	bool fmgr, fnode, fdisp, fstrm, frmm;
=20
 	if (api_c_refs =3D=3D 0) {
 		/* initialize driver and other modules */
 		fmgr =3D mgr_init();
-		fproc =3D proc_init();
 		fnode =3D node_init();
 		fdisp =3D disp_init();
 		fstrm =3D strm_init();
@@ -304,7 +302,7 @@ bool api_init(void)
 		fio =3D io_init();
 		fdev =3D dev_init();
 		ret =3D fdev && fchnl && fmsg && fio;
-		ret =3D ret && fmgr && fproc && frmm;
+		ret =3D ret && fmgr && frmm;
 		if (!ret) {
=20
 			if (fmgr)
@@ -313,9 +311,6 @@ bool api_init(void)
 			if (fstrm)
 				strm_exit();
=20
-			if (fproc)
-				proc_exit();
-
 			if (fnode)
 				node_exit();
=20
diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/=
tidspbridge/rmgr/proc.c
index b865d64..7e4f12f 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -98,8 +98,6 @@ struct proc_object {
 	struct list_head proc_list;
 };
=20
-static u32 refs;
-
 DEFINE_MUTEX(proc_lock);	/* For critical sections */
=20
 /*  ----------------------------------- Function Prototypes */
@@ -909,17 +907,6 @@ func_end:
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D proc_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Decrement reference count, and free resources when reference c=
ount is
- *      0.
- */
-void proc_exit(void)
-{
-	refs--;
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D proc_get_dev_object =3D=3D=3D=3D=3D=3D=3D=
=3D
  *  Purpose:
  *      Return the Dev Object handle for a given Processor.
@@ -1010,21 +997,6 @@ int proc_get_trace(void *hprocessor, u8 * pbuf, u=
32 max_size)
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D proc_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize PROC's private state, keeping a reference count on =
each call
- */
-bool proc_init(void)
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
  *  =3D=3D=3D=3D=3D=3D=3D=3D proc_load =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Reset a processor and load a new base program image.
--=20
1.7.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
