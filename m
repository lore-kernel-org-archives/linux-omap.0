From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: [PATCH 5/9] OMAP: HSMMC: Fix oops in omap_mmc_remove
Date: Fri, 21 Nov 2008 16:03:25 +0200
Message-ID: <6ed0b2680811210603s17f7a43fw4dd0d57bc5dd829c@mail.gmail.com>
References: <49267E28.1020303@nokia.com> <49268161.1010304@nokia.com>
	 <4926859F.8090902@nokia.com> <4926865A.7070406@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:55169 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbYKUOD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 09:03:27 -0500
Received: by gv-out-0910.google.com with SMTP id e6so215861gvc.37
        for <linux-omap@vger.kernel.org>; Fri, 21 Nov 2008 06:03:26 -0800 (PST)
In-Reply-To: <4926865A.7070406@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, Nov 21, 2008 at 11:58 AM, Adrian Hunter
<ext-adrian.hunter@nokia.com> wrote:
<snip>
> @@ -1128,15 +1128,17 @@ static int omap_mmc_remove(struct platform_device
<snip>
> +               mmc_omap_fclk_state(host, ON);
> +               if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
> +                       /*
> +                        * Set the vdd back to 3V,
> +                        * applicable for dual volt support.
> +                        */
> +                       vdd = fls(host->mmc->ocr_avail) - 1;
> +                       if (omap_mmc_switch_opcond(host, vdd) != 0)
> +                               host->mmc->ios.vdd = vdd;
> +               }

I wonder what this block is for? Wouldn't simple
   host->mmc->ios.vdd = vdd;
be enough? It calls omap_mmc_switch_opcond() which toggles clocks and
power without good reason (I think). Clocks will be turned off later
in omap_mmc_remove() anyway, and .set_ios will turn off power. Also,
HCTL SDVSDET bit will never be set for MMC2 and MMC3, causing
mentioned omap_mmc_switch_opcond() to be called unconditionally here.

The same block can be found in mmc_omap_detect() function, where it is
executed on card removal. There it causes MMC2 controller to stop
working completely on pandora board :(
