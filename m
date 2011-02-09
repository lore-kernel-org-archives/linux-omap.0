From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv5] omap3: Add basic support for 720MHz part
Date: Tue, 08 Feb 2011 17:02:43 -0800
Message-ID: <1297213363.10580.84.camel@vence>
References: <1296126687-1846-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:42654 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755036Ab1BIBCr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 20:02:47 -0500
Received: by mail-pz0-f41.google.com with SMTP id 27so1489858pzk.14
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 17:02:46 -0800 (PST)
In-Reply-To: <1296126687-1846-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 2011-01-27 at 16:41 +0530, Sanjeev Premi wrote:
> This patch adds support for speed enhanced variant of OMAP35x
> processors. These parts allow ARM and IVA running at 720MHz
> and 520MHz respectively.
> 
> These parts can be detected at runtime by reading contents of
> PRODID.SKUID[3:0] at 0x4830A20C [1].
> 
> This patch specifically does following:
>  * Add new OPP to omap34xx_opp_def_list[] - disabled by default.
>  * Detect devices capable of running at new OPP.
>  * Enable new OPP only if device supports it.
>  * Check for presence of IVA before attempting to enable the
>    corresponding OPP.
> 
>   [1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
> 
> It appears from discussions (on this patch) that a variant of
> OMAP3430 supports this OPP but lacks runtime detection. This
> OPP can be enabled for these device by either:
>  1) Setting the bit corresponding to OMAP3_HAS_720MHZ
>     in 'omap3_features'. (Refer changes to id.c)
>  2) Removing check for omap3_has_720mhz() before enabling
>     the OPP. (Refer changes to opp3xxx_data.c)
>  3) Calling opp_enable() for 720MHz/VDD1 and 520MHz/VDD2 in
>     the board file. (Refer changes to opp3xxx_data.c).
>     This should, ideally, be done before omap3_opp_init() is
>     called during device_initcall().
> 
> CAUTION: This should be done for identified parts only.
>          Else, the device could be damaged permanently.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Reviewed-by: G, Manjunath Kondaiah <manjugk@ti.com>

Looks good.

Sanjeev, please post one more time Cc'ing the linux-arm-kernel ML:
linux-arm-kernel@lists.infradead.org

Thanks,

Kevin


