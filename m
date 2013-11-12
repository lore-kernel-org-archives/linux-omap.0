From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: move gpmc headers to
 include/linux/platform_data
Date: Tue, 12 Nov 2013 14:12:12 -0800
Message-ID: <20131112221212.GU15154@atomide.com>
References: <1384014842-4288-1-git-send-email-javier.martinez@collabora.co.uk>
 <1384014842-4288-2-git-send-email-javier.martinez@collabora.co.uk>
 <20131112205147.GB20260@localhost>
 <5282A427.9070300@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49565 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756045Ab3KLWMT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Nov 2013 17:12:19 -0500
Content-Disposition: inline
In-Reply-To: <5282A427.9070300@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131112 13:58]:
> On 11/12/2013 09:51 PM, Ezequiel Garcia wrote:
> > 
> > I'm not too convinced about the above diffstat. Maybe you can try a
> > a better approach of making the move by: 1) renaming/moving a file,
> > using 'git format-patch -M' and 2) then make the necessary changes
> > in the new place.
> > 
> > Or, if the above ends up not fully bisectable you can try first (2)
> > then (1).
> >
> > What bothers me most is seeing things like this:
> > 
> >   arch/arm/mach-omap2/gpmc-nand.h                  |  27 ---
> >   arch/arm/mach-omap2/gpmc.h                       | 231 -----------------------
> >   include/linux/platform_data/gpmc-nand-omap.h     |  27 +++
> >   include/linux/platform_data/gpmc-omap.h          | 231 +++++++++++++++++++++++
> > 
> > What do you think?
> > 
> 
> Agreed, I completely forgot about -M when generating the patches.
> 
> I'll wait to see what Tony thinks about this approach to take the gpmc driver
> outside of mach-omap2 and send a v2 addressing the issues you pointed out.

Well the headers in include/linux/platform_data should only
contain platform data passed to the driver. So you should
keep arch/arm/mach-omap2 specific stuff in the local headers,
then have the driver specific stuff private to the drivers,
and then have separate minimal platform data headers.

Please also try to avoid patching all the board-*.c files if
possible by keeping the the local headers in place as the board
files will be going away for v3.14 anyways. You can include
the new platform data header from those local files as that
cuts down extra churn in the board-*.c files a bit ;)

Regards,

Tony
