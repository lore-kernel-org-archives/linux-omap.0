From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH v3 1/2] OMAP3: SDRC: Dynamic Calculation of SDRC stall
 latency during DVFS
Date: Thu, 11 Mar 2010 22:06:42 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9EB98BBE9@dnce01.ent.ti.com>
References: <1268307297-23330-1-git-send-email-pramod.gurav@ti.com>
 <1268307297-23330-2-git-send-email-pramod.gurav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51517 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab0CKVGq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 16:06:46 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2BL6k0k017197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 15:06:46 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o2BL6jUT018218
	for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 15:06:45 -0600 (CST)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2BL6jJR008351
	for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 15:06:45 -0600 (CST)
Content-Class: urn:content-classes:message
In-Reply-To: <1268307297-23330-2-git-send-email-pramod.gurav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Reddy, Teerth" <teerth@ti.com>, Romit Dasgupta <romit@ti.com>, "Gurav , Pramod" <pramod.gurav@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Pramod Gurav
>

[snip]

>diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
>index de99ba2..00da20a 100644
>--- a/arch/arm/mach-omap2/sram34xx.S
>+++ b/arch/arm/mach-omap2/sram34xx.S
>@@ -313,3 +313,14 @@ core_m2_mask_val:
> ENTRY(omap3_sram_configure_core_dpll_sz)
>       .word   . - omap3_sram_configure_core_dpll
>
>+ENTRY(__sram_wait_delay)
>+      stmfd   sp!, {lr}               @ store return addr to stack
>+
>+      loop1:
>+      subs    r0, r0, #1              @ loop till counter = 0
>+      bne     loop1
>+
>+      ldmfd   sp!, {pc}               @ restore return address
>+

If I remember well from my old ARM ASM days, you can even preserve the stack and one instruction in that case using the "mov pc, lr"

ENTRY(__sram_wait_delay)
        subs    r0, r0, #1              @ loop till counter = 0
        bne     __sram_wait_delay

        mov     pc, lr


Regards,
Benoit

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



