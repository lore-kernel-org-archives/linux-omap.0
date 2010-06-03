From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 32/40] DSPBRIDGE: err code replace DSP_ESYMBOL with ESPIPE
Date: Thu,  3 Jun 2010 00:47:45 -0500
Message-ID: <1275544073-20418-33-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44888 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555Ab0FCF4W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:22 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_ESYMBOL with ESPIPE

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/node.h     |    8 ++++----
 drivers/dsp/bridge/rmgr/nldr.c                  |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
index e5108b4..9ab99d3 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
@@ -214,7 +214,7 @@ typedef void (*nldr_freefxn) (struct nldr_nodeobject *nldr_node_obj);
  *      pulAddr:        Location to store function address.
  *  Returns:
  *      0:        Success.
- *      DSP_ESYMBOL:    Address of function not found.
+ *      -ESPIPE:    Address of function not found.
  *  Requires:
  *      nldr_init(void) called.
  *      Valid nldr_node_obj.
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index bcfc65c..2f76c04 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -41,7 +41,7 @@
  *      0:            Success.
  *      -ENOMEM:        Insufficient memory on GPP.
  *      -ENOKEY:          Node UUID has not been registered.
- *      DSP_ESYMBOL:        iAlg functions not found for a DAIS node.
+ *      -ESPIPE:        iAlg functions not found for a DAIS node.
  *      -EDOM:         attr_in != NULL and attr_in->prio out of
  *                          range.
  *      -EPERM:          A failure occured, unable to allocate node.
@@ -199,7 +199,7 @@ extern dsp_status node_connect(struct node_object *hNode1,
  *  Returns:
  *      0:            Success.
  *      -EFAULT:        Invalid hnode.
- *      DSP_ESYMBOL:        Create function not found in the COFF file.
+ *      -ESPIPE:        Create function not found in the COFF file.
  *      DSP_EWRONGSTATE:    Node is not in the NODE_ALLOCATED state.
  *      -ENOMEM:        Memory allocation failure on the DSP.
  *      DSP_ETASK:          Unable to create node's task or process on the DSP.
@@ -255,7 +255,7 @@ extern dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
  *      DSP_EDELETE:        A deletion failure occurred.
  *      DSP_EUSER1-16:      Node specific failure occurred on the DSP.
  *      -EPERM:          A failure occurred in deleting the node.
- *      DSP_ESYMBOL:        Delete function not found in the COFF file.
+ *      -ESPIPE:        Delete function not found in the COFF file.
  *  Requires:
  *      node_init(void) called.
  *  Ensures:
@@ -522,7 +522,7 @@ extern dsp_status node_register_notify(struct node_object *hnode,
  *      -ETIME:       A timeout occurred before the DSP responded.
  *      DSP_EWRONGSTSATE:   Node is not in NODE_PAUSED or NODE_CREATED state.
  *      -EPERM:          Unable to start or resume execution.
- *      DSP_ESYMBOL:        Execute function not found in the COFF file.
+ *      -ESPIPE:        Execute function not found in the COFF file.
  *  Requires:
  *      node_init(void) called.
  *  Ensures:
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index d2cd465..f5b7239 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -764,7 +764,7 @@ dsp_status nldr_get_fxn_addr(struct nldr_nodeobject *nldr_node_obj,
 	if (status1)
 		*pulAddr = dbll_sym->value;
 	else
-		status = DSP_ESYMBOL;
+		status = -ESPIPE;
 
 	return status;
 }
@@ -1992,7 +1992,7 @@ dsp_status nldr_find_addr(struct nldr_nodeobject *nldr_node, u32 sym_addr,
 	if (!status1) {
 		pr_debug("%s: Address 0x%x not found in range %d.\n",
 					__func__, sym_addr, offset_range);
-		status = DSP_ESYMBOL;
+		status = -ESPIPE;
 	}
 
 	return status;
-- 
1.7.1

