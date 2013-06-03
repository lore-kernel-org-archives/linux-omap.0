From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/2] i2c: omap: convert to module_platform_driver()
Date: Mon, 03 Jun 2013 13:59:31 -0700
Message-ID: <87fvwylxl8.fsf@linaro.org>
References: <1366723151-23209-1-git-send-email-grygorii.strashko@ti.com>
	<1366723151-23209-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:59215 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695Ab3FCU7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 16:59:35 -0400
Received: by mail-pd0-f177.google.com with SMTP id u10so526731pdi.36
        for <linux-omap@vger.kernel.org>; Mon, 03 Jun 2013 13:59:34 -0700 (PDT)
In-Reply-To: <1366723151-23209-2-git-send-email-grygorii.strashko@ti.com>
	(Grygorii Strashko's message of "Tue, 23 Apr 2013 16:19:09 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> The OMAP I2C driver has a relation to pinctrl-single driver. As result,
> its probe will be deferred during system boot until late init time,
> because the pinctrl-single is initizalized as moudle/device init time.
> This, in turn, will delay initialization of all I2C devices (like mfd,
> I2C regulators and etc.) and cause boot delay (more over, it can broken
> initialization of drivers which are not ready to use deferred probe
> mechanism yet, for example DSS).
>
> There are no sense to keep OMAP I2C initialization on subsys init layer
> any more, hence shift it to module/device layer where the i2c <-->
> pinctrl-single dependency is resolved in drivers/Makefile now.
>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Testing this patch with PATCH 1/2, the twl_rtc driver fails to correctly
initialize on OMAP3:

         twl_rtc rtc.22: hctosys: invalid date/time

instead of the expected result:

          twl_rtc rtc.22: setting system clock to 2000-01-01 00:00:00 UTC (946684800)

so something is still not right for the init sequence.

Kevin
