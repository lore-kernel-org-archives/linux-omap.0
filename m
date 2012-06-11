From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 11/12] ARM: OMAP4: clock data: add clockdomains for
 clocks used as main clocks
Date: Mon, 11 Jun 2012 18:28:04 +0200
Message-ID: <4FD61C94.4030004@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004623.20034.52760.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39041 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab2FKQ2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 12:28:10 -0400
In-Reply-To: <20120611004623.20034.52760.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi Paul,

On 6/11/2012 2:46 AM, Paul Walmsley wrote:
> Until the OMAP4 code is converted to disable the use of the clock
> framework-based clockdomain enable/disable sequence, any clock used a=
s
> a hwmod main_clk must have a clockdomain associated with it.

But why? The clock domain information is already present in every hwmod=
=20
nodes for OMAP4.

> This
> patch populates some clock structure clockdomain names to resolve the
> following warnings during kernel init:
>
> omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
> omap_hwmod: trace_clk_div_ck: missing clockdomain for trace_clk_div_c=
k.
> omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
> omap_hwmod: ddrphy_ck: missing clockdomain for ddrphy_ck.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-oma=
p2/clock44xx_data.c
> index 2172f66..e2b701e 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -84,6 +84,7 @@ static struct clk slimbus_clk =3D {
>
>   static struct clk sys_32k_ck =3D {
>   	.name		=3D "sys_32k_ck",
> +	.clkdm_name	=3D "prm_clkdm",

In fact, neither prm_clkdm not cm_clkdm are valid clock domain on OMAP4=
 :-(.

I've just realized that you introduced that for 3.5, but this is wrong.=
=20
We should not start adding some fake clock domains just because the fmw=
k=20
is not smart enough to allow a NULL clock domain.

The clkdomain should be optional, at least for clock nodes.
There is no need to enforce the presence of the clock domain in the=20
structure. We should remove the warning and test the clkdm attribute=20
before de-referencing it inside the clock core code.

This is the only proper fix for that issue for my point of view.

In a period of data size reduction, adding some fake information does=20
not seems to be the right approach.
Don't you think so?

Regards,
Benoit


PS: I think we should revert 6ba5a69ee92c29c2ffc814dad6ac61c4cd49090c=20
(ARM: OMAP2+: clockdomains: make {prm,cm}_clkdm common) and fix the=20
OMAP4 hwmod data.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
