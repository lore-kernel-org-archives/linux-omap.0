From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [PATCH] DSPBRIDGE:Change dev_type to u8
Date: Sat, 3 Apr 2010 18:28:09 +0530
Message-ID: <830E2177532E7946BE0E82F0F4288505044E450B96@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54347 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611Ab0DCM6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Apr 2010 08:58:17 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o33CwB4Z005619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 07:58:14 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o33Cw9OT010507
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 18:28:10 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From e2327644af26aaf22ca6a6b987b745c60e02ab4a Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 19 Mar 2010 12:58:23 -0600
Subject: [PATCH] DSPBRIDGE:Change dev_type to u8

dev_type can take one of the 2 values
DSP_UNIT    0
IVA_UNIT    1
So it need not be s32 or u32. Hence changing it to u8.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dev.h |    2 +-
 drivers/dsp/bridge/pmgr/dev.c              |    4 ++--
 drivers/dsp/bridge/pmgr/wcd.c              |    2 +-
 drivers/dsp/bridge/rmgr/disp.c             |    8 ++++----
 drivers/dsp/bridge/rmgr/mgr.c              |    4 ++--
 drivers/dsp/bridge/rmgr/node.c             |    2 +-
 drivers/dsp/bridge/rmgr/proc.c             |   10 +++++-----
 drivers/dsp/bridge/wmd/io_sm.c             |    2 +-
 8 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 13b0cad..417af59 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -355,7 +355,7 @@ extern dsp_status dev_get_dev_node(struct dev_object *hdev_obj,
  *      else:           *phDevNode is NULL.
  */
 extern dsp_status dev_get_dev_type(struct dev_object *hdevObject,
-       u32 *dev_type);
+     u8 *dev_type);
 
 /*
  *  ======== dev_get_first ========
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 5bc16e9..2470264 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -64,7 +64,7 @@
 struct dev_object {
  /* LST requires "link" to be first field! */
  struct list_head link; /* Link to next dev_object. */
- u32 dev_type;  /* Device Type */
+ u8 dev_type;  /* Device Type */
  u32 dw_signature; /* Used for object validation. */
  struct cfg_devnode *dev_node_obj; /* Platform specific dev id */
  struct wmd_dev_context *hwmd_context; /* WMD Context Handle */
@@ -1072,7 +1072,7 @@ dsp_status dev_remove_proc_object(struct dev_object *hdev_obj, u32 proc_obj)
  return status;
 }
 
