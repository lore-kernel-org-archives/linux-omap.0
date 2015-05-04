From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] ARM: dts: OMAP3-N900: Add microphone bias voltages
Date: Mon, 4 May 2015 09:07:13 -0700
Message-ID: <20150504160713.GH24469@atomide.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com>
 <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com>
 <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48972 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbbEDQHQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 12:07:16 -0400
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

Oops I just noticed the original $subject fix is still pending
as we got distracted with all this 430973 stuff. Applying Jarkko's
fix into omap-for-v4.1/fixes with Cc stable v3.16+.

Regards,

Tony
