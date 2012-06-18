From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 5/7] ARM: OMAP4: clock data: add clockdomains for clocks
 used as main clocks
Date: Mon, 18 Jun 2012 11:35:36 +0200
Message-ID: <4FDEF668.6050108@ti.com>
References: <20120618061037.30632.28539.stgit@dusk> <20120618061608.30632.62660.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58509 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954Ab2FRJgC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 05:36:02 -0400
In-Reply-To: <20120618061608.30632.62660.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi Paul,

On 6/18/2012 8:16 AM, Paul Walmsley wrote:
> Until the OMAP4 code is converted to disable the use of the clock
> framework-based clockdomain enable/disable sequence, any clock used a=
s
> a hwmod main_clk must have a clockdomain associated with it.  This
> patch populates some clock structure clockdomain names to resolve the
> following warnings during kernel init:
>=20
> omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
> omap_hwmod: trace_clk_div_ck: missing clockdomain for trace_clk_div_c=
k.
> omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
> omap_hwmod: ddrphy_ck: missing clockdomain for ddrphy_ck.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-oma=
p2/clock44xx_data.c
> index 2172f66..e2b701e 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -84,6 +84,7 @@ static struct clk slimbus_clk =3D {
>  =20
>   static struct clk sys_32k_ck =3D {
>   	.name		=3D "sys_32k_ck",
> +	.clkdm_name	=3D "prm_clkdm",

I guess that patch need to be revisited based on discussion we had and =
the patch you proposed in [1].
Assuming Tony is OK, it should be probably part of the -rc, because thi=
s domain should not have been introduced in 3.5-rc1 at all for OMAP4.
So it will be better to revert the patch that introduced that first bef=
ore adding any new fix that will rely on a code that will disappear.


In fact, I think the proper way to fix that while maintaining the OMAP2=
&3 way of dealing with clkdm is to ensure that at least one clkdm is th=
ere in either hwmod or the main_clk.
That will fix these issues and the one that will append when the fake m=
ain_clk will be removed.

Here is a patch that is doing that.


Thanks,
Benoit

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70177.htm=
l


---=20
=46rom e5ffe6533236125c3c0b5eff883bfc1cf3cbe9f4 Mon Sep 17 00:00:00 200=
1
=46rom: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 15 Jun 2012 11:26:49 +0200
Subject: [PATCH] ARM: OMAP2+: hwmod: Do not check clkdm for main_clk if=
 oh does have one

When a clkdm is handled directly at the hwmod level, there is no need t=
o handle
it with the main_clk as well. It is thus useless to complain about the =
missing clkdm for the main_clk in that case.

Warn only if the clkdm is missing in both main_clk and hwmod.

Init hwmod clkdm first to ensure it will be there when the main_clk
will be initialized.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 162f9c7..f33f4e2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -609,7 +609,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
=20
-	if (!oh->_clk->clkdm)
+	if (!oh->_clk->clkdm && !oh->clkdm)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
 			   oh->main_clk, oh->_clk->name);
=20
@@ -1339,10 +1339,10 @@ static int _init_clocks(struct omap_hwmod *oh, =
void *data)
=20
 	pr_debug("omap_hwmod: %s: looking up clocks\n", oh->name);
=20
+	ret |=3D _init_clkdm(oh);
 	ret |=3D _init_main_clk(oh);
 	ret |=3D _init_interface_clks(oh);
 	ret |=3D _init_opt_clks(oh);
-	ret |=3D _init_clkdm(oh);
=20
 	if (!ret)
 		oh->_state =3D _HWMOD_STATE_CLKS_INITED;
--=20
1.7.0.4



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
