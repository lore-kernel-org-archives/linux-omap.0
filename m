From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Tue, 14 Jan 2014 19:50:11 -0800
Message-ID: <20140115035011.4167.96678@quantum>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <20140109231513.GA11648@saruman.home> <52CFC2F1.706@ti.com>
 <20140110161352.GG6665@saruman.home> <52D02037.3090705@ti.com>
 <20140110185110.GM31323@atomide.com> <52D53084.1070105@ti.com>
 <20140114203613.GA604@saruman.home> <20140115020421.GA24195@saruman.home>
 <20140115031632.4167.2698@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f170.google.com ([209.85.161.170]:57611 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbaAODuT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2014 22:50:19 -0500
Received: by mail-gg0-f170.google.com with SMTP id l4so369740ggi.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Jan 2014 19:50:19 -0800 (PST)
In-Reply-To: <20140115031632.4167.2698@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.comFelipe Balbi <balbi@ti.com>Felipe Balbi <balbi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Quoting Mike Turquette (2014-01-14 19:16:32)
> Quoting Felipe Balbi (2014-01-14 18:04:21)
> > Hi,
> > 
> > On Tue, Jan 14, 2014 at 02:36:13PM -0600, Felipe Balbi wrote:
> > > > Felipe, care to run your randconfig magic for this?
> > > 
> > > This branch builds just fine so far, I still have omap5 multiplaform and
> > > uniplatform builds, but since that was working before i'm assuming it
> > > won't break.
> > 
> > No build failures in any of my 18 seeds (5 randconfigs of each), I'd
> > attach logs, but it's a 2.8MiB tarball, if anyone cares enough, I can
> > send it.
> > 
> > FWIW:
> > 
> > Acked-by: Felipe Balbi <balbi@ti.com>
> 
> Felipe,
> 
> That's great to hear. Thanks for testing.
> 
> Tero & Tony,
> 
> These 40 patches apply very cleanly on top of clk-next with 2
> exceptions:
> 
> 1) I did not apply "[PATCH 30/42] ARM: dts: AM35xx: use DT clock data"
> because I do not have arch/arm/boot/dts/am3517.dtsi in clk-next (based
> on 3.13-rc1).
> 
> 2) Minor merge conflict in arch/arm/boot/dts/omap3.dtsi which I think I
> resolved correctly but would like verification.
> 
> I'd prefer to simply merge these patches into clk-next, which is the
> most straightforward route. Any ideas on how to handle the missing
> AM35xx dtsi data? It can always go as a separate fix after this stuff
> gets merged which, ironically, is how that file was created in the first
> place.

I've pushed my branch. Tero can you take a look and let me know if you
see any problems?

git://git.linaro.org/people/mike.turquette/linux.git clk-next-omap

Thanks!
Mike

> 
> Regards,
> Mike
> 
> > 
> > cheers
> > 
> > -- 
> > balbi
