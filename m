From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v2 2/3] staging: tidspbridge: mgr_enum_node_info cleanup
Date: Fri,  5 Nov 2010 17:15:47 +0200
Message-ID: <1288970148-22191-3-git-send-email-ionut.nicu@mindbit.ro>
References: <1288970148-22191-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39839 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab0KEPQI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 11:16:08 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2759744bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 08:16:07 -0700 (PDT)
In-Reply-To: <1288970148-22191-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Reorganized mgr_enum_node_info code to increase its
readability.

Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
---
 drivers/staging/tidspbridge/rmgr/mgr.c |   51 ++++++++++----------------------
 1 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/mgr.c b/drivers/staging/tidspbridge/rmgr/mgr.c
index 2eab6a5..16410a5 100644
--- a/drivers/staging/tidspbridge/rmgr/mgr.c
+++ b/drivers/staging/tidspbridge/rmgr/mgr.c
@@ -134,8 +134,7 @@ int mgr_enum_node_info(u32 node_id, struct dsp_ndbprops *pndb_props,
 			      u32 undb_props_size, u32 *pu_num_nodes)
 {
 	int status = 0;
-	struct dsp_uuid node_uuid, temp_uuid;
-	u32 temp_index = 0;
+	struct dsp_uuid node_uuid;
 	u32 node_index = 0;
 	struct dcd_genericobj gen_obj;
 	struct mgr_object *pmgr_obj = NULL;
@@ -149,24 +148,27 @@ int mgr_enum_node_info(u32 node_id, struct dsp_ndbprops *pndb_props,
 	*pu_num_nodes = 0;
 	/* Get the Manager Object from the driver data */
 	if (!drv_datap || !drv_datap->mgr_object) {
-		status = -ENODATA;
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
-		goto func_cont;
-	} else {
-		pmgr_obj = drv_datap->mgr_object;
+		return -ENODATA;
 	}
+	pmgr_obj = drv_datap->mgr_object;
 
 	DBC_ASSERT(pmgr_obj);
 	/* Forever loop till we hit failed or no more items in the
 	 * Enumeration. We will exit the loop other than 0; */
-	while (status == 0) {
-		status = dcd_enumerate_object(temp_index++, DSP_DCDNODETYPE,
-					      &temp_uuid);
-		if (status == 0) {
-			node_index++;
-			if (node_id == (node_index - 1))
-				node_uuid = temp_uuid;
-
+	while (!status) {
+		status = dcd_enumerate_object(node_index++, DSP_DCDNODETYPE,
+				&node_uuid);
+		if (status)
+			break;
+		*pu_num_nodes = node_index;
+		if (node_id == (node_index - 1)) {
+			status = dcd_get_object_def(pmgr_obj->hdcd_mgr,
+					&node_uuid, DSP_DCDNODETYPE, &gen_obj);
+			if (status)
+				break;
+			/* Get the Obj def */
+			*pndb_props = gen_obj.obj_data.node_obj.ndb_props;
 		}
 	}
 
@@ -174,27 +176,6 @@ int mgr_enum_node_info(u32 node_id, struct dsp_ndbprops *pndb_props,
 	if (status > 0)
 		status = 0;
 
-	if (!status) {
-		if (node_id > (node_index - 1)) {
-			status = -EINVAL;
-		} else {
-			status = dcd_get_object_def(pmgr_obj->hdcd_mgr,
-						    (struct dsp_uuid *)
-						    &node_uuid, DSP_DCDNODETYPE,
-						    &gen_obj);
-			if (!status) {
-				/* Get the Obj def */
-				*pndb_props =
-				    gen_obj.obj_data.node_obj.ndb_props;
-				*pu_num_nodes = node_index;
-			}
-		}
-	}
-
-func_cont:
-	DBC_ENSURE((!status && *pu_num_nodes > 0) ||
-		   (status && *pu_num_nodes == 0));
-
 	return status;
 }
 
-- 
1.7.2.3

