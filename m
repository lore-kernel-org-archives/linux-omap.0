From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [RFC][PATCH 10/9] OMAP4: HWMOD: differentiate 4430 and 4460 bandgap
Date: Wed, 25 May 2011 20:46:37 -0700
Message-ID: <BANLkTinaxu1DxGknG8GXho73rm42B-g5hg@mail.gmail.com>
References: <1306381285-17764-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58771 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752519Ab1EZDq6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 23:46:58 -0400
Received: by mail-qw0-f49.google.com with SMTP id 2so248948qwi.22
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 20:46:57 -0700 (PDT)
In-Reply-To: <1306381285-17764-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, May 25, 2011 at 8:41 PM, Nishanth Menon <nm@ti.com> wrote:
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
<snip>
> +static struct omap_hwmod_opt_clk bandgap446x_opt_clks[] =3D {
> + =A0 =A0 =A0 { .role =3D "fclk", .clk =3D "bandgap_ts_fclk" },
> +};
> +
> +static struct omap_hwmod omap446x_bandgap_hwmod =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "bandgap",
> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_bandgap_hwmod_c=
lass,
> + =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP44=
30_CM_WKUP_BANDGAP_CLKCTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .opt_clks =A0 =A0 =A0 =3D bandgap446x_opt_clks,
> + =A0 =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(bandgap446x_opt_clks),
> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44=
60),

Does it call for having CHIP_IS_OMAP446X instead of CHIP_IS_OMAP4460 ?

What happens when we get say es2.0 for 4460? how do you accommodate tha=
t?
Take care of that case when the new silicon arrives or fix it now :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
