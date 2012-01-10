From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2 REPOST 2/7] ARM: OMAP3 PM: Move IO Daisychain function to omap3 prm file
Date: Tue, 10 Jan 2012 09:33:33 -0800
Message-ID: <87pqersbrm.fsf@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
	<1323878477-21122-3-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:51413 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755695Ab2AJRdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 12:33:37 -0500
Received: by mail-yw0-f44.google.com with SMTP id p56so1283055yhp.31
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 09:33:36 -0800 (PST)
In-Reply-To: <1323878477-21122-3-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> Since IO Daisychain modifies only PRM registers, it makes sense to move it to
> PRM File.

You also rename the function but don't describe why or what the new name
means or where it comes from.  An only the 'enable' version is renamed,
but the 'disable' version stays the same.  Confusing.

Also, please fix checkpatch warning:

WARNING: line over 80 characters
#103: FILE: arch/arm/mach-omap2/prm2xxx_3xxx.c:259:
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,

[...]

> +/* OMAP3 Daisychain trigger sequence */
> +void omap3_trigger_wuclk_ctrl(void)
> +{
> +	int i = 0;
> +
> +	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> +			     PM_WKEN);
> +	/* Do a readback to assure write has been done */
> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> +
> +	omap_test_timeout(
> +	(((omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
> +		 OMAP3430_ST_IO_CHAIN_MASK) == 1)),
> +	MAX_IOPAD_LATCH_TIME, i);

indentation is messy

> +
> +	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> +			     PM_WKEN);
> +}

Kevin
