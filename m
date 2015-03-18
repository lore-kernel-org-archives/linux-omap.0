From: Tony Lindgren <tony@atomide.com>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Wed, 18 Mar 2015 15:01:59 -0700
Message-ID: <20150318220158.GZ31346@atomide.com>
References: <1426707461.13824.2.camel@symus-gk-mint>
 <20150318203100.GV31346@atomide.com>
 <CAAQQ3umQu=Zh6MC=uXTxzbXGgm48KY6KQTPo4=f=0cVy+FFv-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38506 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757136AbbCRWGm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 18:06:42 -0400
Content-Disposition: inline
In-Reply-To: <CAAQQ3umQu=Zh6MC=uXTxzbXGgm48KY6KQTPo4=f=0cVy+FFv-Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Knight <g.knight@symetrica.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Greg Knight <g.knight@symetrica.com> [150318 15:02]:
> Will do, Tony. Thanks for helping out. First time submitting kernel patches
> so I'm still figuring things out.

No problem :)
 
> I'm not actually certain of the full reach of the acronym "omap" (or,
> frankly, anything about it except that it shows up everywhere with TI's
> footprints). But the patches I'm submitting apply to McASP and McSPI
> subcomponents of the AM335X CPU, which is TI, so... I assume it's omap?

Yes from the kernel point of view if it uses code in arch/arm/*omap*/
it's an omap. And am335x is booting with code in arch/arm/mach-omap2.

Regards,

Tony
