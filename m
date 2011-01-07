From: Nishanth Menon <nm@ti.com>
Subject: Re: Latest regressions
Date: Fri, 07 Jan 2011 06:58:25 -0600
Message-ID: <4D270DF1.8060804@ti.com>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:57989 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779Ab1AGM6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 07:58:36 -0500
Received: by mail-gw0-f50.google.com with SMTP id a18so7681616gwa.23
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 04:58:36 -0800 (PST)
In-Reply-To: <20110107115744.GL1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, "Gopinath, Thara" <thara@ti.com>

Russell King - ARM Linux wrote, on 01/07/2011 05:57 AM:
> In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:37=
,
>                   from arch/arm/mach-omap2/io.c:45:
> arch/arm/plat-omap/include/plat/voltage.h: In function =E2=96=A0omap_=
voltage_register_pmic=E2=96=A0:
> arch/arm/plat-omap/include/plat/voltage.h:137: warning: no return sta=
tement in function returning non-void
>
> which gets spammed out all through the build.  voltage.h:137 says:
>
> static inline int omap_voltage_register_pmic(struct voltagedomain *vo=
ltdm,
>                  struct omap_volt_pmic_info *pmic_info) {}
>
> but no one checks the return value for this:
>
> arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm,&om=
ap4_mpu_volt_info);
> arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm,&om=
ap4_iva_volt_info);
> arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm,&om=
ap4_core_volt_info);
> arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm,&om=
ap3_mpu_volt_info);
> arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm,&om=
ap3_core_volt_info);
>
> so I don't see the point of it returning an 'int'.
intent was that in the future the volt_info would be validated and user=
s=20
will check as well.


--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
