From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Wed, 29 Jun 2011 10:29:49 -0700
Message-ID: <87mxh0tuk2.fsf@ti.com>
References: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:49056 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756276Ab1F2R3y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 13:29:54 -0400
Received: by pzk10 with SMTP id 10so1403321pzk.35
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 10:29:52 -0700 (PDT)
In-Reply-To: <1309365623-14704-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 29 Jun 2011 18:40:23 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
> is copied to internal SRAM at boot and after wake-up from CORE OFF mode.
> However only a small part of the code really needs to run from internal SRAM.
>
> This fix lets most of the ASM idle code run from the DDR
> in order to minimize the SRAM usage and the overhead in the code copy.
>
> The only pieces of code that are mandatory in SRAM are:
> - the i443 erratum WA,
> - the i581 erratum WA,
> - the security extension code.
>
> SRAM usage:
> - original code:
>   . 560 bytes for omap3_sram_configure_core_dpll (used by DVFS),
>   . 852 bytes for omap_sram_idle (used by suspend/resume in RETention),
>   . 124 bytes for es3_sdrc_fix (used by suspend/resume in OFF mode on ES3.x),
>   . 108 bytes for save_secure_ram_context (used on HS parts only).
>
> With this fix the usage for suspend/resume in RETention goes down 288 bytes,
> so the gain in SRAM usage for suspend/resume is 564 bytes.
>
> Also fixed the SRAM initialization sequence to avoid an unnecessary
> copy to SRAM at boot time and for readability.
>
> Tested on Beagleboard (ES2.x) in idle with full RET and OFF modes.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Reviewed-by: Kevin Hilman <khilman@ti.com>

Also tested retention and off on 3430/n900, 3530/Overo and 3630/Zoom3

Tested-by: Kevin Hilman <khilman@ti.com>

Russell, if you're OK with it, can you add it to your suspend branch for
the upcoming merge window?

Kevin
