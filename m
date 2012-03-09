From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 12/17] staging: tidspbridge: remove dmm_init() and dmm_exit()
Date: Fri,  9 Mar 2012 01:03:47 +0100
Message-ID: <324824cf5bc55899ae948ae4e585f5ed102f379a.1331250369.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.mundo-r.com ([212.51.32.151]:47122 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758657Ab2CIAEW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 19:04:22 -0500
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org

The dmm module has a dmm_init() and a dmm_exit() whose only purpose is
to keep a reference counting which is not used at all.

This patch removes these functions and the reference count variable.

There is no functional changes.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 .../staging/tidspbridge/include/dspbridge/dmm.h    |    4 --
 drivers/staging/tidspbridge/pmgr/dev.c             |    6 ----
 drivers/staging/tidspbridge/pmgr/dmm.c             |   32 ------------=
--------
 3 files changed, 0 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/dmm.h b/driv=
ers/staging/tidspbridge/include/dspbridge/dmm.h
index 6c58335..c3487be 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dmm.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dmm.h
@@ -61,10 +61,6 @@ extern int dmm_create(struct dmm_object **dmm_manage=
r,
 			     struct dev_object *hdev_obj,
 			     const struct dmm_mgrattrs *mgr_attrts);
=20
-extern bool dmm_init(void);
-
-extern void dmm_exit(void);
-
 extern int dmm_create_tables(struct dmm_object *dmm_mgr,
 				    u32 addr, u32 size);
=20
diff --git a/drivers/staging/tidspbridge/pmgr/dev.c b/drivers/staging/t=
idspbridge/pmgr/dev.c
index 734d47e..c5e627c 100644
--- a/drivers/staging/tidspbridge/pmgr/dev.c
+++ b/drivers/staging/tidspbridge/pmgr/dev.c
@@ -657,9 +657,6 @@ int dev_get_bridge_context(struct dev_object *hdev_=
obj,
 void dev_exit(void)
 {
 	refs--;
-
-	if (refs =3D=3D 0)
-		dmm_exit();
 }
=20
 /*
@@ -671,9 +668,6 @@ bool dev_init(void)
 {
 	bool ret =3D true;
=20
-	if (refs =3D=3D 0)
-		dmm_init();
-
 	if (ret)
 		refs++;
=20
diff --git a/drivers/staging/tidspbridge/pmgr/dmm.c b/drivers/staging/t=
idspbridge/pmgr/dmm.c
index 83faff8..7c9f839 100644
--- a/drivers/staging/tidspbridge/pmgr/dmm.c
+++ b/drivers/staging/tidspbridge/pmgr/dmm.c
@@ -51,8 +51,6 @@ struct dmm_object {
 	spinlock_t dmm_lock;	/* Lock to access dmm mgr */
 };
=20
-/*  ----------------------------------- Globals */
-static u32 refs;		/* module reference count */
 struct map_page {
 	u32 region_size:15;
 	u32 mapped_size:15;
@@ -172,18 +170,6 @@ int dmm_delete_tables(struct dmm_object *dmm_mgr)
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D dmm_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Discontinue usage of module; free resources when reference cou=
nt
- *      reaches 0.
- */
-void dmm_exit(void)
-{
-
-	refs--;
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D dmm_get_handle =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Return the dynamic memory manager object for this device.
@@ -206,24 +192,6 @@ int dmm_get_handle(void *hprocessor, struct dmm_ob=
ject **dmm_manager)
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D dmm_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initializes private state of DMM module.
- */
-bool dmm_init(void)
-{
-	bool ret =3D true;
-
-	if (ret)
-		refs++;
-
-	virtual_mapping_table =3D NULL;
-	table_size =3D 0;
-
-	return ret;
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D dmm_map_memory =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Add a mapping block to the reserved chunk. DMM assumes that th=
is block
--=20
1.7.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
