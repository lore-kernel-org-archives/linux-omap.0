From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH V2] hwmon: twl4030: Driver for twl4030 madc module
Date: Tue, 9 Nov 2010 19:16:49 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706FD41D1D2@dbde02.ent.ti.com>
References: <1289294457-5330-1-git-send-email-j-keerthy@ti.com>
 <6d8d369473ef89e6b2c20252b7007b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38763 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab0KINrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 08:47:41 -0500
In-Reply-To: <6d8d369473ef89e6b2c20252b7007b8a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "guenter.roeck@ericsson.com" <guenter.roeck@ericsson.com>, "sameo@linux.intel.com" <sameo@l>
Cc: "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "Balbi, Felipe" <balbi@ti.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Hello Anand,

-----Original Message-----
From: Gadiyar, Anand 
Sent: Tuesday, November 09, 2010 7:10 PM
To: J, KEERTHY; lm-sensors@lm-sensors.org; guenter.roeck@ericsson.com; sameo@linux.intel.com; khali@linux-fr.org
Cc: mikko.k.ylinen@nokia.com; Balbi, Felipe; amit.kucheria@canonical.com; linux-omap@vger.kernel.org; Krishnamoorthy, Balaji T
Subject: RE: [PATCH V2] hwmon: twl4030: Driver for twl4030 madc module

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

Ok. I get it. I will add a label.

- Anand

Thanks,
Keerthy
