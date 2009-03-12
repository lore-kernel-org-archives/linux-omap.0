From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [patch 2.6.29-rc7-omap 5/5] mmc-twl4030 uses regulator framework
Date: Thu, 12 Mar 2009 10:57:45 +0200
Message-ID: <49B8CE89.2000608@nokia.com>
References: <200903110518.34945.david-b@pacbell.net> <200903110524.16644.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25911 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZCLI6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 04:58:13 -0400
In-Reply-To: <200903110524.16644.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>

David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> Subject: mmc-twl4030 uses regulator framework
> 
> Finish decoupling the HSMMC glue from the twl4030 as the only
> regulator provider, using the regulator framework instead.
> This makes the glue's "mmc-twl4030" name become a complete
> misnomer ... this code could probably all migrate into the
> HSMMC driver now.
> 
> Tested on 3430SDP (SD and low-voltage MMC) and Beagle (SD),
> plus some other boards (including Overo) after they were
> converted to set up MMC regulators properly.
> 
> Eventually all boards should just associate a regulator with
> each MMC controller they use.  In some cases (Overo MMC2 and
> Pandora MMC3, at least) that would be a fixed-voltage regulator
> with no real software control.  As a temporary hack (pending
> regulator-next updates to make the "fixed.c" regulator become
> usable) there's a new ocr_mask field for those boards.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---

snip

> @@ -349,24 +276,23 @@ static int twl_mmc2_set_power(struct dev
>                         reg |= OMAP2_MMCSDIO2ADPCLKISEL;
>                         omap_ctrl_writel(reg, control_devconf1_offset);
>                 }
> -               ret = twl_mmc_set_voltage(c, vdd);
> +               ret = mmc_regulator_set_ocr(c->vcc, vdd);
> +               /* enable interface voltage rail, if needed */
> +               if (ret == 0 && c->vcc_aux) {
> +                       ret = regulator_enable(c->vcc_aux);
> +                       if (ret < 0)
> +                               ret = mmc_regulator_set_ocr(c->vcc, 0);
> +               }
>         } else {
> -               ret = twl_mmc_set_voltage(c, 0);
> +               if (c->vcc_aux)
> +                       ret = regulator_enable(c->vcc_aux);

Sorry for slow reply.  Shouldn't that be regulator_disable() ?

> +               if (ret == 0)
> +                       ret = mmc_regulator_set_ocr(c->vcc, 0);
>         }
> 
>         return ret;
>  }
> 

snip
