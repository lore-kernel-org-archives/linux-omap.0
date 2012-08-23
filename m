From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: debug needed: twl4030 RTC wakeups: repeated attempts fail on
 Beagle
Date: Thu, 23 Aug 2012 16:51:41 +0530
Message-ID: <50361245.1040504@ti.com>
References: <87d32yd1l4.fsf@ti.com> <CANQgH-a9uiaUnR+G2Y_zzvvS3+Yh-O3b-afkZDsNkQFBWNN+9g@mail.gmail.com> <20120822184211.GA29041@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:41877 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752089Ab2HWLVr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 07:21:47 -0400
Received: by obc16 with SMTP id 16so1345196obc.20
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 04:21:46 -0700 (PDT)
In-Reply-To: <20120822184211.GA29041@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Russ Dill <russ.dill@gmail.com>

On Thursday 23 August 2012 12:12 AM, Felipe Balbi wrote:
>> >  	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>> >  		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
>> > @@ -1266,6 +1267,15 @@ static int omap_i2c_runtime_resume(struct device *dev)
>> >  		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>> >  	}
>> > 
>> > +	while (!(omap_i2c_read_reg(_dev, OMAP_I2C_SYSS_REG) &
>> > +			SYSS_RESETDONE_MASK)) {
>> > +		if (time_after(jiffies, timeout)) {
>> > +			dev_warn(dev, "timeout waiting for controller reset\n");
>> > +				return -ETIMEDOUT;
>> > +		}
>> > +		msleep(1);
>> > +	}
>> > +
>> >  	/*
>> >  	 * Don't write to this register if the IE state is 0 as it can
>> >  	 * cause deadlock.
> That's weird. i2c has SYSS_HAS_RESET_STATUS set, so hwmod framework
> should be checking that for us. And, in fact, SYSS_HAS_RESET_STATUS is
> set on all *data.c files.
Felipe just like writing to sysc reset.

writing

omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);

[...]

omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);

is also a reset() and the hwmod is not aware of that.

1.Hardware reset: A system bus reset (PIRSTNA = 0).
 A device reset causes the system bus reset.

2. Software reset: A software reset by setting the
	SRST bit in the I2C_SYSC register. This bit has exactly the same
	action on the module logic as the system bus reset. 

3.  Partial reset or controller reset. The I2C_EN bit in the I2C_CON
	register can also reset a part of the I^2 C module. When
	the system bus reset is removed (PIRSTNA  = 1), I2C_EN = 0 keeps the
	functional part of I^2 C module in reset state and all
	configuration registers can be accessed.


Since the case 3 is true in my case I am checking and hwmod is not aware
of this.

This read-only bit indicates the state of the reset in case of hardware
reset, global software reset (I2C_SYSC.SRST) or partial software reset
(I2C_CON.I2C_EN).

I am checking for case 3.


>
> When you wrote that patch, did you check that reset hasn't completed
> yet ? I mean, was reset still asserted at that time ? If instead of your
> patch, you just wait longer for reset to complete, will it work ?
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 6ca8e51..7a39c72 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -156,7 +156,7 @@
>  #include "pm.h"
>  
>  /* Maximum microseconds to wait for OMAP module to softreset */
> -#define MAX_MODULE_SOFTRESET_WAIT	10000
> +#define MAX_MODULE_SOFTRESET_WAIT	50000
>  
>  /* Name of the OMAP hwmod for the MPU */
>  #define MPU_INITIATOR_NAME		"mpu"
>
>
> If it does, then reset takes longer to complete on those particular
> boards and it would be nice to know why, but one step at a time :-)
>
> -- balbi

