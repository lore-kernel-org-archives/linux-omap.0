From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 2/6] ARM: OMAP3 PM: Move IO Daisychain function to
 omap3 prm file
Date: Mon, 5 Mar 2012 23:44:44 -0600
Message-ID: <20120306054443.GA5670@kobold>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
 <1330701475-22576-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:45459 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558Ab2CFFoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 00:44:44 -0500
Received: by mail-yw0-f49.google.com with SMTP id j52so2233542yhj.36
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 21:44:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1330701475-22576-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Vishwanath BS <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

On 17:17-20120302, Tero Kristo wrote:
> From: Vishwanath BS <vishwanath.bs@ti.com>
> 
> Since IO Daisychain modifies only PRM registers, it makes sense to move
> it to PRM File. Also changed the timeout value for IO chain enable to
> 100us and added a wait for status disable at the end.
> 
[...]
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
> +	omap_test_timeout(((omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
> +			    OMAP3430_ST_IO_CHAIN_MASK) == 1),
umm
arch/arm/mach-omap2/prm-regbits-34xx.h:#define OMAP3430_ST_IO_CHAIN_MASK
(1 << 16)
(reg & (1 << 16)) == 1
will ever be true?

-- 
Regards,
Nishanth Menon
