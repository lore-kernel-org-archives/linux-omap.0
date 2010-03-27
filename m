From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH v1 1/19] DSPBRIDGE: Cleanup custom error
 code(DSP_EALREADYCONNECTED ->-EISCONN)
Date: Sat, 27 Mar 2010 07:56:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEE07@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39500 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab0C0C1D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 22:27:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2R2R0ma006197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 21:27:03 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2R2R0L1026473
	for <linux-omap@vger.kernel.org>; Sat, 27 Mar 2010 07:57:00 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 0c883100634921b732c0b1bd149fec08080fbace Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 09:10:22 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code(DSP_EALREADYCONNECTED ->-EISCONN)

This patch replaces DSP_EALREADYCONNECTED with -EISCONN

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/rmgr/node.c                 |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index d43ff86..a2fa786 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -69,9 +69,6 @@
 /* The caller does not have access privileges to call this function */
 #define DSP_EACCESSDENIED           (DSP_EBASE + 0)
 
-/* The Specified Connection already exists */
-#define DSP_EALREADYCONNECTED       (DSP_EBASE + 1)
-
 /* The GPP must be detached from the DSP before this function is called */
 #define DSP_EATTACHED               (DSP_EBASE + 2)
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index c18539d..86035a1 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -933,7 +933,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
 			    &(hNode1->create_args.asa.
 			      task_arg_obj.strm_out_def[uStream1]);
 			if (output->sz_device != NULL)
-				status = DSP_EALREADYCONNECTED;
+				status = -EISCONN;
 
 		}
 		if (node2_type == NODE_TASK || node2_type == NODE_DAISSOCKET) {
@@ -941,7 +941,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
 			    &(hNode2->create_args.asa.
 			      task_arg_obj.strm_in_def[uStream2]);
 			if (input->sz_device != NULL)
-				status = DSP_EALREADYCONNECTED;
+				status = -EISCONN;
 
 		}
 	}
-- 
1.6.0.4

