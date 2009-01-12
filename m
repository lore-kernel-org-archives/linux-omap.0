From: Tony Lindgren <tony@atomide.com>
Subject: Re: mmci-omap regressions
Date: Mon, 12 Jan 2009 12:42:43 +0200
Message-ID: <20090112104242.GA9373@atomide.com>
References: <20090112091721.GA11921@michl.2n.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62338 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbZALKmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 05:42:45 -0500
Content-Disposition: inline
In-Reply-To: <20090112091721.GA11921@michl.2n.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org

Hi,

* Ladislav Michl <ladis@linux-mips.org> [090112 11:19]:
> Last time I used MMC card with linux-2.6.15-omap2 and it worked pretty well on
> my custom 5910 based board. Current git nor linux-2.6.22-omap1 (currently used
> for production) doesn't work at all. Inspecting diff between 2.6.15-omap2 and
> 2.6.22-omap1 showed that
> --- a/drivers/mmc/host/omap.c	2009-01-12 09:32:23.000000000 +0100
> +++ b/drivers/mmc/host/omap.c	2009-01-12 09:46:26.000000000 +0100
> @@ -974,7 +974,7 @@
>  	 * Writing to the CON register twice seems to do the trick. */
>  	for (i = 0; i < 2; i++)
>  		OMAP_MMC_WRITE(host, CON, dsor);
> -	if (ios->power_mode == MMC_POWER_ON) {
> +	if (ios->power_mode == MMC_POWER_UP) {
>  		/* Send clock cycles, poll completion */
>  		OMAP_MMC_WRITE(host, IE, 0);
>  		OMAP_MMC_WRITE(host, STAT, 0xffff);
> did the trick.
> 
> With above patch applied to 2.6.22-omap1 I got
> # modprobe omap
> mmci-omap mmci-omap.1: command timeout, CMD 8
>  mmcblk0: mmc0:0001        127104KiB
>  mmcblk0: p1
> while there is no command timeout with 2.6.15-omap2, but at least it works.

OK, well at least that's a good start on figuring out what has broken
it. It does not seem like the right fix though as the MMC_POWER_UP
should just power up the slot, and clocks should not get turned on
until in MMC_POWER_ON.

> Doing the same modification in current git doesn't help. Moreover removing
> omap.ko and inserting again behaves differently than inserting for first
> time:
> # modprobe omap
> mmci-omap mmci-omap.0: command timeout (CMD8)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmc0: error -22 whilst initialising MMC card
> # rmmod omap
> # modprobe omap
> mmci-omap: probe of mmci-omap.0 failed with error -16

Looks like the current git head does goto exit after MMC_POWER_UP before
you even get to that code.

> I'll happily send any requested debug informations and test any patches

Can you maybe try to debug by applying your patch and commenting out
the goto exit?

Regards,

Tony
