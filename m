From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 04/17] staging: tidspbridge: remove node_init() and node_exit()
Date: Fri,  9 Mar 2012 01:03:39 +0100
Message-ID: <e37bf4c22995c807dbd9f53771766c775ce4354b.1331250369.git.vjaquez@igalia.com>
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

The node module has a node_init() and a node_exit() whose only purpose
is to keep a reference counting which is not used at all.

This patch removes these functions and the reference count variable.

There is no functional changes.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 .../staging/tidspbridge/include/dspbridge/node.h   |   41 ------------=
--------
 .../tidspbridge/include/dspbridge/nodepriv.h       |    1 -
 drivers/staging/tidspbridge/pmgr/dspapi.c          |    7 +---
 drivers/staging/tidspbridge/rmgr/node.c            |   24 -----------
 4 files changed, 1 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/node.h b/dri=
vers/staging/tidspbridge/include/dspbridge/node.h
index 16371d8..7397b7a 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/node.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/node.h
@@ -47,7 +47,6 @@
  *      -EPERM:          A failure occurred, unable to allocate node.
  *      -EBADR:    Proccessor is not in the running state.
  *  Requires:
- *      node_init(void) called.
  *      hprocessor !=3D NULL.
  *      node_uuid !=3D NULL.
  *      noderes !=3D NULL.
