From: Peter Barada <peter.barada@gmail.com>
Subject: Module + offset calculations have to be signed in arch/arm/mach-omap2/pm-debug.c
Date: Thu, 05 May 2011 12:22:43 -0400
Message-ID: <4DC2CED3.80206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35563 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393Ab1EEQWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 12:22:37 -0400
Received: by gyd10 with SMTP id 10so812436gyd.19
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 09:22:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I've been working on getting the TI OMAPPSP-03.00.01.06 kernel to 
properly suspend/resume on my DM37x board and all was going well until I 
added OTG support to the kernel and on suspend, the IVA2 and CORE pwrdms 
would not properly go into suspend.  When comparing output from 
/debug/pm-debug/registers/current to the TRM, I noticed the following:

MOD: CM_IVA2 (48014000)
   04 => 00000017  20 => 00000001  24 => 00000001  34 => 00000001
   40 => 00080a00  44 => 00000001  48 => 00000003
MOD: PRM_IVA2 (48316000)
   50 => 00000007  e0 => 00ff0f05  e4 => 00000ff7  e8 => 00000ff7
   f8 => 00000001

Looking at the TRM, the PRM_IVA2 registers are at 0x48306000, not 
0x48316000.  OMAP3430_IVA2_MOD is defined in prcm-common.h as -0x800 
which means any module + reg_offset address calculation has to be 
signed.  Once I corrected the "unsigned short offset" declaration in 
pm_module_def, rebuilt and tested again, IVA2/core pwrdms go into 
suspend correctly (and addresses look correct):


Signed-off-by: Peter Barada <peter.barada@logicpd.com>


diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 125f565..b731ef3 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -199,7 +199,7 @@ enum {
  struct pm_module_def {
      char name[8]; /* Name of the module */
      short type; /* CM or PRM */
-    unsigned short offset;
+    short offset;
      int low; /* First register address on this module */
      int high; /* Last register address on this module */
  };

-- 
Peter Barada
peter.barada@gmail.com

