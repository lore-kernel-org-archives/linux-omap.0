From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2 v2] OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
Date: Tue, 05 Apr 2011 11:27:33 -0700
Message-ID: <87mxk4zh7u.fsf@ti.com>
References: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
	<1302018015-8858-2-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:43311 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753951Ab1DES1i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 14:27:38 -0400
Received: by mail-iy0-f178.google.com with SMTP id 12so773805iyi.37
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 11:27:37 -0700 (PDT)
In-Reply-To: <1302018015-8858-2-git-send-email-avinashhm@ti.com> (Avinash
	H. M.'s message of "Tue, 5 Apr 2011 21:10:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M" <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

"Avinash.H.M" <avinashhm@ti.com> writes:

> The i2c module has a special reset sequence. The sequence is
> - Disable the I2C.
> - Write to SOFTRESET bit.
> - Enable the I2C.
> - Poll on the RESETDONE bit.
> This sequence must be followed for i2c reset in omap2, omap3. The sequence is
> implemented as a function and the i2c_class is updated with the correct
> 'reset' pointer.
>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>

[...]

> +
> +/**
> + * omap_i2c_reset- reset the omap i2c module.
> + * @oh: struct omap_hwmod *
> + *
> + * The i2c moudle in omap2, omap3 had a special sequence to reset. The
> + * sequence is:
> + * - Disable the I2C.
> + * - Write to SOFTRESET bit.
> + * - Enable the I2C.
> + * - Poll on the RESETDONE bit.
> + * The sequence is implemented in below function. This is called for 2420,
> + * 2430 and omap3.
> + */
> +int omap_i2c_reset(struct omap_hwmod *oh)
> +{
> +	u32 v;
> +	int c = 0;
> +
> +	/* Disable I2C */
> +	v = omap_hwmod_read(oh, I2C_CON_OFFSET);
> +	v = v & ~I2C_EN;
> +	omap_hwmod_write(v, oh, I2C_CON_OFFSET);
> +
> +	/* Write to the SOFTRESET bit */
> +	v = oh->_sysc_cache;
> +	v |= (0x1 << oh->class->sysc->sysc_fields->srst_shift);
> +
> +	oh->_sysc_cache = v;
> +	omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);

Direct SYSCONFIG access isn't right here.   This should go through
omap_hwmod.

What is probably needed is exposing _ocp_softreset to device code
via something like omap_hwmod_ocp_softreset() and calling that here.

Kevin
