From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2plus: Remove auto selection on PMICs
Date: Wed, 2 Mar 2011 10:04:28 -0800
Message-ID: <20110302180428.GZ20560@atomide.com>
References: <1298463072-19891-1-git-send-email-premi@ti.com>
 <20110225181640.GA20560@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BE4A01B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39051 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1CBSEd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 13:04:33 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BE4A01B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [110226 00:27]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Friday, February 25, 2011 11:47 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] omap2plus: Remove auto selection on PMICs
> > 
> > * Sanjeev Premi <premi@ti.com> [110223 04:11]:
> > > The current implementation almost assumes that only
> > > TWL4030/TWL5030/TWl6030 are (or can be) used with the
> > > OMAP processors. This is, however, not true.
> > 
> > If selecting these on platforms that don't have twl
> > causes problems the problem should be fixed.
> > 
> > You can disable CONFIG_ARCH_OMAP2PLUS_TYPICAL, and
> > then these don't get selected.
> 
> [sp] But this means MUTLI_OMAP breaks. And same uImage
>      won't run on the AM3517 EVM.
> 
>      If I remember, the problem is caused due to twl specific
>      functions called even if it isn't present. And there is
>      implicit assumption on TWL in most of code.

Then let's fix that problem instead. The TWL functions should
not get called (or at least they should not do anything)
unless the TWL chip is there.

> [sp] I will be away from work for next week; may not
>      be able to try this; but don't you think dependency
>      on ARM is too generic? And this should still be fixed..
> 
> -	depends on TWL4030_CORE && ARM
> +	depends on TWL4030_CORE && (ARCH_OMAP3 || ARCH_OMAP4)

Well in theory all the drivers should just build on whatever
platform. I don't know if changing that really improves things,
we should improve the driver instead.

Note for example how the tps65010.c driver also builds on x86.
That allows people doing Linux generic changes to build test
those changes:

$git log --pretty=oneline drivers/mfd/tps65010.c
77b22897da093e80c40f03e8d83bf23e756b9fba mfd: Include <linux/gpio.h> instead of 
afdb32f2e463a195c104555ac9a8cdd39a2b6561 mfd: update workqueue usages
fbae3fb1546e199ab0cd185348f8124411a1ca9d i2c: Remove all i2c_set_clientdata(clie
f322d5f0097333343bfd92b47258ee997c889263 mfd: Fix dangling pointersRegards,
...

So instead of breakage for the tps65010 driver we instead got
the above changes compile tested as an extra bonus.

Regards,

Tony
