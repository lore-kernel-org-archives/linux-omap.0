From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 17/17] staging: tidspbridge: remove nldr_init() and nldr_exit()
Date: Fri,  9 Mar 2012 01:03:52 +0100
Message-ID: <15501a475f483f6190aaa0d8bcb61ec4a7102b4e.1331250369.git.vjaquez@igalia.com>
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

The dynamic loader was called by node.c with an interface. This interfa=
ce was
also modified to avoid the use of nldr_init() and nldr_exit().

There is not functional changes.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 .../staging/tidspbridge/include/dspbridge/nldr.h   |    2 -
 .../tidspbridge/include/dspbridge/nldrdefs.h       |   34 ------------=
--------
 drivers/staging/tidspbridge/rmgr/nldr.c            |   19 -----------
 drivers/staging/tidspbridge/rmgr/node.c            |    7 ----
 4 files changed, 0 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/nldr.h b/dri=
vers/staging/tidspbridge/include/dspbridge/nldr.h
index d9653ee..c5e48ca 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/nldr.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/nldr.h
@@ -36,7 +36,6 @@ extern int nldr_create(struct nldr_object **nldr,
 			      const struct nldr_attrs *pattrs);
=20
 extern void nldr_delete(struct nldr_object *nldr_obj);
-extern void nldr_exit(void);
=20
 extern int nldr_get_fxn_addr(struct nldr_nodeobject *nldr_node_obj,
 				    char *str_fxn, u32 * addr);
