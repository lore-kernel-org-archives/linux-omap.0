From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 2/2] ASoC: OMAP2+: Move McBSP, DMIC and McPDM to
 generic DMA DT binding
Date: Mon, 11 Mar 2013 09:38:00 -0700
Message-ID: <20130311163800.GK26093@atomide.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
 <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
 <20130311143303.GC10617@opensource.wolfsonmicro.com>
 <20130311162700.GI26093@atomide.com>
 <20130311162814.GD10617@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:27846 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753423Ab3CKQiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 12:38:06 -0400
Content-Disposition: inline
In-Reply-To: <20130311162814.GD10617@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [130311 09:32]:
> On Mon, Mar 11, 2013 at 09:27:00AM -0700, Tony Lindgren wrote:
> 
> > I suggest you take the driver changes and Benoit takes the .dts
> > changes as those should be queued separately to avoid unnecessary
> > merge conflicts with the .dts files.
> 
> Won't that cause a bisect issue if the driver starts looking for generic
> DT stuff that's not in the DTS files?

It should only affect additional features being enabled. When the .dts
changes get merged the new features just starts working. Or if the .dts
changes go in first, the driver starts working when the driver changes
go in.

If there's some dependency between the driver and the .dts changes
breaking booting etc, that should be fixed in the patches by
for example removing old legacy code later on in a separate series.

This allows us to break the dependency between arch/arm code and
drivers in most cases to keep things simpler.

Regards,

Tony
