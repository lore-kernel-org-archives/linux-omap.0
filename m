From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv5 2/6] ARM: OMAP3 PM: Move IO Daisychain function to
 omap3 prm file
Date: Tue, 6 Mar 2012 09:57:27 -0600
Message-ID: <20120306155725.GA30895@senorita.am.dhcp.ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
 <1331046702-2472-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57782 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445Ab2CFP5h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 10:57:37 -0500
Received: by mail-gy0-f178.google.com with SMTP id f1so2277393ghb.9
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 07:57:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1331046702-2472-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Vishwanath BS <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

On 17:11-20120306, Tero Kristo wrote:
> From: Vishwanath BS <vishwanath.bs@ti.com>
> 
> Since IO Daisychain modifies only PRM registers, it makes sense to move
> it to PRM File. Also changed the timeout value for IO chain enable to
> 100us and added a wait for status disable at the end.
[...]
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> index 9ce7654..2f45b96 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> @@ -301,6 +301,43 @@ void omap3xxx_prm_restore_irqen(u32 *saved_mask)
>  				OMAP3_PRM_IRQENABLE_MPU_OFFSET);
>  }
>  
> +/*
> + * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
> + * the I/O ring after asserting WUCLKIN high
> + */
> +#define MAX_IOPAD_LATCH_TIME 100
> +
> +/* OMAP3 Daisychain enable sequence */
> +void omap3_trigger_io_chain(void)
> +{
> +	int i = 0;
> +
> +	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> +				   PM_WKEN);
> +	/* Do a readback to assure write has been done */
> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> +
> +	omap_test_timeout(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
> +			  OMAP3430_ST_IO_CHAIN_MASK,
> +			  MAX_IOPAD_LATCH_TIME, i);
probably a nitpick, but would'nt you like to keep the OMAP3 and OMAP4
style consistent?
> +
> +	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> +				     PM_WKEN);
> +
> +	omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK, WKUP_MOD,
> +				     PM_WKST);
> +
> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST);
in the previous iteration it had:
omap_test_timeout(((omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
OMAP3430_ST_IO_CHAIN_MASK) == 0),
MAX_IOPAD_LATCH_TIME,
i);
gone now?
-- 
Regards,
Nishanth Menon
