From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v3] board-omap3-beagle: add DSS2 support
Date: Wed, 14 Apr 2010 15:01:31 +0300
Message-ID: <l2g6ed0b2681004140501haedcf0f0q711a871009656a6f@mail.gmail.com>
References: <1271245064-24162-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:56504 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab0DNMBc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 08:01:32 -0400
Received: by bwz25 with SMTP id 25so28538bwz.28
        for <linux-omap@vger.kernel.org>; Wed, 14 Apr 2010 05:01:31 -0700 (PDT)
In-Reply-To: <1271245064-24162-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen.kooi@gmail.com>
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>

On Wed, Apr 14, 2010 at 2:37 PM, Koen Kooi <koen.kooi@gmail.com> wrote:
> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV=
-out are supported.
>
> Changes since v1:
> =A0 =A0 =A0 =A0* removed beagle_panel_enable_tv() and beagle_panel_di=
sable_tv()

oh no you didn't, they're still there :)
And changelog should not go into patch description

> Changes since v2:
> =A0 =A0 =A0 =A0* changed to REGULATOR_SUPPLY(_name, _dev_name) for ds=
s regulators
>
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---

comments and changelog goes here

> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0126 +++++++++++++++++=
+++++++-------
> =A01 files changed, 99 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 962d377..4b595b0 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c

<snip>

> +static int beagle_panel_enable_tv(struct omap_dss_device *dssdev)
> +{
> +#define ENABLE_VDAC_DEDICATED =A0 =A0 =A0 =A0 =A0 0x03
> +#define ENABLE_VDAC_DEV_GRP =A0 =A0 =A0 =A0 =A0 =A0 0x20
> +
> + =A0 =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ENABLE_VDAC_DEDICATED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_VDAC_DEDICATED)=
;
> + =A0 =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ENABLE_VDAC_DEV_GRP, TW=
L4030_VDAC_DEV_GRP);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void beagle_panel_disable_tv(struct omap_dss_device *dssdev)
> +{
> + =A0 =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_VDAC_DEDICATED)=
;
> + =A0 =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_VDAC_DEV_GRP);
> +}

<snip>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
