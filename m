From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH V2] hwmon: twl4030: Driver for twl4030 madc module
Date: Tue, 9 Nov 2010 19:10:07 +0530
Message-ID: <6d8d369473ef89e6b2c20252b7007b8a@mail.gmail.com>
References: <1289294457-5330-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35873 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629Ab0KINkL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 08:40:11 -0500
Received: by mail-wy0-f175.google.com with SMTP id 34so43902wyb.20
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 05:40:09 -0800 (PST)
In-Reply-To: <1289294457-5330-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J KEERTHY <j-keerthy@ti.com>, lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com, khali@linux-fr.org
Cc: mikko.k.ylinen@nokia.com, Felipe Balbi <balbi@ti.com>, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, Balaji T Krishnamoorthy <balajitk@ti.com>

> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for
monitoring
> ADC. This driver monitors the real time conversion of analog signals
like
> battery temperature, battery type, battery level etc. User can also ask
for
> the conversion on a particular channel using the sysfs nodes.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

...


> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a56f6ad..fef75f2 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1171,6 +1171,12 @@ config SENSORS_MC13783_ADC
>          help
>            Support for the A/D converter on MC13783 PMIC.
>
> +config SENSORS_TWL4030_MADC
> +	tristate

You need to provide some label text here, otherwise this option
will not show up in the kernel configuration tools, and hence
cannot be turned on or off from there.

- Anand
