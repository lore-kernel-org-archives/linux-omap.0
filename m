From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv4 11/15] omap3+: voltage/pwrdm/clkdm/clock add recursive
 usecount tracking
Date: Wed, 30 Nov 2011 10:52:55 +0100
Message-ID: <CAORVsuVMaEZBSPpQ8-jCju7hfCMBFkQ9r2z_ArT-b4dN0pqbcg@mail.gmail.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	<1322236188-19456-12-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48194 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab1K3Jw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Nov 2011 04:52:56 -0500
Received: by vbbfc26 with SMTP id fc26so183705vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 01:52:55 -0800 (PST)
In-Reply-To: <1322236188-19456-12-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, nm@ti.com

Hi Tero,

On Fri, Nov 25, 2011 at 4:49 PM, Tero Kristo <t-kristo@ti.com> wrote:
> This patch fixes the usecount tracking for omap3+, previously the
> usecount numbers were rather bogus and were not really useful for
> any purpose. Now usecount numbers track the number of really active
> clients on each domain. This patch also adds support for usecount
> tracking on powerdomain and voltagedomain levels.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/clkt_iclk.c =A0 =A0 =A0 =A0 | =A0 11 +++++++++
> =A0arch/arm/mach-omap2/clockdomain.c =A0 =A0 =A0 | =A0 38 +++++++++++=
++++++++++++++++++-
> =A0arch/arm/mach-omap2/clockdomain.h =A0 =A0 =A0 | =A0 =A03 ++
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 | =A0 12 +++++++++
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 | =A0 =A05 ++++
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 | =A0 30 +++++++=
+++++++++++++++++
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 | =A0 =A07 +++++
> =A0arch/arm/plat-omap/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0arch/arm/plat-omap/include/plat/clock.h | =A0 =A01 +
> =A09 files changed, 107 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/cl=
kt_iclk.c
> index 3d43fba..8e61776 100644
> --- a/arch/arm/mach-omap2/clkt_iclk.c
> +++ b/arch/arm/mach-omap2/clkt_iclk.c
> @@ -21,6 +21,7 @@
> =A0#include "clock2xxx.h"
> =A0#include "cm2xxx_3xxx.h"
> =A0#include "cm-regbits-24xx.h"
> +#include "clockdomain.h"
>
> =A0/* Private functions */
>
> @@ -34,6 +35,11 @@ void omap2_clkt_iclk_allow_idle(struct clk *clk)
> =A0 =A0 =A0 =A0v =3D __raw_readl((__force void __iomem *)r);
> =A0 =A0 =A0 =A0v |=3D (1 << clk->enable_bit);
> =A0 =A0 =A0 =A0__raw_writel(v, (__force void __iomem *)r);
> +
> + =A0 =A0 =A0 if (clk->usecount && clk->clkdm)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_usecount_dec(clk->clkdm);
Is the test on clk->usecount needed? Is that a problem when usecount re=
aches 0?

> +
> + =A0 =A0 =A0 clk->autoidle =3D 1;
> =A0}
>
> =A0/* XXX */
> @@ -46,6 +52,11 @@ void omap2_clkt_iclk_deny_idle(struct clk *clk)
> =A0 =A0 =A0 =A0v =3D __raw_readl((__force void __iomem *)r);
> =A0 =A0 =A0 =A0v &=3D ~(1 << clk->enable_bit);
> =A0 =A0 =A0 =A0__raw_writel(v, (__force void __iomem *)r);
> +
> + =A0 =A0 =A0 if (clk->usecount && clk->clkdm)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_usecount_inc(clk->clkdm);
Same here.

> +
> + =A0 =A0 =A0 clk->autoidle =3D 0;
> =A0}
>
> =A0/* Public data */
=2E..

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