@@ -44,7 +43,6 @@ extern int nldr_get_fxn_addr(struct nldr_nodeobject *=
nldr_node_obj,
 extern int nldr_get_rmm_manager(struct nldr_object *nldr,
 				       struct rmm_target_obj **rmm_mgr);
=20
-extern bool nldr_init(void);
 extern int nldr_load(struct nldr_nodeobject *nldr_node_obj,
 			    enum nldr_phase phase);
 extern int nldr_unload(struct nldr_nodeobject *nldr_node_obj,
diff --git a/drivers/staging/tidspbridge/include/dspbridge/nldrdefs.h b=
/drivers/staging/tidspbridge/include/dspbridge/nldrdefs.h
index ee3a85f..7e3c7f5 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/nldrdefs.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/nldrdefs.h
@@ -119,7 +119,6 @@ enum nldr_phase {
  *      0:        Success.
  *      -ENOMEM:    Insufficient memory on GPP.
  *  Requires:
- *      nldr_init(void) called.
  *      Valid nldr_obj.
  *      node_props !=3D NULL.
  *      nldr_nodeobj !=3D NULL.
@@ -148,7 +147,6 @@ typedef int(*nldr_allocatefxn) (struct nldr_object =
*nldr_obj,
  *      0:        Success;
  *      -ENOMEM:    Insufficient memory for requested resources.
  *  Requires:
- *      nldr_init(void) called.
  *      nldr !=3D NULL.
  *      hdev_obj !=3D NULL.
  *	pattrs !=3D NULL.
@@ -168,7 +166,6 @@ typedef int(*nldr_createfxn) (struct nldr_object **=
nldr,
  *      nldr_obj:          Node manager object.
  *  Returns:
  *  Requires:
- *      nldr_init(void) called.
  *      Valid nldr_obj.
  *  Ensures:
  *	nldr_obj invalid
@@ -176,20 +173,6 @@ typedef int(*nldr_createfxn) (struct nldr_object *=
*nldr,
 typedef void (*nldr_deletefxn) (struct nldr_object *nldr_obj);
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D nldr_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Discontinue usage of NLDR module.
- *
- *  Parameters:
- *  Returns:
- *  Requires:
- *      nldr_init(void) successfully called before.
- *  Ensures:
- *      Any resources acquired in nldr_init(void) will be freed when l=
ast NLDR
- *      client calls nldr_exit(void).
- */
-typedef void (*nldr_exitfxn) (void);
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D NLDR_Free =3D=3D=3D=3D=3D=3D=3D=3D
  *  Free resources allocated in nldr_allocate.
  *
@@ -197,7 +180,6 @@ typedef void (*nldr_exitfxn) (void);
  *      nldr_node_obj:      Handle returned from nldr_allocate().
  *  Returns:
  *  Requires:
- *      nldr_init(void) called.
  *      Valid nldr_node_obj.
  *  Ensures:
  */
@@ -216,7 +198,6 @@ typedef void (*nldr_freefxn) (struct nldr_nodeobjec=
t *nldr_node_obj);
  *      0:        Success.
  *      -ESPIPE:    Address of function not found.
  *  Requires:
- *      nldr_init(void) called.
  *      Valid nldr_node_obj.
  *      addr !=3D NULL;
  *      str_fxn !=3D NULL;
@@ -227,17 +208,6 @@ typedef int(*nldr_getfxnaddrfxn) (struct nldr_node=
object
 					 char *str_fxn, u32 * addr);
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D nldr_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Initialize the NLDR module.
- *
- *  Parameters:
- *  Returns:
- *      TRUE if initialization succeeded, FALSE otherwise.
- *  Ensures:
- */
-typedef bool(*nldr_initfxn) (void);
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D nldr_load =3D=3D=3D=3D=3D=3D=3D=3D
  *  Load create, delete, or execute phase function of a node on the DS=
P.
  *
@@ -251,7 +221,6 @@ typedef bool(*nldr_initfxn) (void);
  *                              is already in use.
  *      -EILSEQ:           Failure in dynamic loader library.
  *  Requires:
- *      nldr_init(void) called.
  *      Valid nldr_node_obj.
  *  Ensures:
  */
@@ -269,7 +238,6 @@ typedef int(*nldr_loadfxn) (struct nldr_nodeobject =
*nldr_node_obj,
  *      0:        Success.
  *      -ENOMEM:    Insufficient memory on GPP.
  *  Requires:
- *      nldr_init(void) called.
  *      Valid nldr_node_obj.
  *  Ensures:
  */
@@ -283,9 +251,7 @@ struct node_ldr_fxns {
 	nldr_allocatefxn allocate;
 	nldr_createfxn create;
 	nldr_deletefxn delete;
-	nldr_exitfxn exit;
 	nldr_getfxnaddrfxn get_fxn_addr;
-	nldr_initfxn init;
 	nldr_loadfxn load;
 	nldr_unloadfxn unload;
 };
diff --git a/drivers/staging/tidspbridge/rmgr/nldr.c b/drivers/staging/=
tidspbridge/rmgr/nldr.c
index 46086b5..30d5480 100644
--- a/drivers/staging/tidspbridge/rmgr/nldr.c
+++ b/drivers/staging/tidspbridge/rmgr/nldr.c
@@ -620,15 +620,6 @@ void nldr_delete(struct nldr_object *nldr_obj)
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D nldr_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Discontinue usage of NLDR module.
- */
-void nldr_exit(void)
-{
-	/* do nothing */
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D nldr_get_fxn_addr =3D=3D=3D=3D=3D=3D=3D=3D
  */
 int nldr_get_fxn_addr(struct nldr_nodeobject *nldr_node_obj,
@@ -736,16 +727,6 @@ int nldr_get_rmm_manager(struct nldr_object *nldr,
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D nldr_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Initialize the NLDR module.
- */
-bool nldr_init(void)
-{
-	/* do nothing */
-	return true;
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D nldr_load =3D=3D=3D=3D=3D=3D=3D=3D
  */
 int nldr_load(struct nldr_nodeobject *nldr_node_obj,
diff --git a/drivers/staging/tidspbridge/rmgr/node.c b/drivers/staging/=
tidspbridge/rmgr/node.c
index 908cd1e..7fb426c 100644
--- a/drivers/staging/tidspbridge/rmgr/node.c
+++ b/drivers/staging/tidspbridge/rmgr/node.c
@@ -159,7 +159,6 @@ struct node_mgr {
 	/* Loader properties */
 	struct nldr_object *nldr_obj;	/* Handle to loader */
 	struct node_ldr_fxns nldr_fxns;	/* Handle to loader functions */
-	bool loader_init;	/* Loader Init function succeeded? */
 };
=20
 /*
@@ -266,9 +265,7 @@ static struct node_ldr_fxns nldr_fxns =3D {
 	nldr_allocate,
 	nldr_create,
 	nldr_delete,
-	nldr_exit,
 	nldr_get_fxn_addr,
-	nldr_init,
 	nldr_load,
 	nldr_unload,
 };
@@ -1337,7 +1334,6 @@ int node_create_mgr(struct node_mgr **node_man,
 	nldr_attrs_obj.write =3D mem_write;
 	nldr_attrs_obj.dsp_word_size =3D node_mgr_obj->dsp_word_size;
 	nldr_attrs_obj.dsp_mau_size =3D node_mgr_obj->dsp_mau_size;
-	node_mgr_obj->loader_init =3D node_mgr_obj->nldr_fxns.init();
 	status =3D node_mgr_obj->nldr_fxns.create(&node_mgr_obj->nldr_obj,
 			hdev_obj,
 			&nldr_attrs_obj);
@@ -2507,9 +2503,6 @@ static void delete_node_mgr(struct node_mgr *hnod=
e_mgr)
 		if (hnode_mgr->nldr_obj)
 			hnode_mgr->nldr_fxns.delete(hnode_mgr->nldr_obj);
=20
-		if (hnode_mgr->loader_init)
-			hnode_mgr->nldr_fxns.exit();
-
 		kfree(hnode_mgr);
 	}
 }
--=20
1.7.9.1
