From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] ARM: dts: OMAP3-N900: Add microphone bias voltages
Date: Wed, 1 Apr 2015 12:47:36 -0700
Message-ID: <20150401194734.GT10805@atomide.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com>
 <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com>
 <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41317 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbbDATvh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Apr 2015 15:51:37 -0400
Content-Disposition: inline
In-Reply-To: <20150331123233.GA15103@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Pavel Machek <pavel@ucw.cz>

* Sebastian Reichel <sre@kernel.org> [150331 05:33]:
> Hi,
> 
> On Mon, Mar 30, 2015 at 10:50:52AM -0700, Tony Lindgren wrote:
> > * Jarkko Nikula <jarkko.nikula@bitmer.com> [150330 10:46]:
> > > Well, there has been regression but finding exactly how far should the
> > > fix go didn't look instantly straightforward due all DT, codec driver
> > > mic bias etc changes and I ended up not cc'ing stable.
> > > 
> > > But well, I guess first kernel where this commit makes sense is 3.16+
> > > due commit f7d0f2a08567 ("ARM: dts: omap3-n900: Add sound support").
> > > Although it applies on top of commit 14e3e295b2b9 ("ARM: dts:
> > > omap3-n900: Add TLV320AIC3X support") too (3.12+) but not before that.
> > 
> > OK I think debian is using v3.16 kernel
> 
> Yes. It will be used for Debian jessie (not yet released) and the
> N900 related drivers are enabled in the armmp flavour. Unfortunately
> it does not work together with thumb using userland because the
> errata 430973 workaround is not enabled.
> 
> See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=768890

Hmm I believe many ARMv8 boards will be randomly oopsing
with armhf without that. I sort of recall random oopses just
with running apt-get update on ARMv8 omaps on armhf without that:

http://www.spinics.net/lists/linux-omap/msg108511.html

See also 5c86c5339c56 ("ARM: omap2plus_defconfig: Enable ARM erratum
430973 for omap3").

I wonder if the ARMv8 revision range might be wrong 430973 in
kernel or errata? Also I recall that 430973 change to the
arch/arm/mm/proc-v7-2level.S fixed the issue, this should be
verified though.
 
> I guess it should be tried to change the workaround, so that it does
> only change the behaviour of affected platforms. Otherwise its a
> hard decision for distributions to enable the workaround.

Well we should figure out first why flush BTAC/BTB is needed in
cpu_v7_switch_mm.. And if what I'm describing above is still
reproducable.
 
> > and that's pretty much the first kernel that is usable with dts on
> > many omap3 devices so might make sense for that.
> 
> DT support for N900's soundcard has been added in 3.16, so before
> that the audio stuff didn't work at all.
> 
> > I can add it if you think it makes sense.
> 
> I guess backporting this makes sense because of fewer "broken" DTB
> files in the wild.

Anyways yeah adding $subject patch into omap-for-v4.0/fixes with
cc stable v3.16+.

Regards,

Tony
