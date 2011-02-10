From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv5] omap3: Add basic support for 720MHz part
Date: Thu, 10 Feb 2011 08:45:00 -0800
Message-ID: <87d3mzx2ib.fsf@ti.com>
References: <1297239010-29683-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58635 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820Ab1BJQpG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 11:45:06 -0500
Received: by mail-vx0-f177.google.com with SMTP id 2so777700vxd.36
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 08:45:04 -0800 (PST)
In-Reply-To: <1297239010-29683-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Wed, 9 Feb 2011 13:40:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Sanjeev Premi <premi@ti.com> writes:

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

Acked-by: Kevin Hilman <khilman@ti.com>
