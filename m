From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] adding back some features
Date: Mon, 15 Jun 2009 09:05:32 -0700
Message-ID: <87k53da3eb.fsf@deeprootsystems.com>
References: <1244844693-24126-1-git-send-email-khilman@ti.deeprootsystems.com>
	<20090615080001.GC4474@atomide.com>
	<87ski1a6n1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:44715 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007AbZFOQFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 12:05:33 -0400
Received: by pxi27 with SMTP id 27so314523pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 09:05:36 -0700 (PDT)
In-Reply-To: <87ski1a6n1.fsf@deeprootsystems.com> (Kevin Hilman's message of "Mon\, 15 Jun 2009 07\:55\:30 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Tony Lindgren <tony@atomide.com> writes:
>
>> Hi,
>>
>> * Kevin Hilman <khilman@deeprootsystems.com> [090612 15:13]:
>>> Here's a couple patches to add-back some feature dropped in the
>>> mainline sync.  These are needed for the PM branch among other things.
>>> 
>>> Applies to linux-omap master.
>>> 
>>> Kevin Hilman (1):
>>>   OMAP2/3: SoC IDs: add omap_type() for determining GP/EMU/HS
>>
>> Is there any reason to get this one into mainline early?
>
> Well, the PM branch has a dependency, but also the recenetly submitted
> qwatchdog driver has a dependency.
>
>> If not, I suggest you keep this in your pm branch for next merge
>> window that I can keep merging to l-o master as needed.
>>
>> However, if omap_type() is by other queues earlier, then I can
>> add it into my upstream queue. If this blocks several queues
>> from being rebased against mainline kernel, that alone might
>> already be a good enough reason to get it in early.
>
> I think it should go via your upstream queue.  I imagine some of the
> other upcoming driver submissions from TI will have a dependency as
> well since there is still some missing EMU/HS support ind drivers.

Also, I'm carrying this SRAM patch below for HS/EMU that could go into
Paul's SRAM/SDRC queue if this omap_type() gets merged sooner rather
than later.

Kevin

commit 106588e30f070d9a8d5906d409e0b9aad89edc9e
Author: Tero Kristo <tero.kristo@nokia.com>
Date:   Thu Oct 9 17:47:02 2008 +0300

    OMAP3: SRAM size fix for HS/EMU devices
    
    Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
    Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
old mode 100644
new mode 100755
index 65006df..f40bd2d
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -131,9 +131,15 @@ void __init omap_detect_sram(void)
 	if (cpu_class_is_omap2()) {
 		if (is_sram_locked()) {
 			if (cpu_is_omap34xx()) {
-				omap_sram_base = OMAP3_SRAM_PUB_VA;
-				omap_sram_start = OMAP3_SRAM_PUB_PA;
-				omap_sram_size = 0x8000; /* 32K */
+				if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
+					omap_sram_base = OMAP3_SRAM_PUB_VA;
+					omap_sram_start = OMAP3_SRAM_PUB_PA;
+					omap_sram_size = 0x8000; /* 32K */
+				} else {
+					omap_sram_base = OMAP3_SRAM_PUB_VA;
+					omap_sram_start = OMAP3_SRAM_PUB_PA;
+					omap_sram_size = 0x7000; /* 28K */
+				}
 			} else {
 				omap_sram_base = OMAP2_SRAM_PUB_VA;
 				omap_sram_start = OMAP2_SRAM_PUB_PA;
