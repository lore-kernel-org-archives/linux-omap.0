From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: Re: Regulator question regarding I2C devices
Date: Sat, 29 Jan 2011 18:34:46 +0100
Message-ID: <20110129173446.GG32186@darwin>
References: <4D434201.6060108@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:58856 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab1A2Rgp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Jan 2011 12:36:45 -0500
Received: from relay4-v.mail.gandi.net (relay4-v.mail.gandi.net [217.70.178.78])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 4C5DB86357
	for <linux-omap@vger.kernel.org>; Sat, 29 Jan 2011 18:35:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D434201.6060108@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@logicpd.com>
Cc: linux-omap@vger.kernel.org

Hi Peter,

El Fri, Jan 28, 2011 at 05:24:01PM -0500 Peter Barada ha dit:

> I have a tsc2004 touch controller on I2C3 that is powered by vaux1,
> and since its probed I have to turn the power on before it can be
> probed.
>
> I've created:
> 
> static struct regulator_consumer_supply dm3730logic_vaux1_supply = {
>     .supply            = "vaux1",
> };
> 
> /* VAUX1 for touch chip */
> static struct regulator_init_data dm3730logic_vaux1 = {
>     .constraints = {
>         .min_uV        = 3000000,
>         .max_uV        = 3000000,
>         .apply_uV    = true,
>         .valid_modes_mask    = REGULATOR_MODE_NORMAL
>                     | REGULATOR_MODE_STANDBY,
>         .valid_ops_mask        = REGULATOR_CHANGE_MODE
>                     | REGULATOR_CHANGE_STATUS,
>     },
>     .num_consumer_supplies    = 1,
>     .consumer_supplies    = &dm3730logic_vaux1_supply,
> };
> 
> and listed it in the twldata initializer
>     .vaux1        = &dm3730logic_vaux1,
> 
> But it never gets enabled...  How can I tell the kernel to turn the regulator on?
> 
> If I try to call regulator_get() right before the call to omap_register_i2c_bus for I2C3, regulator_get returns a NULL due to regulator_map_list being empty.  If I look in sys/class/regulator I see VAUX1 listed (as regulator.4), but there are no users.
> 
> Any suggestions on how I can turn on vaux1 so the tsc2004 touch
> controller is visible to by the I2C system?

I guess the problem is that the regulators aren't initialized when you
call regulator_get() before the i2c bus registration

I think the right thing is to do the regulator handling inside the
tsc2004 driver

The ADS7846 touchscreen driver (drivers/input/touchscreen/ads7846.c)
in combination with the TimLL Devkit8000 board
(arch/arm/mach-omap2/board-devkit8000.c) can serve you as a reference

Best regards

-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

              You can't separate peace from freedom because no
               one can be at peace unless he has his freedom
                              (Malcolm X)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
