From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Fri, 26 Jul 2013 23:59:10 +0100
Message-ID: <20130726225910.GD21614@n2100.arm.linux.org.uk>
References: <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com> <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724145237.GB21614@n2100.arm.linux.org.uk> <51F0C841.8000900@ti.com> <51F0CAA5.8010108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38862 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab3GZW71 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jul 2013 18:59:27 -0400
Content-Disposition: inline
In-Reply-To: <51F0CAA5.8010108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Having worked out how to get around the MMC ordering issue without having
to go and re-tweak it should it change again in the future, I've added
the SDP back into the build.

On Thu, Jul 25, 2013 at 09:50:13AM +0300, Tomi Valkeinen wrote:
> On 25/07/13 09:40, Tomi Valkeinen wrote:
> > On 24/07/13 17:52, Russell King - ARM Linux wrote:
> > 
> >> I also continue to be disappointed by the lack of things working on the
> >> 4430 - it's been a number of years now and _still_ the on-board LCDs do
> >> not work.  People have tried to blame that on hardware faults and the
> >> like, but they're just being idiotic when they say stuff like that.  It
> >> can't be hardware faults when the kernel supplied with the board is able
> >> to make them work to the extent that userspace can play back video on all
> >> three output devices simultaneously, without hiccup or any imperfection.
> >> I don't know whether it's just that the backlight support isn't working
> >> or what - because any information on the 4430 seems to be a tightly
> >> controlled secret that only a few select people are permitted to know
> >> about.  As far as I'm concerned, much of the hardware is a black box to
> >> me.
> > 
> > The 4430SDP's backlight hasn't been working in the mainline due to
> > missing support from the TWL driver. But we finally did get that in for
> > 3.10 (or maybe 3.9), and booting 3.10 non-DT kernel brings up the
> > backlights. However, the BL doesn't work yet with DT boot, so again with
> > 3.11, with no board files, the BL is out... Sigh.
> 
> Ah, sorry, I take that back. Backlight seems to be working fine with 3.11.

... if you know how to configure stuff so it works.  It seems that the
reason it hasn't been working, and the displays have been remaining
blank is because I had no idea that CONFIG_PWM and CONFIG_PWM_TWL were
required.  I've now added those to the config seed, so hopefully they
should start working now.  Only taken... what... two years to find that
out!
