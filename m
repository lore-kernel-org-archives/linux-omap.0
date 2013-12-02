From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-beagle: Add omap-twl4030 audio support
Date: Mon, 2 Dec 2013 11:16:53 -0800
Message-ID: <20131202191652.GI26766@atomide.com>
References: <1385578008-6623-1-git-send-email-jarkko.nikula@bitmer.com>
 <20131127220258.GE26766@atomide.com>
 <5297778B.7010305@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23185 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753204Ab3LBTQz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 14:16:55 -0500
Content-Disposition: inline
In-Reply-To: <5297778B.7010305@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>

* Jarkko Nikula <jarkko.nikula@bitmer.com> [131128 09:05]:
> On 11/28/2013 12:02 AM, Tony Lindgren wrote:
> > * Jarkko Nikula <jarkko.nikula@bitmer.com> [131127 10:48]:
> >> This adds typical McBSP2-TWL4030 audio description to the legacy
> >> Beagle Board.
> > 
> > Nice to see that work almost out of the box :)
> > 
> > BTW, I just noticed that sound/soc/omap/Kconfig has depends on
> > OMAP_MUX. The OMAP_MUX option will be dropped for mach-omap2
> > for v3.14, so you may want to take a look at that too. If there
> > really is a dependency, that should be handled using
> > pinctrl-single for the .dts entries.
> > 
> There is actually dependency but only on N810 which needs to remux 4
> pins from EAC to McBSP2. I'll try to keep my eye on it but don't let
> that block your cleanup work.

Thanks, meanwhile I'll queue your beagle audio fix.

Tony