-dsp_status dev_get_dev_type(struct dev_object *hdevObject, u32 *dev_type)
+dsp_status dev_get_dev_type(struct dev_object *hdevObject, u8 *dev_type)
 {
  dsp_status status = DSP_SOK;
  struct dev_object *dev_obj = (struct dev_object *)hdevObject;
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index f30e023..88dd3db 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -381,7 +381,7 @@ dsp_status wcd_init_complete2(void)
  dsp_status status = DSP_SOK;
  struct cfg_devnode *dev_node;
  struct dev_object *hdev_obj;
- u32 dev_type;
+ u8 dev_type;
 
  DBC_REQUIRE(wcd_c_refs > 0);
 
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 8a3b9d5..d8e0c84 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -100,7 +100,7 @@ dsp_status disp_create(OUT struct disp_object **phDispObject,
  u32 ul_chnl_id;
  struct chnl_attr chnl_attr_obj;
  dsp_status status = DSP_SOK;
- u32 dev_type;
+ u8 dev_type;
 
  DBC_REQUIRE(refs > 0);
  DBC_REQUIRE(phDispObject != NULL);
@@ -283,7 +283,7 @@ dsp_status disp_node_create(struct disp_object *disp_obj,
  u32 max;
  dsp_status status = DSP_SOK;
  struct dsp_nodeinfo node_info;
- u32 dev_type;
+ u8 dev_type;
 
  DBC_REQUIRE(refs > 0);
  DBC_REQUIRE(MEM_IS_VALID_HANDLE(disp_obj, DISP_SIGNATURE));
@@ -498,7 +498,7 @@ dsp_status disp_node_delete(struct disp_object *disp_obj,
  u32 dw_arg;
  struct rms_command *rms_cmd;
  dsp_status status = DSP_SOK;
- u32 dev_type;
+ u8 dev_type;
 
  DBC_REQUIRE(refs > 0);
  DBC_REQUIRE(MEM_IS_VALID_HANDLE(disp_obj, DISP_SIGNATURE));
@@ -552,7 +552,7 @@ dsp_status disp_node_run(struct disp_object *disp_obj,
  u32 dw_arg;
  struct rms_command *rms_cmd;
  dsp_status status = DSP_SOK;
- u32 dev_type;
+ u8 dev_type;
  DBC_REQUIRE(refs > 0);
  DBC_REQUIRE(MEM_IS_VALID_HANDLE(disp_obj, DISP_SIGNATURE));
  DBC_REQUIRE(hnode != NULL);
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index cece9da..d02f50c 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -200,7 +200,7 @@ dsp_status mgr_enum_processor_info(u32 processor_id,
  struct mgr_processorextinfo *ext_info;
  struct dev_object *hdev_obj;
  struct drv_object *hdrv_obj;
- s32 dev_type;
+ u8 dev_type;
  struct cfg_devnode *dev_node;
  struct cfg_dspres chip_resources;
  bool proc_detect = false;
@@ -215,7 +215,7 @@ dsp_status mgr_enum_processor_info(u32 processor_id,
  if (DSP_SUCCEEDED(status)) {
   status = drv_get_dev_object(processor_id, hdrv_obj, &hdev_obj);
   if (DSP_SUCCEEDED(status)) {
-   status = dev_get_dev_type(hdev_obj, (u32 *) &dev_type);
+   status = dev_get_dev_type(hdev_obj, (u8 *) &dev_type);
    status = dev_get_dev_node(hdev_obj, &dev_node);
    if (dev_type == DSP_UNIT)
     status = cfg_get_dsp_resources(dev_node,
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 825ca60..a761eb0 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1314,7 +1314,7 @@ dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
  char *sz_zl_file = "";
  struct nldr_attrs nldr_attrs_obj;
  dsp_status status = DSP_SOK;
- u32 dev_type;
+ u8 dev_type;
  DBC_REQUIRE(refs > 0);
  DBC_REQUIRE(phNodeMgr != NULL);
  DBC_REQUIRE(hdev_obj != NULL);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index e100d31..d664f96 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -121,7 +121,7 @@ proc_attach(u32 processor_id,
  struct proc_object *p_proc_object = NULL;
  struct mgr_object *hmgr_obj = NULL;
  struct drv_object *hdrv_obj = NULL;
- u32 dev_type;
+ u8 dev_type;
 
  DBC_REQUIRE(refs > 0);
  DBC_REQUIRE(ph_processor != NULL);
@@ -226,10 +226,10 @@ static dsp_status get_exec_file(struct cfg_devnode *dev_node_obj,
     struct dev_object *hdev_obj,
     u32 size, char *execFile)
 {
- s32 dev_type;
+ u8 dev_type;
  s32 len;
 
- dev_get_dev_type(hdev_obj, (u32 *) &dev_type);
+ dev_get_dev_type(hdev_obj, (u8 *) &dev_type);
  if (dev_type == DSP_UNIT) {
   return cfg_get_exec_file(dev_node_obj, size, execFile);
  } else if (dev_type == IVA_UNIT) {
@@ -265,7 +265,7 @@ dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
  char sz_exec_file[MAXCMDLINELEN];
  char *argv[2];
  struct mgr_object *hmgr_obj = NULL;
- s32 dev_type;
+ u8 dev_type;
 
  DBC_REQUIRE(refs > 0);
  DBC_REQUIRE(dev_node_obj != NULL);
@@ -302,7 +302,7 @@ dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
   goto func_cont;
  }
  /* Get the default executable for this board... */
- dev_get_dev_type(hdev_obj, (u32 *) &dev_type);
+ dev_get_dev_type(hdev_obj, (u8 *) &dev_type);
  p_proc_object->processor_id = dev_type;
  status = get_exec_file(dev_node_obj, hdev_obj, sizeof(sz_exec_file),
           sz_exec_file);
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 7010f53..867402f 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -178,7 +178,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
  struct cfg_hostres host_res;
  struct cfg_devnode *dev_node_obj;
  struct chnl_mgr *hchnl_mgr;
- u32 dev_type;
+ u8 dev_type;
 
  /* Check requirements */
  if (!phIOMgr || !pMgrAttrs || pMgrAttrs->word_size == 0) {
-- 
1.6.0.4