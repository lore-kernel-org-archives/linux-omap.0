From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Tue, 18 Jan 2011 14:44:24 +0530
Message-ID: <AANLkTiko+QoLQn-qA9km-_WNfokrLimt2+D7UGmm_VpV@mail.gmail.com>
References: <1295336995-15831-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58679 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753053Ab1ARJPG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 04:15:06 -0500
Received: by iwn40 with SMTP id 40so5635108iwn.3
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 01:15:04 -0800 (PST)
In-Reply-To: <1295336995-15831-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Couple of minor comments.

On Tue, Jan 18, 2011 at 13:19, Sanjeev Premi <premi@ti.com> wrote:
> This patch adds support for new speed enhanced parts with ARM
> and IVA running at 720MHz and 520MHz respectively. These parts
> can be probed at run-time by reading PRODID.SKUID[3:0] at
> 0x4830A20C [1].
>
> This patch specifically does following:
> =A0* Detect devices capable of 720MHz.
> =A0* Add new OPP
> =A0* Ensure that OPP is conditionally enabled.
> =A0* Check for presence of IVA before attempting to enable
> =A0 the corresponding OPP.
>
> =A0[1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> Since v2:
> 1) pr_xxx() -> dev_xxx() functions - suggested by
> =A0 Manjunath (manjugk@ti.com)
> 2) Add check for presense of IVA - earlier planned to
> =A0 be in a separate patch; but we multiple discussions
> =A0 on optimizations.
> 3) Do look-up for hwmod corresponding for iva only if
> =A0 iva is present. Should save multiple strcmp()s in
> =A0 _lookup().
>
> Since v1:
> 1) Using opp_enable() to enable the OPP after the OPP
> =A0 table has been initialized.
> 2) Starting at 3 levels of indent, the statements had
> =A0 be broken into multiple lines for most of the code.
> =A0 So, opted to create a new static that enables the
> =A0 OPPs corresponding to 720MHz.
> 3) I have only build tested this patch - will be able
> =A0 to confirm working tomorrow. With any further change,
> =A0 if needed. (However, functionally nothing has changed.)
>
>
> =A0arch/arm/mach-omap2/control.h =A0 =A0 =A0 =A0 | =A0 =A07 ++++
> =A0arch/arm/mach-omap2/id.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 10 +++++
> =A0arch/arm/mach-omap2/opp3xxx_data.c =A0 =A0| =A0 63 +++++++++++++++=
+++++++++++++++++-
> =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 =A02 +
> =A04 files changed, 81 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/cont=
rol.h
> index f0629ae..eebc045 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -365,6 +365,13 @@
> =A0#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FEAT_NEON =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 0
> =A0#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FEAT_NEON_NONE =A0 =A0 =A0 =
=A0 =A01
>
> +/*
> + * Product ID register
> + */

Do not use multiline comment style for single line comments

> +#define OMAP3_PRODID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x020C
> +
> +#define OMAP3_SKUID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0f
> +#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3_SKUID_720MHZ =A0 =A0 =A0=
0x08
>
> =A0#ifndef __ASSEMBLY__
> =A0#ifdef CONFIG_ARCH_OMAP2PLUS
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 5f9086c..53fbe01 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -195,6 +195,15 @@ static void __init omap3_check_features(void)
> =A0 =A0 =A0 =A0 * TODO: Get additional info (where applicable)
> =A0 =A0 =A0 =A0 * =A0 =A0 =A0 e.g. Size of L2 cache.
> =A0 =A0 =A0 =A0 */
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Does it support 720MHz?
> + =A0 =A0 =A0 =A0*/

Ditto

> + =A0 =A0 =A0 status =3D (OMAP3_SKUID_MASK & read_tap_reg(OMAP3_PRODI=
D));
> +
> + =A0 =A0 =A0 if (status & OMAP3_SKUID_720MHZ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_features |=3D OMAP3_HAS_720MHZ;
> + =A0 =A0 =A0 }

No need of { } as there is only one line statement inside the if condit=
ion.

> =A0}
>
> =A0static void __init omap3_check_revision(void)
> @@ -445,6 +454,7 @@ static void __init omap3_cpuinfo(void)
> =A0 =A0 =A0 =A0OMAP3_SHOW_FEATURE(neon);
> =A0 =A0 =A0 =A0OMAP3_SHOW_FEATURE(isp);
> =A0 =A0 =A0 =A0OMAP3_SHOW_FEATURE(192mhz_clk);
> + =A0 =A0 =A0 OMAP3_SHOW_FEATURE(720mhz);
>
> =A0 =A0 =A0 =A0printk(")\n");
> =A0}

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
