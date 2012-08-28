From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] arm: omap: ratelimit omap_l3_smx error log spam
Date: Wed, 29 Aug 2012 02:09:17 +0300
Message-ID: <20120828230917.GD783@harshnoise.musicnaut.iki.fi>
References: <1346101403-5882-1-git-send-email-aaro.koskinen@iki.fi>
 <CAMQu2gyEctrq_3K8W6VahMW-ODOiv7TjrBfPTkZqNGJ+0m9ozw@mail.gmail.com>
 <20120827220254.GA783@harshnoise.musicnaut.iki.fi>
 <CAMQu2gz9HE0xEoW7gu257rpLWdCUpt7N6GQNQzWVhFb-A+69hg@mail.gmail.com>
 <20120827232613.GB783@harshnoise.musicnaut.iki.fi>
 <CAMQu2gwHp3PgB-TqPTNWcbRuXRT0wjfvF99nYqfDyWr1GiUvCg@mail.gmail.com>
 <20120828122042.GC783@harshnoise.musicnaut.iki.fi>
 <CAMQu2gwMk68_BNc4O0M52OACUVLLGzRCQe+5mGH_40DrwAQ4KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:48255 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab2H1XJn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Aug 2012 19:09:43 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gwMk68_BNc4O0M52OACUVLLGzRCQe+5mGH_40DrwAQ4KA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, Aug 28, 2012 at 07:19:38AM -0700, Shilimkar, Santosh wrote:
> Or the PPA has resized the secure area of 16K. As you have seen the issue
> on one OMAP3 device, it makes sense to takeout that 16K from the public
> SRAM map.
> 
> Can you send the patch with fixed base address fir PUB SRAM ?

Maybe I'm missing something, but I tried the following and now something
else got broken:

	save_secure_sram() returns 0000ff02

(and it hangs there).

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 766181c..242ea5b 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -38,7 +38,7 @@
 
 #define OMAP1_SRAM_PA		0x20000000
 #define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
-#define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
+#define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0xc000)
 #ifdef CONFIG_OMAP4_ERRATA_I688
 #define OMAP4_SRAM_PUB_PA	OMAP4_SRAM_PA
 #else
@@ -112,9 +112,9 @@ static void __init omap_detect_sram(void)
 				omap_sram_start = OMAP3_SRAM_PUB_PA;
 				if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
 				    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
-					omap_sram_size = 0x7000; /* 28K */
+					omap_sram_size = 0x3000; /* 12K */
 				} else {
-					omap_sram_size = 0x8000; /* 32K */
+					omap_sram_size = SZ_16K; /* 16K */
 				}
 			} else if (cpu_is_omap44xx()) {
 				omap_sram_start = OMAP4_SRAM_PUB_PA;
