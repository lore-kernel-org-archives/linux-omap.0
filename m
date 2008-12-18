From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP3: Initialize XCCR and RCCR McBSP registers
 for McBSP DAI driver
Date: Thu, 18 Dec 2008 14:51:37 +0200
Message-ID: <20081218145137.9a0741fd.jarkko.nikula@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484A4C7@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24184 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbYLRMwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 07:52:04 -0500
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705A484A4C7@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

On Thu, 18 Dec 2008 04:15:09 -0600
"ext Lopez Cruz, Misael" <x0052729@ti.com> wrote:

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 8485a8a..2e7000d 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -295,6 +295,10 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  	regs->spcr1	|= RINTM(3);
>  	regs->rcr2	|= RFIG;
>  	regs->xcr2	|= XFIG;
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +		regs->xccr = DXENDLY(1) | XDMAEN;
> +		regs->rccr = RFULL_CYCLE | RDMAEN;
> +	}
>  
This part should go as a separate patch and via alsa-devel when omap
part is in upstream. Probably easier to handle via LKML? So two
patches: plat-omap and sound part.


Jarkko
