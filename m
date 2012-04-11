From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 12/12] arm: omap3: am35x: Register davinci_mdio before
 davinci_emac
Date: Wed, 11 Apr 2012 15:24:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111520260.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-13-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39039 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933381Ab2DKVYG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 17:24:06 -0400
In-Reply-To: <1334171147-7517-13-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Ilya Yanok <yanok@emcraft.com>

cc Ilya

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Problem:
> --------
> When resuming from a Suspend-to-RAM event, the eth0 device
> (davinci emac/mdio) on am35xx boards wouldn't work and the
> following error message appeared on the console:
> 
> "net eth0: could not connect to phy davinci_mdio-0:00"

...

> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>  arch/arm/mach-omap2/am35xx-emac.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
> index 1f97e74..d23bd6c 100644
> --- a/arch/arm/mach-omap2/am35xx-emac.c
> +++ b/arch/arm/mach-omap2/am35xx-emac.c

This is a little off-topic from this patch, but we should get rid of this 
arch/arm/mach-omap2/am35xx-emac.c file.  These on-chip devices should be 
registered via the hwmod code.  Looking at 
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c, I don't see any trace of the 
EMAC or MDIO in there.  That's where all of these IPSS IP blocks should be 
declared...


- Paul
