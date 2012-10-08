From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] ARM: OMAP: convert I2C driver to PM QoS for MPU latency constraints
Date: Mon, 8 Oct 2012 11:00:46 +0200
Message-ID: <CAORVsuWv1HmaiYxfJVr1h5_r_+UHxXLVeLoVmH4RuO5egZoqqA@mail.gmail.com>
References: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
	<20121006114614.GB10164@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45876 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab2JHJAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 05:00:48 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2766737lbo.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Oct 2012 02:00:46 -0700 (PDT)
In-Reply-To: <20121006114614.GB10164@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Sat, Oct 6, 2012 at 1:46 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Sep 20, 2012 at 06:08:03PM +0200, Jean Pihet wrote:
>> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
>> API to the new PM QoS API.
>> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
>> class of PM QoS. The resulting MPU constraints are used by cpuidle to
>> decide the next power state of the MPU subsystem.
>>
>> The I2C device latency timing is derived from the FIFO size and the
>> clock speed and so is applicable to all OMAP SoCs.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Applied to -next, thanks!
Thanks!

Jean
>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