@@ -81,7 +80,6 @@ extern int node_allocate(struct proc_object *hprocess=
or,
  *      -EPERM:      General Failure.
  *      -EINVAL:      Invalid Size.
  *  Requires:
- *      node_init(void) called.
  *      pbuffer !=3D NULL.
  *  Ensures:
  */
@@ -106,7 +104,6 @@ extern int node_alloc_msg_buf(struct node_object *h=
node,
  *                          or NODE_RUNNING state.
  *      -ETIME:       A timeout occurred before the DSP responded.
  *  Requires:
- *      node_init(void) called.
  *  Ensures:
  *      0 && (Node's current priority =3D=3D prio)
  */
@@ -157,7 +154,6 @@ extern int node_change_priority(struct node_object =
*hnode, s32 prio);
  *                              Device node to device node, or device =
node to
  *                              GPP), the two nodes are on different D=
SPs.
  *  Requires:
- *      node_init(void) called.
  *  Ensures:
  */
 extern int node_connect(struct node_object *node1,
@@ -185,7 +181,6 @@ extern int node_connect(struct node_object *node1,
  *      -ETIME:       A timeout occurred before the DSP responded.
  *      -EPERM:          A failure occurred, unable to create node.
  *  Requires:
- *      node_init(void) called.
  *  Ensures:
  */
 extern int node_create(struct node_object *hnode);
@@ -206,7 +201,6 @@ extern int node_create(struct node_object *hnode);
  *      -ENOMEM:    Insufficient memory for requested resources.
  *      -EPERM:      General failure.
  *  Requires:
- *      node_init(void) called.
  *      node_man !=3D NULL.
  *      hdev_obj !=3D NULL.
  *  Ensures:
@@ -234,7 +228,6 @@ extern int node_create_mgr(struct node_mgr **node_m=
an,
  *      -EPERM:          A failure occurred in deleting the node.
  *      -ESPIPE:        Delete function not found in the COFF file.
  *  Requires:
- *      node_init(void) called.
  *  Ensures:
  *      0:            hnode is invalid.
  */
@@ -250,7 +243,6 @@ extern int node_delete(struct node_res_object *node=
res,
  *  Returns:
  *      0:        Success.
  *  Requires:
- *      node_init(void) called.
  *      Valid hnode_mgr.
  *  Ensures:
  */
@@ -287,20 +279,6 @@ extern int node_enum_nodes(struct node_mgr *hnode_=
mgr,
 				  u32 *pu_allocated);
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D node_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Discontinue usage of NODE module.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      node_init(void) successfully called before.
- *  Ensures:
- *      Any resources acquired in node_init(void) will be freed when l=
ast NODE
- *      client calls node_exit(void).
- */
-extern void node_exit(void);
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D node_free_msg_buf =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Free a message buffer previously allocated with node_alloc_msg=
_buf.
@@ -313,7 +291,6 @@ extern void node_exit(void);
  *      -EFAULT:    Invalid node handle.
  *      -EPERM:      Failure to free the buffer.
  *  Requires:
- *      node_init(void) called.
  *      pbuffer !=3D NULL.
  *  Ensures:
  */
@@ -336,7 +313,6 @@ extern int node_free_msg_buf(struct node_object *hn=
ode,
  *      0:        Success.
  *      -EFAULT:    Invalid hnode.
  *  Requires:
- *      node_init(void) called.
  *      pattr !=3D NULL.
  *  Ensures:
  *      0:        *pattrs contains the node's current attributes.
@@ -363,7 +339,6 @@ extern int node_get_attr(struct node_object *hnode,
  *              Error occurred while trying to retrieve a message.
  *      -ETIME:   Timeout occurred and no message is available.
  *  Requires:
- *      node_init(void) called.
  *      message !=3D NULL.
  *  Ensures:
  */
@@ -386,17 +361,6 @@ extern int node_get_nldr_obj(struct node_mgr *hnod=
e_mgr,
 				    struct nldr_object **nldr_ovlyobj);
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D node_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize the NODE module.
- *  Parameters:
- *  Returns:
- *      TRUE if initialization succeeded, FALSE otherwise.
- *  Ensures:
- */
-extern bool node_init(void);
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D node_on_exit =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Gets called when RMS_EXIT is received for a node. PROC needs t=
o pass
@@ -425,7 +389,6 @@ void node_on_exit(struct node_object *hnode, s32 no=
de_status);
  *      -ETIME:       A timeout occurred before the DSP responded.
  *      DSP_EWRONGSTSATE:   Node is not in NODE_RUNNING state.
  *  Requires:
- *      node_init(void) called.
  *  Ensures:
  */
 extern int node_pause(struct node_object *hnode);
@@ -449,7 +412,6 @@ extern int node_pause(struct node_object *hnode);
  *      -ETIME:       Timeout occurred before message could be set.
  *      -EBADR:    Node is in invalid state for sending messages.
  *  Requires:
- *      node_init(void) called.
  *      pmsg !=3D NULL.
  *  Ensures:
  */
@@ -473,7 +435,6 @@ extern int node_put_message(struct node_object *hno=
de,
  *      -ENOSYS:   Notification type specified by notify_type is not
  *                      supported.
  *  Requires:
- *      node_init(void) called.
  *      hnotification !=3D NULL.
  *  Ensures:
  */
@@ -500,7 +461,6 @@ extern int node_register_notify(struct node_object =
*hnode,
  *      DSP_EWRONGSTSATE:   Node is not in NODE_PAUSED or NODE_CREATED=
 state.
  *      -ESPIPE:        Execute function not found in the COFF file.
  *  Requires:
- *      node_init(void) called.
  *  Ensures:
  */
 extern int node_run(struct node_object *hnode);
@@ -523,7 +483,6 @@ extern int node_run(struct node_object *hnode);
  *              Unable to terminate the node.
  *      -EBADR:    Operation not valid for the current node state.
  *  Requires:
- *      node_init(void) called.
  *      pstatus !=3D NULL.
  *  Ensures:
  */
diff --git a/drivers/staging/tidspbridge/include/dspbridge/nodepriv.h b=
/drivers/staging/tidspbridge/include/dspbridge/nodepriv.h
index 9c1e067..d5b54bb 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/nodepriv.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/nodepriv.h
@@ -96,7 +96,6 @@ struct node_createargs {
  *      -EINVAL:     The node's stream corresponding to index and dir
  *                      is not a stream to or from the host.
  *  Requires:
- *      node_init(void) called.
  *      Valid dir.
  *      chan_id !=3D NULL.
  *  Ensures:
diff --git a/drivers/staging/tidspbridge/pmgr/dspapi.c b/drivers/stagin=
g/tidspbridge/pmgr/dspapi.c
index 7c20a0f..a5f1f65 100644
--- a/drivers/staging/tidspbridge/pmgr/dspapi.c
+++ b/drivers/staging/tidspbridge/pmgr/dspapi.c
@@ -273,7 +273,6 @@ void api_exit(void)
 		io_exit();
 		strm_exit();
 		disp_exit();
-		node_exit();
 		mgr_exit();
 		rmm_exit();
 	}
@@ -288,12 +287,11 @@ bool api_init(void)
 {
 	bool ret =3D true;
 	bool fdev, fchnl, fmsg, fio;
-	bool fmgr, fnode, fdisp, fstrm, frmm;
+	bool fmgr, fdisp, fstrm, frmm;
=20
 	if (api_c_refs =3D=3D 0) {
 		/* initialize driver and other modules */
 		fmgr =3D mgr_init();
-		fnode =3D node_init();
 		fdisp =3D disp_init();
 		fstrm =3D strm_init();
 		frmm =3D rmm_init();
@@ -311,9 +309,6 @@ bool api_init(void)
 			if (fstrm)
 				strm_exit();
=20
-			if (fnode)
-				node_exit();
-
 			if (fdisp)
 				disp_exit();
=20
diff --git a/drivers/staging/tidspbridge/rmgr/node.c b/drivers/staging/=
tidspbridge/rmgr/node.c
index 1b24589..908cd1e 100644
--- a/drivers/staging/tidspbridge/rmgr/node.c
+++ b/drivers/staging/tidspbridge/rmgr/node.c
@@ -261,8 +261,6 @@ static u32 ovly(void *priv_ref, u32 dsp_run_addr, u=
32 dsp_load_addr,
 static u32 mem_write(void *priv_ref, u32 dsp_add, void *pbuf,
 		     u32 ul_num_bytes, u32 mem_space);
=20
-static u32 refs;		/* module reference count */
-
 /* Dynamic loader functions. */
 static struct node_ldr_fxns nldr_fxns =3D {
 	nldr_allocate,
@@ -1569,16 +1567,6 @@ func_end:
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D node_exit =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Discontinue usage of NODE module.
- */
-void node_exit(void)
-{
-	refs--;
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D node_free_msg_buf =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Frees the message buffer.
@@ -1852,18 +1840,6 @@ enum node_type node_get_type(struct node_object =
*hnode)
 }
=20
 /*
- *  =3D=3D=3D=3D=3D=3D=3D=3D node_init =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Initialize the NODE module.
- */
-bool node_init(void)
-{
-	refs++;
-
-	return true;
-}
-
-/*
  *  =3D=3D=3D=3D=3D=3D=3D=3D node_on_exit =3D=3D=3D=3D=3D=3D=3D=3D
  *  Purpose:
  *      Gets called when RMS_EXIT is received for a node.
--=20
1.7.9.1
