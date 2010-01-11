From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/6] Regulator: Use common regulator supplies and init
	data structs
Date: Mon, 11 Jan 2010 14:41:58 +0200
Message-ID: <6ed0b2681001110441j75863ab8l467fdf2660328171@mail.gmail.com>
References: <1262973479-32570-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:58198 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab0AKMmD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 07:42:03 -0500
Received: by fg-out-1718.google.com with SMTP id 22so694278fge.1
        for <linux-omap@vger.kernel.org>; Mon, 11 Jan 2010 04:41:58 -0800 (PST)
In-Reply-To: <1262973479-32570-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

On Fri, Jan 8, 2010 at 7:57 PM, Anuj Aggarwal <anuj.aggarwal@ti.com> wr=
ote:
> Common TWL4030 specific regulator supplies and init data structs are
> used instead of platform specific ones. Only one copy of the common
> structs will be included in the image, built for multiple OMAP3 based
> platforms.
>
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 32 ++=
+++++++++++++++--------
> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 | =A0 14 ++=
++++++---
> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 | =A0 =A07 ++=
++-
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
7 ++++-
> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0| =A0 14 ++++++=
++---
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 | =A0 25 ++++=
+++++++++-------
> =A0arch/arm/mach-omap2/board-omap3pandora.c =A0 =A0 | =A0 14 ++++++++=
---
> =A0arch/arm/mach-omap2/board-omap3touchbook.c =A0 | =A0 14 ++++++++--=
-
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
8 +++++-
> =A0arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 21 +++++++++++-=
----
> =A010 files changed, 108 insertions(+), 48 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap=
2/board-3430sdp.c
> index 2951029..b1267eb 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -55,6 +55,18 @@
>
> =A0#define TWL4030_MSECURE_GPIO 22
>
> +extern struct regulator_consumer_supply twl4030_vmmc1_supply;
> +extern struct regulator_consumer_supply twl4030_vmmc2_supply;
> +extern struct regulator_consumer_supply twl4030_vsim_supply;
> +
> +extern struct regulator_init_data vaux1_data;
> +extern struct regulator_init_data vaux2_data;
> +extern struct regulator_init_data vaux3_data;
> +extern struct regulator_init_data vaux4_data;
> +extern struct regulator_init_data vmmc1_data;
> +extern struct regulator_init_data vmmc2_data;
> +extern struct regulator_init_data vsim_data;

Have you tried running your patches through ./scripts/checkpatch.pl?

WARNING: externs should be avoided in .c files
#75: FILE: arch/arm/mach-omap2/board-3430sdp.c:58:
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;

<snip>

> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach=
-omap2/board-omap3pandora.c
> index 4a24d94..98b46ef 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c

<snip>

> @@ -258,8 +264,8 @@ static struct twl4030_platform_data omap3pandora_=
twldata =3D {
> =A0 =A0 =A0 =A0.gpio =A0 =A0 =A0 =A0 =A0 =3D &omap3pandora_gpio_data,
> =A0 =A0 =A0 =A0.usb =A0 =A0 =A0 =A0 =A0 =A0=3D &omap3pandora_usb_data=
,
> =A0 =A0 =A0 =A0.codec =A0 =A0 =A0 =A0 =A0=3D &omap3pandora_codec_data=
,
> - =A0 =A0 =A0 .vmmc1 =A0 =A0 =A0 =A0 =A0=3D &pandora_vmmc1,
> - =A0 =A0 =A0 .vmmc2 =A0 =A0 =A0 =A0 =A0=3D &pandora_vmmc2,
> + =A0 =A0 =A0 .vmmc1 =A0 =A0 =A0 =A0 =A0=3D &vmmc1_data,
> + =A0 =A0 =A0 .vmmc2 =A0 =A0 =A0 =A0 =A0=3D &vmmc2_data,

Your common supply file has VMMC2 supply configured for 1.8V which is
wrong for pandora (it uses 3.1V because it has a transceiver attached
to MMC2 that handles level shifting transparently).

I think you should leave pandora board file alone, because it uses
many supplies differently than your common file configures them
(VAUX1-VAUX4, VSIM differ, only VMMC1, VDAC and VPLL2 match, which is
not that much duplication).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
