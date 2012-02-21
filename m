From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv5 02/14] arm: omap: voltage: renamed vp_vddmin and
	vp_vddmax fields
Date: Tue, 21 Feb 2012 14:53:22 +0000
Message-ID: <20120221145322.GD22675@n2100.arm.linux.org.uk>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com> <1329833098-19900-3-git-send-email-t-kristo@ti.com> <CAOMWX4cviUjAJ2eCB5LjUBmOpEWU5HP9-miPtZY1TwBGYyOPdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45364 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab2BUOxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 09:53:33 -0500
Content-Disposition: inline
In-Reply-To: <CAOMWX4cviUjAJ2eCB5LjUBmOpEWU5HP9-miPtZY1TwBGYyOPdA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 21, 2012 at 08:40:22AM -0600, Menon, Nishanth wrote:
> On Tue, Feb 21, 2012 at 08:04, Tero Kristo <t-kristo@ti.com> wrote:
> > These are now called vddmin and vddmax, as these fields will be used
> > globally for selecting voltage ranges for a pmic channel, and not
> > only for voltage processor.
> 
> NAK. I think we need to setup voltage for SoC limits as well. the
> programmed voltage to the VP register should be:
> VP->vlimito->min = MAX(soc->vdd_min, pmic->vdd_min)
> VP->vlimito->max = MIN(soc->vdd_max, pmic->vdd_max)
> 
> else you could be running the SoC beyond design voltage potentially
> damaging the device.

And if you're doing that kind of thing, you must also check that
the resulting min and max are sane.  In other words, the minimum is
less than the maximum.

Sure, it's something that should never happen (because it would be a
design error) but if it did happen...
