From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/4] mfd: tps65917: Add driver for the TPS65917 PMIC
Date: Fri, 23 May 2014 12:18:43 +0100
Message-ID: <20140523111843.GW19747@lee--X1>
References: <1400731239-3180-1-git-send-email-j-keerthy@ti.com>
 <1400731239-3180-4-git-send-email-j-keerthy@ti.com>
 <20140522083707.GM6679@lee--X1>
 <537DD836.3040501@ti.com>
 <20140522114808.GU6679@lee--X1>
 <537EBEE4.9050309@ti.com>
 <20140523100634.GP19747@lee--X1>
 <537F2A15.9060901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55750 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbaEWLSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 07:18:51 -0400
Received: by mail-ie0-f174.google.com with SMTP id lx4so4895726iec.19
        for <linux-omap@vger.kernel.org>; Fri, 23 May 2014 04:18:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537F2A15.9060901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, sameo@linux.intel.com, grant.likely@linaro.org, ian@slimlogic.co.uk, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@linaro.org, linux-omap@vger.kernel.org

> >>>>>>The TPS65917 chip is a power management IC for Portable Navigat=
ion Systems
> >>>>>>and Tablet Computing devices. It contains the following compone=
nts:
> >>>>>>
> >>>>>>  - Regulators.
> >>>>>>  - Over Temperature warning and Shut down.
> >>>>>>
> >>>>>>This patch adds support for tps65917 mfd device. At this time o=
nly
> >>>>>>the regulator functionality is made available.
> >>>>>>
> >>>>>>Signed-off-by: Keerthy <j-keerthy@ti.com>
> >>>>>>---
> >>>>>>v3 Changes:
> >>>>>>
> >>>>>>  * Header file formating
> >>>>>>  * Changed the cache_type to REGCACHE_RBTREE
> >>>>>>  * removed unnecessary code
> >>>>>>  * Corrected documentation style
> >>>>>>  * Added pm_power_off function
> >>>>>>
> >>>>>>  v2 Changes:
> >>>>>>
> >>>>>>  * Added volatile register check as some of the registers
> >>>>>>    in the set are volatile.
> >>>>>>drivers/mfd/Kconfig          |   12 +
> >>>>>>  drivers/mfd/Makefile         |    1 +
> >>>>>>  drivers/mfd/tps65917.c       |  594 +++++++++++++++++
> >>>>>>  include/linux/mfd/tps65917.h | 1485 +++++++++++++++++++++++++=
+++++++++++++++++
> >>>>>>  4 files changed, 2092 insertions(+)
> >>>>>>  create mode 100644 drivers/mfd/tps65917.c
> >>>>>>  create mode 100644 include/linux/mfd/tps65917.h
> >[...]
> >
> >>>>>>+		ret =3D regmap_read(tps65917->regmap[slave], addr, &reg);
> >>>>>>+		if (ret)
> >>>>>>+			goto err_irq;
> >>>>>>+	}i
> >>>>>What does the read do?  You're not doing anything with the value=
=2E
> >>>>This pad1 and pad2 stuff is not needed. I will remove this.
> >>>Then why is it in here?
> >>>
> >>>Did you copy this code from somewhere, if so, where?
> >>>
> >>>Okay, I just answered my own question.  There is so much common co=
de
> >>>in between this and palmas, there is no way I'm going to accept th=
is
> >>>driver.  Please merge it in with the palmas driver!
> >>>
> >>The chip is more like a subset of palmas with lot of register offse=
t changes
> >>and register bit field changes. Adding this would make it clumsy.
> >>There could
> >>be lot of checks. That is why i chose to write a new driver.
> >>
> >>Palmas driver already supports palmas variants and tps659038. Mergi=
ng
> >>this would mean more and more checks :-/.
> >Then find an elegant way of representing the variants.  I'm not
> >prepared to carry that much duplicated code in MFD.  It's already
> >overladened and in need of an overhaul.  This will exacerbate the
> >matter.
> >
>=20
> Okay. I am working on that.

Thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
