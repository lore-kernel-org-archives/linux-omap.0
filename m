From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 0/2] twl4030-madc driver
Date: Wed, 16 Feb 2011 18:00:59 +0530
Message-ID: <AANLkTin6BAL-iVZWmagzfFadrYpj5AsoRVU9evE-V+ur@mail.gmail.com>
References: <1297859166-8267-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44288 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755530Ab1BPMbB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:31:01 -0500
Received: by mail-gw0-f54.google.com with SMTP id 21so604225gwj.41
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:31:00 -0800 (PST)
In-Reply-To: <1297859166-8267-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com
Cc: mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, j-keerthy@ti.com, linux-omap@vger.kernel.org

Hello all,

I will resend once again the right set. I apologise.

Regards,
Keerthy
On Wed, Feb 16, 2011 at 5:56 PM, Keerthy <j-keerthy@ti.com> wrote:
> MADC(Monitoring ADC) driver enables monitoring analog signals using
> analog-to-digital conversion (ADC) on the input source.
> The previous discussion concluded in keeping the generic ADC
> functionality and the hwmon separate. The discussion can be found her=
e:
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41805.html
>
> Keerthy (2):
> =A0mfd: twl4030: Driver for twl4030 madc module
> =A0hwmon: twl4030: Hwmon Driver for TWL4030 MADC
>
> =A0Documentation/hwmon/twl4030-madc-hwmon | =A0 45 ++
> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 10 =
+
> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 =
+
> =A0drivers/hwmon/twl4030-madc-hwmon.c =A0 =A0 | =A0155 +++++++
> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 1=
0 +
> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 +
> =A0drivers/mfd/twl4030-madc.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0721 ++++++=
++++++++++++++++++++++++++
> =A0include/linux/i2c/twl4030-madc.h =A0 =A0 =A0 | =A0132 ++++++
> =A08 files changed, 1075 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/hwmon/twl4030-madc-hwmon
> =A0create mode 100644 drivers/hwmon/twl4030-madc-hwmon.c
> =A0create mode 100644 drivers/mfd/twl4030-madc.c
> =A0create mode 100644 include/linux/i2c/twl4030-madc.h
>
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
