From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 0/7] mfd: twl4030-power: Enable off-idle configuration
 when booted with device tree
Date: Wed, 21 May 2014 10:23:05 +0100
Message-ID: <20140521092305.GE6679@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33276 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbaEUJXL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 05:23:11 -0400
Received: by mail-ie0-f180.google.com with SMTP id tp5so1625795ieb.25
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2014 02:23:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400031250-29542-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

> Here's an updated set of patches to enable low-power idle modes
> for some omap3 boards when booted with device tree.
>=20
> This series when applied on top of the patches in tread              =
                                                                       =
                 =20
> "[PATCH 00/11] Fixes for omap PM for making omap3 DT only",
> or omap-for-v3.16/pm branch.
>=20
> Lee, if these patches look OK to you, please feel free to=20
> pick them, preferrably to the immutable branch you already
> have set up so I can also merge them in to be able to have
> things working in my branch properly for PM.

Okay, it looks like this series is good to go now.  If you believe so
too, give me the nod and I'll apply.

> Tony Lindgren (7):
>   mfd: twl4030-power: Fix hang on reboot if sleep configuration was
>     loaded earlier
>   mfd: twl4030-power: Fix some defines for SW_EVENTS
>   mfd: twl4030-power: Add generic reset configuration
>   mfd: twl4030-power: Add recommended idle configuration
>   mfd: twl4030-power: Add support for board specific configuration
>   mfd: twl4030power: Add a configuration to turn off oscillator durin=
g
>     off-idle
>   ARM: dts: Enable twl4030 off-idle configuration for selected omaps
>=20
>  .../devicetree/bindings/mfd/twl4030-power.txt      |  17 +-
>  arch/arm/boot/dts/omap3-beagle-xm.dts              |   6 +
>  arch/arm/boot/dts/omap3-evm-common.dtsi            |   7 +
>  arch/arm/boot/dts/omap3-n900.dts                   |   5 +
>  drivers/mfd/twl4030-power.c                        | 269 +++++++++++=
++++++++--
>  include/linux/i2c/twl.h                            |   4 +
>  6 files changed, 284 insertions(+), 24 deletions(-)
>=20

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
