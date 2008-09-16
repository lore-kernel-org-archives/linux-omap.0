From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]Add 3430 SDP board level support for HSMMC2
Date: Tue, 16 Sep 2008 08:12:40 -0700
Message-ID: <20080916151238.GA25885@atomide.com>
References: <33259.192.168.10.89.1218608332.squirrel@dbdmail.itg.ti.com> <20080813085433.D5C2F363253@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <00cf01c8fd26$cfc751b0$LocalHost@wipultra1303> <200809081226.18098.david-b@pacbell.net> <20080910235913.GW21163@atomide.com> <009c01c917bb$322c7f70$LocalHost@wipultra1303>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54389 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbYIPPMm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 11:12:42 -0400
Content-Disposition: inline
In-Reply-To: <009c01c917bb$322c7f70$LocalHost@wipultra1303>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Madhusudhan Chikkature <madhu.cr@ti.com> [080915 22:15]:
> 
> ----- Original Message ----- 
> From: "Tony Lindgren" <tony@atomide.com>
> To: "David Brownell" <david-b@pacbell.net>
> Cc: "Madhusudhan Chikkature" <madhu.cr@ti.com>; <linux-omap@vger.kernel.org>
> Sent: Thursday, September 11, 2008 5:29 AM
> Subject: Re: [PATCH]Add 3430 SDP board level support for HSMMC2
> 
> 
> >* David Brownell <david-b@pacbell.net> [080908 12:26]:
> >> On Wednesday 13 August 2008, Madhusudhan Chikkature wrote:
> >> > > A better way to do this would be to let the boards say exactly
> >> > > what the hardware configuration is, rather than requiring all
> >> > > OMAP3 boards to be set up exactly like the SDP...
> >> >
> >> > I think the initial version was written specific to SDP. Later
> >> > on it was changed to hsmmc.c and the platforms which required
> >> > simillar setup as SDP started using it.
> >> 
> >> Right ...
> >> 
> >> 
> >> > Now, if support for a new board is required which is unlike SDP a  
> >> > new file can still be added for that perticular board, right?
> >> 
> >> Each board already gets a board-XYZ.c file.  So the clean way
> >> to do this is to have that file set up its hsmmc config ... NOT
> >> to clone versions of hsmmc.c for each board!
> > 
> > Madhu, are you planning to abstract hsmmc.c further so various boards
> > can use it?
> Tony, Sorry for the delayed response on this. What level of abstraction are we considering here?
> Are we looking at abstracting out the power stuff (T2 LDO stuff) like the way H4 MMC board file uses
> menelaus driver? What is expected?

Well board-*.c files need to pass information about which MMC
controllers are enabled. I'll have some patches soon that should clean
up the remaining MMC init issues, but does not solve this issue.

Basically board-*.c files need to pass something like 
struct omap_mmc_platform_data **controllers, int nr_controllers
to hsmmc.c to init the right instances.

I'm in process of chaning omap2_init_mmc() so hsmmc_init will call
it with something like this:

static struct omap_mmc_platform_data *board_hsmmc_data[OMAP34XX_NR_MMC];

void __init hsmmc_init(void)
{
	omap2_init_mmc(board_hsmmc_data, OMAP34XX_NR_MMC);
}

Need to test the patches a bit more before I can post them.

Regards,

Tony
