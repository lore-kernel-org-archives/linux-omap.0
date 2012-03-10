From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv5 2/6] ARM: OMAP3 PM: Move IO Daisychain function to
 omap3 prm file
Date: Fri, 9 Mar 2012 17:40:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203091737390.30879@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37170 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab2CJAkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 19:40:20 -0500
In-Reply-To: <1331046702-2472-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, Vishwanath BS <vishwanath.bs@ti.com>

cc Rajendra

Hi Tero,

a few comments:

On Tue, 6 Mar 2012, Tero Kristo wrote:

...

> +/* OMAP3 Daisychain enable sequence */
> +void omap3_trigger_io_chain(void)
> +{
> +	int i = 0;
> +
> +	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> +				   PM_WKEN);
> +	/* Do a readback to assure write has been done */
> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);

Looks like this barrier shouldn't be needed?  The write is immediately 
followed by another read from the same IP block.

> +
> +	omap_test_timeout(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
> +			  OMAP3430_ST_IO_CHAIN_MASK,
> +			  MAX_IOPAD_LATCH_TIME, i);
> +
> +	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> +				     PM_WKEN);
> +
> +	omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK, WKUP_MOD,
> +				     PM_WKST);
> +
> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST);
> +}

I see that you removed the second timeout test from this code, but not 
from the OMAP4 version.  Any reason why?  Seems like if the second timeout 
can be removed from one, then it can also be removed from the other?


- Paul
