From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V4 10/18] ARM: OMAP2+: Add function to read GPMC settings from device-tree
Date: Mon, 15 Apr 2013 14:27:37 +0100
Message-ID: <20130415132737.A2A6E3E0AA8@localhost>
References: <1363710956-26773-1-git-send-email-jon-hunter@ti.com> <1363710956-26773-11-git-send-email-jon-hunter@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:49260 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3DON1l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 09:27:41 -0400
Received: by mail-wg0-f53.google.com with SMTP id z11so855619wgg.20
        for <linux-omap@vger.kernel.org>; Mon, 15 Apr 2013 06:27:40 -0700 (PDT)
In-Reply-To: <1363710956-26773-11-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

On Tue, 19 Mar 2013 11:35:48 -0500, Jon Hunter <jon-hunter@ti.com> wrote:
> Adds a function to read the various GPMC chip-select settings from
> device-tree and store them in the gpmc_settings structure.
> 
> Update the GPMC device-tree binding documentation to describe these
> options.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-gpmc.txt |   23 ++++++++++++
>  arch/arm/mach-omap2/gpmc.c                        |   40 +++++++++++++++++++++
>  arch/arm/mach-omap2/gpmc.h                        |    2 ++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> index 5ddb2e9..6fde1cf 100644
> --- a/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> @@ -65,6 +65,29 @@ The following are only applicable to OMAP3+ and AM335x:
>   - gpmc,wr-access
>   - gpmc,wr-data-mux-bus
>  
> +GPMC chip-select settings properties for child nodes. All are optional.
> +
> +- gpmc,burst-length	Page/burst length. Must be 4, 8 or 16.
> +- gpmc,burst-wrap	Enables wrap bursting
> +- gpmc,burst-read	Enables read page/burst mode
> +- gpmc,burst-write	Enables write page/burst mode
> +- gpmc,device-nand	Device is NAND
> +- gpmc,device-width	Total width of device(s) connected to a GPMC
> +			chip-select in bytes. The GPMC supports 8-bit
> +			and 16-bit devices and so this property must be
> +			1 or 2.

I would suggest specifying the actual number of bits. ie. 8 or 16. There is some
precidence for that already in DT bindings.

> +- gpmc,mux-add-data	Address and data multiplexing configuration.
> +			Valid values are 1 for address-address-data
> +			multiplexing mode and 2 for address-data
> +			multiplexing mode.
> +- gpmc,sync-read	Enables synchronous read. Defaults to asynchronous
> +			is this is not set.

'if'?

> +- gpmc,sync-write	Enables synchronous writes. Defaults to asynchronous
> +			is this is not set.
> +- gpmc,wait-pin		Wait-pin used by client. Must be less than
> +			"gpmc,num-waitpins".
> +- gpmc,wait-on-read	Enables wait monitoring on reads.
> +- gpmc,wait-on-write	Enables wait monitoring on writes.

Otherwise looks okay to me.

g.

