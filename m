From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [PATCH] DSPBRIDGE: Change num_proc type to u8.
Date: Sat, 3 Apr 2010 18:30:51 +0530
Message-ID: <830E2177532E7946BE0E82F0F4288505044E450B9B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54425 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604Ab0DCNA5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Apr 2010 09:00:57 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o33D0rBS005784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 08:00:56 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o33D0qlX010835
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 18:30:52 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 1203012297c7b0a6a36f000a870c5e1210a233e1 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 19 Mar 2010 17:29:46 -0600
Subject: [PATCH] DSPBRIDGE: Change num_proc type to u8.

num_proc is used to represent number of processors.
As of now its 1. Also it can not be > 256.
So changing it to u8.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c  |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 88dd3db..cd9db42 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -447,7 +447,7 @@ u32 mgrwrap_enum_node_info(union Trapped_Args *args, void *pr_ctxt)
 u32 mgrwrap_enum_proc_info(union Trapped_Args *args, void *pr_ctxt)
 {
  u8 *processor_info;
- u32 num_procs;
+ u8 num_procs;
  dsp_status status = DSP_SOK;
  u32 size = args->args_mgr_enumproc_info.processor_info_size;
 
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 867402f..91d67d1 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -320,7 +320,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
  u32 ul_pad_size = 0;
  u32 i;
  dsp_status status = DSP_SOK;
- u32 num_procs = 0;
+ u8 num_procs = 0;
  s32 ndx = 0;
  /* DSP MMU setup table */
  struct wmdioctl_extproc ae_proc[WMDIOCTL_NUMOFMMUTLB];
-- 
1.6.0.4