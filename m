From: Peter Barada <peter.barada@gmail.com>
Subject: Re: Module + offset calculations have to be signed in arch/arm/mach-omap2/pm-debug.c
Date: Fri, 06 May 2011 11:25:33 -0400
Message-ID: <4DC412ED.1070805@gmail.com>
References: <4DC2CED3.80206@gmail.com> <87liyljcnd.fsf@ti.com>	<4DC2DC03.4020200@gmail.com> <87oc3hf1wk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080905080500070900040505"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37827 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab1EFPZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 11:25:27 -0400
Received: by gyd10 with SMTP id 10so1199965gyd.19
        for <linux-omap@vger.kernel.org>; Fri, 06 May 2011 08:25:26 -0700 (PDT)
In-Reply-To: <87oc3hf1wk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080905080500070900040505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/05/2011 02:16 PM, Kevin Hilman wrote:
>
> In any case, you've found a real bug, and your patch is valid.  However,
> it doesn't currently apply to mainline, and it looks like it's because
> your patch is using spaces and the code being patched is using tabs.
>
> Also, you can simplify the changelog to to just describe the fix needed
> due to using negative offsets in some PRM modules.
I've attached a new patch to fix the tabs/changelog.

-- 
Peter Barada
peter.barada@gmail.com


--------------080905080500070900040505
Content-Type: text/x-patch;
 name="pm-debug-signed-offset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pm-debug-signed-offset.patch"

>From 6857bb52af1fcd90e64d3e6c45de3ff0f071be7a Mon Sep 17 00:00:00 2001
From: Peter Barada <peter.barada@logicpd.com>
Date: Fri, 6 May 2011 11:07:50 -0400
Subject: [PATCH] Make offset in pm_module_def signed to allow negative offsets.

Since PRM module offsets can be negative (IVA2 is -0x800), offset in
pm_module_def struct has to be signed.

---
 arch/arm/mach-omap2/pm-debug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git b/arch/arm/mach-omap2/pm-debug.c a/arch/arm/mach-omap2/pm-debug.c
index b731ef3..125f565 100644
--- b/arch/arm/mach-omap2/pm-debug.c
+++ a/arch/arm/mach-omap2/pm-debug.c
@@ -199,7 +199,7 @@ enum {
 struct pm_module_def {
 	char name[8]; /* Name of the module */
 	short type; /* CM or PRM */
-	short offset;
+	unsigned short offset;
 	int low; /* First register address on this module */
 	int high; /* Last register address on this module */
 };
-- 
1.7.1


--------------080905080500070900040505--
