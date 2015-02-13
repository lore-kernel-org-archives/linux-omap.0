From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 9/9] RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
Date: Fri, 13 Feb 2015 09:25:18 -0600
Message-ID: <CAGo_u6p89ot-eNwK65otoYsLM6NXeh929=SBG6uKAsX8Tnd_RQ@mail.gmail.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
	<1423840286-18377-10-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:58001 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbbBMPZS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 10:25:18 -0500
Received: by mail-ob0-f172.google.com with SMTP id nt9so21020890obb.3
        for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2015 07:25:18 -0800 (PST)
In-Reply-To: <1423840286-18377-10-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tero Kristo <t-kristo@ti.com>, Felipe Balbi <balbi@ti.com>

On Fri, Feb 13, 2015 at 9:11 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> DRA7xx's CTRL_CORE_CONTROL_IO_2 register contains bits for various
> subsystems, including PCIe, DCAN, QSPI and DSS. At the moment only DCAN
> bits are used by the SW via syscon.
>
> For DSS there is DSS_DESHDCP_CLKEN bit. This (presumably) enables a
> clock related to DSS's HDCP. If that clock is off, DSS module does not
> start at all, causing OCP errors. This means that the HWMOD code is not
> able to reset and initialize DSS.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/io.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index a1bd6affb508..2206fb13f195 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -700,6 +700,17 @@ void __init dra7xx_init_early(void)
>         dra7xx_hwmod_init();
>         omap_hwmod_init_postsetup();
>         omap_clk_soc_init = dra7xx_dt_clk_init;
> +
> +       if (soc_is_dra7xx()) {

Umm.. this code will only be executed for dra7xx :)

> +               u32 v;
> +               const u16 ctrl_core_control_io_2 = 0x558;
> +
> +               /* set CTRL_CORE_CONTROL_IO_2:DSS_DESHDCP_CLKEN */
> +
> +               v = omap_ctrl_readl(ctrl_core_control_io_2);
> +               v |= 1;
> +               omap_ctrl_writel(v, ctrl_core_control_io_2);
> +       }
>  }
>
>  void __init dra7xx_init_late(void)
just my 2 cents.
I would probably wait for control module to become syscon and probably
model this as syscon clk - I thin we should be seeing a series
sometime soon.

-- 
---
Regards,
Nishanth Menon
