From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [patch 2.6.27-rc7-omap1-git 1/2] twl4030-core: move to
	drivers/mfd
Date: Thu, 2 Oct 2008 12:07:57 +0300
Message-ID: <20081002090757.GJ7412@gandalf.research.nokia.com>
References: <200810011947.55057.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42072 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbYJBJIR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 05:08:17 -0400
Content-Disposition: inline
In-Reply-To: <200810011947.55057.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Wed, Oct 01, 2008 at 07:47:54PM -0700, David Brownell wrote:
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

I suppose this first one should be From:

> -static void __init twl4030_mask_clear_intrs(const struct twl4030_mod_iregs *t,
> -					    const u8 t_sz)
> -{
> -	int i, j;
> -
> -	/*
> -	 * N.B. - further efficiency is possible here.  Eight I2C
> -	 * operations on BCI and GPIO modules are avoidable if I2C
> -	 * burst read/write transactions were implemented.  Would
> -	 * probably save about 1ms of boot time and a small amount of
> -	 * power.
> -	 */
> -	for (i = 0; i < t_sz; i++) {
> -		const struct twl4030_mod_iregs tmr = t[i];
> -		int cor;
> -
> -		/* Are ISRs cleared by reads or writes? */
> -		cor = twl4030_read_cor_bit(tmr.mod_no, tmr.sih_ctrl);
> -		WARN_ON(cor < 0);
> -
> -		for (j = 0; j < tmr.reg_cnt; j++) {
> -
> -			/* Mask interrupts at the TWL4030 */
> -			WARN_ON(twl4030_i2c_write_u8(tmr.mod_no, 0xff,
> -						     tmr.imrs[j]) < 0);
> -
> -			/* Clear TWL4030 ISRs */
> -			WARN_ON(twl4030_i2c_clear_isr(tmr.mod_no,
> -						      tmr.isrs[j], cor) < 0);
> -		}
> -	}
> -
> -	return;

this return can be removed.

> +static void __init twl4030_mask_clear_intrs(const struct twl4030_mod_iregs *t,
> +					    const u8 t_sz)
> +{
> +	int i, j;
> +
> +	/*
> +	 * N.B. - further efficiency is possible here.  Eight I2C
> +	 * operations on BCI and GPIO modules are avoidable if I2C
> +	 * burst read/write transactions were implemented.  Would
> +	 * probably save about 1ms of boot time and a small amount of
> +	 * power.
> +	 */
> +	for (i = 0; i < t_sz; i++) {
> +		const struct twl4030_mod_iregs tmr = t[i];
> +		int cor;
> +
> +		/* Are ISRs cleared by reads or writes? */
> +		cor = twl4030_read_cor_bit(tmr.mod_no, tmr.sih_ctrl);
> +		WARN_ON(cor < 0);
> +
> +		for (j = 0; j < tmr.reg_cnt; j++) {
> +
> +			/* Mask interrupts at the TWL4030 */
> +			WARN_ON(twl4030_i2c_write_u8(tmr.mod_no, 0xff,
> +						     tmr.imrs[j]) < 0);
> +
> +			/* Clear TWL4030 ISRs */
> +			WARN_ON(twl4030_i2c_clear_isr(tmr.mod_no,
> +						      tmr.isrs[j], cor) < 0);
> +		}
> +	}
> +
> +	return;

also this one

-- 
balbi
