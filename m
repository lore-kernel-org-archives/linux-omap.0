From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: ARM: CONFIG_FRAME_POINTER
Date: Wed, 13 May 2009 10:42:29 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A87396A1DF6@dlee01.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com>
 <87zldhaoco.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52762 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbZEMPmf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 11:42:35 -0400
In-Reply-To: <87zldhaoco.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,
 
> Did a similar patch for ARM get you a booting kernel using 2007q3?

Yes, the changes needed are the following to get it booting with 2007q3 on the omap3430sdp were the following. Unfortunately it took 4 hours to figure this out and so wanted to share. 

Do you think that the below change should be incorporate in the arch/arm/Kconfig?

Cheers
Jon


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 079aa6a..c61bafb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,6 +18,7 @@ config ARM
        select HAVE_KRETPROBES if (HAVE_KPROBES)
        select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
        select HAVE_GENERIC_DMA_COHERENT
+       select ARCH_WANT_FRAME_POINTERS
        help
          The ARM series is a line of low-power-consumption RISC chip designs
          licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index b686f34..1bff450 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1387,6 +1387,7 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_MEMORY_INIT is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
+CONFIG_ARCH_WANT_FRAME_POINTERS=y
 CONFIG_FRAME_POINTER=y
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
