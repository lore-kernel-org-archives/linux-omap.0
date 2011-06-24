From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Thu, 23 Jun 2011 17:17:47 -0700
Message-ID: <874o3g6q1g.fsf@ti.com>
References: <1308300725-12150-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:57868 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759972Ab1FXARv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 20:17:51 -0400
Received: by mail-pw0-f42.google.com with SMTP id 4so1646481pwi.15
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 17:17:50 -0700 (PDT)
In-Reply-To: <1308300725-12150-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Fri, 17 Jun 2011 10:52:05 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
> is copied to internal SRAM and run from there.
> However only a small part of the code really needs to run from internal SRAM.
>
> This fix lets most of the ASM idle code run from the DDR
> in order to minimize the SRAM usage. No performance
> loss or gain can be measured with a 32KHz clock period.
>
> The only pieces of code that are mandatory in SRAM
> are:
> - the i443 erratum WA,
> - the i581 erratum WA,
> - the security extension code.
>
> SRAM usage:
> - original code:
>   . 560 bytes for omap3_sram_configure_core_dpll (used by DVFS),
>   . 1196 bytes for omap_sram_idle (used by suspend/resume in RETention),
>   . 124 bytes for es3_sdrc_fix (used by suspend/resume in OFF mode on ES3.x),
>   . 108 bytes for save_secure_ram_context (used on HS parts only).
>
> With this fix the usage for suspend/resume in RETention goes down 288 bytes,
> so the gain in SRAM usage for suspend/resume is 908 bytes.
>
> Also fixed the SRAM initialization sequence to avoid an unnecessary
> copy to SRAM at boot time and for readability.
>
> Tested on Beagleboard (ES2.x) in idle with full RET and OFF modes.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Hi Jean,

Can you rebase/retest this on top of my pm-wip/idle-suspend branch,
which now contains Russell's major cleanup to use the common code as
well as an additional patch from me to remove the unncessary
get_*_restore_pointer functions:

[PATCH] OMAP3: PM: remove get_*_restore_pointer functions, directly use entry points

Thanks,

Kevin
