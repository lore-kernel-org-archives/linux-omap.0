From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] arm: omap: ratelimit omap_l3_smx error log spam
Date: Wed, 29 Aug 2012 03:23:03 +0300
Message-ID: <20120829002256.GE783@harshnoise.musicnaut.iki.fi>
References: <1346101403-5882-1-git-send-email-aaro.koskinen@iki.fi>
 <CAMQu2gyEctrq_3K8W6VahMW-ODOiv7TjrBfPTkZqNGJ+0m9ozw@mail.gmail.com>
 <20120827220254.GA783@harshnoise.musicnaut.iki.fi>
 <CAMQu2gz9HE0xEoW7gu257rpLWdCUpt7N6GQNQzWVhFb-A+69hg@mail.gmail.com>
 <20120827232613.GB783@harshnoise.musicnaut.iki.fi>
 <CAMQu2gwHp3PgB-TqPTNWcbRuXRT0wjfvF99nYqfDyWr1GiUvCg@mail.gmail.com>
 <20120828122042.GC783@harshnoise.musicnaut.iki.fi>
 <CAMQu2gwMk68_BNc4O0M52OACUVLLGzRCQe+5mGH_40DrwAQ4KA@mail.gmail.com>
 <20120828230917.GD783@harshnoise.musicnaut.iki.fi>
 <CAMQu2gxdXXa27yAYL4yEkBci7pAKH+FNjDWp8-Y86zxdqndO0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:36838 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab2H2AXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Aug 2012 20:23:31 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gxdXXa27yAYL4yEkBci7pAKH+FNjDWp8-Y86zxdqndO0Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Aug 28, 2012 at 04:38:24PM -0700, Shilimkar, Santosh wrote:
> On Tue, Aug 28, 2012 at 4:09 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > On Tue, Aug 28, 2012 at 07:19:38AM -0700, Shilimkar, Santosh wrote:
> >> Or the PPA has resized the secure area of 16K. As you have seen the issue
> >> on one OMAP3 device, it makes sense to takeout that 16K from the public
> >> SRAM map.
> >>
> >> Can you send the patch with fixed base address fir PUB SRAM ?
> >
> > Maybe I'm missing something, but I tried the following and now something
> > else got broken:
> >
> >         save_secure_sram() returns 0000ff02
> >
> Damn. Looks like, you are running short of memory now for sram_push stuff.

No, it's not that, because the below version works and that leaves as
little memory for the sram_push code:

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 766181c..a91e7ad 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -47,7 +47,7 @@
 #define OMAP5_SRAM_PA		0x40300000
 
 #if defined(CONFIG_ARCH_OMAP2PLUS)
-#define SRAM_BOOTLOADER_SZ	0x00
+#define SRAM_BOOTLOADER_SZ	(cpu_is_omap34xx() ? SZ_16K : 0)
 #else
 #define SRAM_BOOTLOADER_SZ	0x80
 #endif

A.
