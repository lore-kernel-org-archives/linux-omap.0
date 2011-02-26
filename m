From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap2plus: Remove auto selection on PMICs
Date: Sat, 26 Feb 2011 13:59:26 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BE4A01B@dbde02.ent.ti.com>
References: <1298463072-19891-1-git-send-email-premi@ti.com>
 <20110225181640.GA20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58182 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab1BZI3d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Feb 2011 03:29:33 -0500
In-Reply-To: <20110225181640.GA20560@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, February 25, 2011 11:47 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap2plus: Remove auto selection on PMICs
> 
> * Sanjeev Premi <premi@ti.com> [110223 04:11]:
> > The current implementation almost assumes that only
> > TWL4030/TWL5030/TWl6030 are (or can be) used with the
> > OMAP processors. This is, however, not true.
> 
> If selecting these on platforms that don't have twl
> causes problems the problem should be fixed.
> 
> You can disable CONFIG_ARCH_OMAP2PLUS_TYPICAL, and
> then these don't get selected.

[sp] But this means MUTLI_OMAP breaks. And same uImage
     won't run on the AM3517 EVM.

     If I remember, the problem is caused due to twl specific
     functions called even if it isn't present. And there is
     implicit assumption on TWL in most of code.
> 
> > This patch removes the automatic selection of the PMIC
> > from Kconfig. Current defaults are chosen in default
> > configuration omap2plus_defconfig and can easily be
> > added to configuration for any board, there should be
> > no compile/run-time impact.
> 
> The reason for CONFIG_ARCH_OMAP2PLUS_TYPICAL is to
> produce a booting kernel if you do the following:
> 
> $ echo CONFIG_ARCH_OMAP=y > .config
> $ yes "" | ARCH=arm make oldconfig
> $ ARCH=arm CROSS_COMPILE=mycompiler uImage
> 
> So I'd rather keep it around for now. In the long run
> omap2plus_defconfig should build a working kernel with
> everything as modules though..

[sp] I will be away from work for next week; may not
     be able to try this; but don't you think dependency
     on ARM is too generic? And this should still be fixed..

-	depends on TWL4030_CORE && ARM
+	depends on TWL4030_CORE && (ARCH_OMAP3 || ARCH_OMAP4)

~sanjeev

> 
> BTW, looks like small patch is needed with the patches queued
> in omap-for-linus to make the above compile. Will post
> as a reply to this mail.
> 
> Regards,
> 
> Tony

