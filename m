From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/7] mfd: twl4030-power: Enable off-idle configuration
 when booted with device tree
Date: Tue, 27 May 2014 17:52:34 +0100
Message-ID: <20140527165234.GF4227@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400031250-29542-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

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

Whoops, nearly forgot about this patchset.

Tony, can you resend it with all your fix-ups please.  The 8< doesn't
work well with my patch application 'system'.

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
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
