From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4: clock: Add optional clock nodes
Date: Wed, 22 Sep 2010 09:34:51 +0200
Message-ID: <4C99B19B.1060909@ti.com>
References: <1285103430-5964-1-git-send-email-b-cousson@ti.com> <1285103430-5964-2-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1009220125520.21002@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39232 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016Ab0IVHez (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 03:34:55 -0400
In-Reply-To: <alpine.DEB.2.00.1009220125520.21002@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

Hi Paul,

On 9/22/2010 9:29 AM, Paul Walmsley wrote:
> Hi Beno=EEt,
>
> On Tue, 21 Sep 2010, Benoit Cousson wrote:
>
>> OMAP4 IP optional clocks require explicit enable in module CTRLCLK
>> register. In order to allow that we have to create artificial clock
>> nodes that represent this clock inputs in the IP.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>> Cc: Rajendra Nayak<rnayak@ti.com>
>
> Due to the merge conflicts mentioned earlier, this patch had to be
> manually edited.  The updated patch is below - could you and Rajendra
> doublecheck it (or at least the final clock44xx_data.c, which will be
> posted in a few minutes) to make sure that I didn't trash anything to=
o
> badly?

Sorry about that, I had the same issue when I migrated this patches to=20
ES2. I probably, have somewhere the version of that patch that apply on=
=20
top of Rajendra's one.

Regards,
Benoit

>
> thanks,
>
> - Paul
>
>
>  From 64d45f071b43fa6c5e3ecd99d0058494a708f8a7 Mon Sep 17 00:00:00 20=
01
> From: Benoit Cousson<b-cousson@ti.com>
> Date: Tue, 21 Sep 2010 23:10:30 +0200
> Subject: [PATCH] OMAP4: clock: Add optional clock nodes
>
> OMAP4 IP optional clocks require explicit enable in module CTRLCLK
> register. In order to allow that we have to create artificial clock
> nodes that represent this clock inputs in the IP.
>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/clock44xx_data.c |  477 +++++++++++++++++++++++=
++++++-----
>   1 files changed, 417 insertions(+), 60 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-oma=
p2/clock44xx_data.c
> index 401a6c4..d612e55 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -1284,6 +1284,16 @@ static struct clk aess_fck =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk bandgap_fclk =3D {
> +       .name           =3D "bandgap_fclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_BGAP_32K_SHIFT,
> +       .clkdm_name     =3D "l4_wkup_clkdm",
> +       .parent         =3D&sys_32k_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk des3des_fck =3D {
>          .name           =3D "des3des_fck",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1344,6 +1354,46 @@ static struct clk dsp_fck =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk dss_sys_clk =3D {
> +       .name           =3D "dss_sys_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_DSS_DSS_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_dss_clkdm",
> +       .parent         =3D&syc_clk_div_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk dss_tv_clk =3D {
> +       .name           =3D "dss_tv_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_DSS_DSS_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_TV_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_dss_clkdm",
> +       .parent         =3D&extalt_clkin_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk dss_dss_clk =3D {
> +       .name           =3D "dss_dss_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_DSS_DSS_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
> +       .clkdm_name     =3D "l3_dss_clkdm",
> +       .parent         =3D&dpll_per_m5_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk dss_48mhz_clk =3D {
> +       .name           =3D "dss_48mhz_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_DSS_DSS_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_dss_clkdm",
> +       .parent         =3D&func_48mc_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk dss_fck =3D {
>          .name           =3D "dss_fck",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1417,6 +1467,16 @@ static struct clk fpka_fck =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk gpio1_dbclk =3D {
> +       .name           =3D "gpio1_dbclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
> +       .clkdm_name     =3D "l4_wkup_clkdm",
> +       .parent         =3D&sys_32k_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk gpio1_ick =3D {
>          .name           =3D "gpio1_ick",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1427,6 +1487,16 @@ static struct clk gpio1_ick =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk gpio2_dbclk =3D {
> +       .name           =3D "gpio2_dbclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
> +       .clkdm_name     =3D "l4_per_clkdm",
> +       .parent         =3D&sys_32k_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk gpio2_ick =3D {
>          .name           =3D "gpio2_ick",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1437,6 +1507,16 @@ static struct clk gpio2_ick =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk gpio3_dbclk =3D {
> +       .name           =3D "gpio3_dbclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
> +       .clkdm_name     =3D "l4_per_clkdm",
> +       .parent         =3D&sys_32k_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk gpio3_ick =3D {
>          .name           =3D "gpio3_ick",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1447,6 +1527,16 @@ static struct clk gpio3_ick =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk gpio4_dbclk =3D {
> +       .name           =3D "gpio4_dbclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
> +       .clkdm_name     =3D "l4_per_clkdm",
> +       .parent         =3D&sys_32k_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk gpio4_ick =3D {
>          .name           =3D "gpio4_ick",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1457,6 +1547,16 @@ static struct clk gpio4_ick =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk gpio5_dbclk =3D {
> +       .name           =3D "gpio5_dbclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
> +       .clkdm_name     =3D "l4_per_clkdm",
> +       .parent         =3D&sys_32k_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk gpio5_ick =3D {
>          .name           =3D "gpio5_ick",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1467,6 +1567,16 @@ static struct clk gpio5_ick =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk gpio6_dbclk =3D {
> +       .name           =3D "gpio6_dbclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_DBCLK_SHIFT,
> +       .clkdm_name     =3D "l4_per_clkdm",
> +       .parent         =3D&sys_32k_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk gpio6_ick =3D {
>          .name           =3D "gpio6_ick",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1589,6 +1699,16 @@ static struct clk ipu_fck =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk iss_ctrlclk =3D {
> +       .name           =3D "iss_ctrlclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_CAM_ISS_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
> +       .clkdm_name     =3D "iss_clkdm",
> +       .parent         =3D&func_96m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk iss_fck =3D {
>          .name           =3D "iss_fck",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1913,6 +2033,26 @@ static struct clk mmc5_fck =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk ocp2scp_usb_phy_clk32k =3D {
> +       .name           =3D "ocp2scp_usb_phy_clk32k",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_CLK32K_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&sys_32k_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk ocp2scp_usb_phy_phy_48m =3D {
> +       .name           =3D "ocp2scp_usb_phy_phy_48m",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_PHY_48M_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&func_48m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk ocp_wp_noc_ick =3D {
>          .name           =3D "ocp_wp_noc_ick",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1953,6 +2093,46 @@ static struct clk sl2if_ick =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk slimbus1_fclk_1 =3D {
> +       .name           =3D "slimbus1_fclk_1",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_FCLK1_SHIFT,
> +       .clkdm_name     =3D "abe_clkdm",
> +       .parent         =3D&func_24m_clk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk slimbus1_fclk_0 =3D {
> +       .name           =3D "slimbus1_fclk_0",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_FCLK0_SHIFT,
> +       .clkdm_name     =3D "abe_clkdm",
> +       .parent         =3D&abe_24m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk slimbus1_fclk_2 =3D {
> +       .name           =3D "slimbus1_fclk_2",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_FCLK2_SHIFT,
> +       .clkdm_name     =3D "abe_clkdm",
> +       .parent         =3D&pad_clks_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk slimbus1_slimbus_clk =3D {
> +       .name           =3D "slimbus1_slimbus_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_SLIMBUS_CLK_11_11_SHIF=
T,
> +       .clkdm_name     =3D "abe_clkdm",
> +       .parent         =3D&slimbus_clk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk slimbus1_fck =3D {
>          .name           =3D "slimbus1_fck",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -1963,6 +2143,36 @@ static struct clk slimbus1_fck =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk slimbus2_fclk_1 =3D {
> +       .name           =3D "slimbus2_fclk_1",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_PERABE24M_GFCLK_SHIFT,
> +       .clkdm_name     =3D "l4_per_clkdm",
> +       .parent         =3D&per_abe_24m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk slimbus2_fclk_0 =3D {
> +       .name           =3D "slimbus2_fclk_0",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_PER24MC_GFCLK_SHIFT,
> +       .clkdm_name     =3D "l4_per_clkdm",
> +       .parent         =3D&func_24mc_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk slimbus2_slimbus_clk =3D {
> +       .name           =3D "slimbus2_slimbus_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_SLIMBUS_CLK_SHIFT,
> +       .clkdm_name     =3D "l4_per_clkdm",
> +       .parent         =3D&pad_slimbus_core_clks_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk slimbus2_fck =3D {
>          .name           =3D "slimbus2_fck",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -2224,6 +2434,120 @@ static struct clk usb_host_fs_fck =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk usb_host_hs_utmi_p3_clk =3D {
> +       .name           =3D "usb_host_hs_utmi_p3_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_UTMI_P3_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&init_60m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk usb_host_hs_hsic60m_p1_clk =3D {
> +       .name           =3D "usb_host_hs_hsic60m_p1_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_HSIC60M_P1_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&init_60m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk usb_host_hs_hsic60m_p2_clk =3D {
> +       .name           =3D "usb_host_hs_hsic60m_p2_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_HSIC60M_P2_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&init_60m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static const struct clksel utmi_p1_gfclk_sel[] =3D {
> +       { .parent =3D&init_60m_fclk, .rates =3D div_1_0_rates },
> +       { .parent =3D&xclk60mhsp1_ck, .rates =3D div_1_1_rates },
> +       { .parent =3D NULL },
> +};
> +
> +static struct clk utmi_p1_gfclk =3D {
> +       .name           =3D "utmi_p1_gfclk",
> +       .parent         =3D&init_60m_fclk,
> +       .clksel         =3D utmi_p1_gfclk_sel,
> +       .init           =3D&omap2_init_clksel_parent,
> +       .clksel_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .clksel_mask    =3D OMAP4430_CLKSEL_UTMI_P1_MASK,
> +       .ops            =3D&clkops_null,
> +       .recalc         =3D&omap2_clksel_recalc,
> +};
> +
> +static struct clk usb_host_hs_utmi_p1_clk =3D {
> +       .name           =3D "usb_host_hs_utmi_p1_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_UTMI_P1_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&utmi_p1_gfclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static const struct clksel utmi_p2_gfclk_sel[] =3D {
> +       { .parent =3D&init_60m_fclk, .rates =3D div_1_0_rates },
> +       { .parent =3D&xclk60mhsp2_ck, .rates =3D div_1_1_rates },
> +       { .parent =3D NULL },
> +};
> +
> +static struct clk utmi_p2_gfclk =3D {
> +       .name           =3D "utmi_p2_gfclk",
> +       .parent         =3D&init_60m_fclk,
> +       .clksel         =3D utmi_p2_gfclk_sel,
> +       .init           =3D&omap2_init_clksel_parent,
> +       .clksel_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .clksel_mask    =3D OMAP4430_CLKSEL_UTMI_P2_MASK,
> +       .ops            =3D&clkops_null,
> +       .recalc         =3D&omap2_clksel_recalc,
> +};
> +
> +static struct clk usb_host_hs_utmi_p2_clk =3D {
> +       .name           =3D "usb_host_hs_utmi_p2_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_UTMI_P2_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&utmi_p2_gfclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk usb_host_hs_hsic480m_p1_clk =3D {
> +       .name           =3D "usb_host_hs_hsic480m_p1_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_HSIC480M_P1_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&dpll_usb_m2_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk usb_host_hs_hsic480m_p2_clk =3D {
> +       .name           =3D "usb_host_hs_hsic480m_p2_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_HSIC480M_P2_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&dpll_usb_m2_ck,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk usb_host_hs_func48mclk =3D {
> +       .name           =3D "usb_host_hs_func48mclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_FUNC48MCLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&func_48mc_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk usb_host_hs_fck =3D {
>          .name           =3D "usb_host_hs_fck",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -2234,6 +2558,33 @@ static struct clk usb_host_hs_fck =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static const struct clksel otg_60m_gfclk_sel[] =3D {
> +       { .parent =3D&utmi_phy_clkout_ck, .rates =3D div_1_0_rates },
> +       { .parent =3D&xclk60motg_ck, .rates =3D div_1_1_rates },
> +       { .parent =3D NULL },
> +};
> +
> +static struct clk otg_60m_gfclk =3D {
> +       .name           =3D "otg_60m_gfclk",
> +       .parent         =3D&utmi_phy_clkout_ck,
> +       .clksel         =3D otg_60m_gfclk_sel,
> +       .init           =3D&omap2_init_clksel_parent,
> +       .clksel_reg     =3D OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
> +       .clksel_mask    =3D OMAP4430_CLKSEL_60M_MASK,
> +       .ops            =3D&clkops_null,
> +       .recalc         =3D&omap2_clksel_recalc,
> +};
> +
> +static struct clk usb_otg_hs_xclk =3D {
> +       .name           =3D "usb_otg_hs_xclk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_XCLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&otg_60m_gfclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk usb_otg_hs_ick =3D {
>          .name           =3D "usb_otg_hs_ick",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -2244,6 +2595,36 @@ static struct clk usb_otg_hs_ick =3D {
>          .recalc         =3D&followparent_recalc,
>   };
>
> +static struct clk usb_tll_hs_usb_ch2_clk =3D {
> +       .name           =3D "usb_tll_hs_usb_ch2_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_USB_CH2_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&init_60m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk usb_tll_hs_usb_ch0_clk =3D {
> +       .name           =3D "usb_tll_hs_usb_ch0_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_USB_CH0_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&init_60m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
> +static struct clk usb_tll_hs_usb_ch1_clk =3D {
> +       .name           =3D "usb_tll_hs_usb_ch1_clk",
> +       .ops            =3D&clkops_omap2_dflt,
> +       .enable_reg     =3D OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
> +       .enable_bit     =3D OMAP4430_OPTFCLKEN_USB_CH1_CLK_SHIFT,
> +       .clkdm_name     =3D "l3_init_clkdm",
> +       .parent         =3D&init_60m_fclk,
> +       .recalc         =3D&followparent_recalc,
> +};
> +
>   static struct clk usb_tll_hs_ick =3D {
>          .name           =3D "usb_tll_hs_ick",
>          .ops            =3D&clkops_omap2_dflt,
> @@ -2285,23 +2666,6 @@ static struct clk wd_timer3_fck =3D {
>   };
>
>   /* Remaining optional clocks */
> -static const struct clksel otg_60m_gfclk_sel[] =3D {
> -       { .parent =3D&utmi_phy_clkout_ck, .rates =3D div_1_0_rates },
> -       { .parent =3D&xclk60motg_ck, .rates =3D div_1_1_rates },
> -       { .parent =3D NULL },
> -};
> -
> -static struct clk otg_60m_gfclk_ck =3D {
> -       .name           =3D "otg_60m_gfclk_ck",
> -       .parent         =3D&utmi_phy_clkout_ck,
> -       .clksel         =3D otg_60m_gfclk_sel,
> -       .init           =3D&omap2_init_clksel_parent,
> -       .clksel_reg     =3D OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
> -       .clksel_mask    =3D OMAP4430_CLKSEL_60M_MASK,
> -       .ops            =3D&clkops_null,
> -       .recalc         =3D&omap2_clksel_recalc,
> -};
> -
>   static const struct clksel stm_clk_div_div[] =3D {
>          { .parent =3D&pmd_stm_clock_mux_ck, .rates =3D div3_1to4_rat=
es },
>          { .parent =3D NULL },
> @@ -2359,40 +2723,6 @@ static struct clk usim_fclk =3D {
>          .set_rate       =3D&omap2_clksel_set_rate,
>   };
>
> -static const struct clksel utmi_p1_gfclk_sel[] =3D {
> -       { .parent =3D&init_60m_fclk, .rates =3D div_1_0_rates },
> -       { .parent =3D&xclk60mhsp1_ck, .rates =3D div_1_1_rates },
> -       { .parent =3D NULL },
> -};
> -
> -static struct clk utmi_p1_gfclk_ck =3D {
> -       .name           =3D "utmi_p1_gfclk_ck",
> -       .parent         =3D&init_60m_fclk,
> -       .clksel         =3D utmi_p1_gfclk_sel,
> -       .init           =3D&omap2_init_clksel_parent,
> -       .clksel_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> -       .clksel_mask    =3D OMAP4430_CLKSEL_UTMI_P1_MASK,
> -       .ops            =3D&clkops_null,
> -       .recalc         =3D&omap2_clksel_recalc,
> -};
> -
> -static const struct clksel utmi_p2_gfclk_sel[] =3D {
> -       { .parent =3D&init_60m_fclk, .rates =3D div_1_0_rates },
> -       { .parent =3D&xclk60mhsp2_ck, .rates =3D div_1_1_rates },
> -       { .parent =3D NULL },
> -};
> -
> -static struct clk utmi_p2_gfclk_ck =3D {
> -       .name           =3D "utmi_p2_gfclk_ck",
> -       .parent         =3D&init_60m_fclk,
> -       .clksel         =3D utmi_p2_gfclk_sel,
> -       .init           =3D&omap2_init_clksel_parent,
> -       .clksel_reg     =3D OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
> -       .clksel_mask    =3D OMAP4430_CLKSEL_UTMI_P2_MASK,
> -       .ops            =3D&clkops_null,
> -       .recalc         =3D&omap2_clksel_recalc,
> -};
> -
>   /*
>    * clkdev
>    */
> @@ -2487,21 +2817,32 @@ static struct omap_clk omap44xx_clks[] =3D {
>          CLK(NULL,       "aes1_fck",&aes1_fck,      CK_443X),
>          CLK(NULL,       "aes2_fck",&aes2_fck,      CK_443X),
>          CLK(NULL,       "aess_fck",&aess_fck,      CK_443X),
> +       CLK(NULL,       "bandgap_fclk",&bandgap_fclk,  CK_443X),
>          CLK(NULL,       "des3des_fck",&des3des_fck,   CK_443X),
>          CLK(NULL,       "dmic_sync_mux_ck",&dmic_sync_mux_ck,      C=
K_443X),
>          CLK(NULL,       "dmic_fck",&dmic_fck,      CK_443X),
>          CLK(NULL,       "dsp_fck",&dsp_fck,       CK_443X),
> +       CLK(NULL,       "dss_sys_clk",&dss_sys_clk,   CK_443X),
> +       CLK(NULL,       "dss_tv_clk",&dss_tv_clk,    CK_443X),
> +       CLK(NULL,       "dss_dss_clk",&dss_dss_clk,   CK_443X),
> +       CLK(NULL,       "dss_48mhz_clk",&dss_48mhz_clk, CK_443X),
>          CLK(NULL,       "dss_fck",&dss_fck,       CK_443X),
>          CLK(NULL,       "efuse_ctrl_cust_fck",&efuse_ctrl_cust_fck, =
  CK_443X),
>          CLK(NULL,       "emif1_fck",&emif1_fck,     CK_443X),
>          CLK(NULL,       "emif2_fck",&emif2_fck,     CK_443X),
>          CLK(NULL,       "fdif_fck",&fdif_fck,      CK_443X),
>          CLK(NULL,       "fpka_fck",&fpka_fck,      CK_443X),
> +       CLK(NULL,       "gpio1_dbclk",&gpio1_dbclk,   CK_443X),
>          CLK(NULL,       "gpio1_ick",&gpio1_ick,     CK_443X),
> +       CLK(NULL,       "gpio2_dbclk",&gpio2_dbclk,   CK_443X),
>          CLK(NULL,       "gpio2_ick",&gpio2_ick,     CK_443X),
> +       CLK(NULL,       "gpio3_dbclk",&gpio3_dbclk,   CK_443X),
>          CLK(NULL,       "gpio3_ick",&gpio3_ick,     CK_443X),
> +       CLK(NULL,       "gpio4_dbclk",&gpio4_dbclk,   CK_443X),
>          CLK(NULL,       "gpio4_ick",&gpio4_ick,     CK_443X),
> +       CLK(NULL,       "gpio5_dbclk",&gpio5_dbclk,   CK_443X),
>          CLK(NULL,       "gpio5_ick",&gpio5_ick,     CK_443X),
> +       CLK(NULL,       "gpio6_dbclk",&gpio6_dbclk,   CK_443X),
>          CLK(NULL,       "gpio6_ick",&gpio6_ick,     CK_443X),
>          CLK(NULL,       "gpmc_ick",&gpmc_ick,      CK_443X),
>          CLK(NULL,       "gpu_fck",&gpu_fck,       CK_443X),
> @@ -2512,6 +2853,7 @@ static struct omap_clk omap44xx_clks[] =3D {
>          CLK("i2c_omap.3",       "fck",&i2c3_fck,      CK_443X),
>          CLK("i2c_omap.4",       "fck",&i2c4_fck,      CK_443X),
>          CLK(NULL,       "ipu_fck",&ipu_fck,       CK_443X),
> +       CLK(NULL,       "iss_ctrlclk",&iss_ctrlclk,   CK_443X),
>          CLK(NULL,       "iss_fck",&iss_fck,       CK_443X),
>          CLK(NULL,       "iva_fck",&iva_fck,       CK_443X),
>          CLK(NULL,       "kbd_fck",&kbd_fck,       CK_443X),
> @@ -2537,11 +2879,20 @@ static struct omap_clk omap44xx_clks[] =3D {
>          CLK("mmci-omap-hs.2",   "fck",&mmc3_fck,      CK_443X),
>          CLK("mmci-omap-hs.3",   "fck",&mmc4_fck,      CK_443X),
>          CLK("mmci-omap-hs.4",   "fck",&mmc5_fck,      CK_443X),
> +       CLK(NULL,       "ocp2scp_usb_phy_clk32k",&ocp2scp_usb_phy_clk=
32k,        CK_443X),
> +       CLK(NULL,       "ocp2scp_usb_phy_phy_48m",&ocp2scp_usb_phy_ph=
y_48m,       CK_443X),
>          CLK(NULL,       "ocp_wp_noc_ick",&ocp_wp_noc_ick,        CK_=
443X),
>          CLK("omap_rng", "ick",&rng_ick,       CK_443X),
>          CLK(NULL,       "sha2md5_fck",&sha2md5_fck,   CK_443X),
>          CLK(NULL,       "sl2if_ick",&sl2if_ick,     CK_443X),
> +       CLK(NULL,       "slimbus1_fclk_1",&slimbus1_fclk_1,       CK_=
443X),
> +       CLK(NULL,       "slimbus1_fclk_0",&slimbus1_fclk_0,       CK_=
443X),
> +       CLK(NULL,       "slimbus1_fclk_2",&slimbus1_fclk_2,       CK_=
443X),
> +       CLK(NULL,       "slimbus1_slimbus_clk",&slimbus1_slimbus_clk,=
  CK_443X),
>          CLK(NULL,       "slimbus1_fck",&slimbus1_fck,  CK_443X),
> +       CLK(NULL,       "slimbus2_fclk_1",&slimbus2_fclk_1,       CK_=
443X),
> +       CLK(NULL,       "slimbus2_fclk_0",&slimbus2_fclk_0,       CK_=
443X),
> +       CLK(NULL,       "slimbus2_slimbus_clk",&slimbus2_slimbus_clk,=
  CK_443X),
>          CLK(NULL,       "slimbus2_fck",&slimbus2_fck,  CK_443X),
>          CLK(NULL,       "smartreflex_core_fck",&smartreflex_core_fck=
,  CK_443X),
>          CLK(NULL,       "smartreflex_iva_fck",&smartreflex_iva_fck, =
  CK_443X),
> @@ -2562,24 +2913,30 @@ static struct omap_clk omap44xx_clks[] =3D {
>          CLK(NULL,       "uart3_fck",&uart3_fck,     CK_443X),
>          CLK(NULL,       "uart4_fck",&uart4_fck,     CK_443X),
>          CLK(NULL,       "usb_host_fs_fck",&usb_host_fs_fck,       CK=
_443X),
> +       CLK(NULL,       "usb_host_hs_utmi_p3_clk",&usb_host_hs_utmi_p=
3_clk,       CK_443X),
> +       CLK(NULL,       "usb_host_hs_hsic60m_p1_clk",&usb_host_hs_hsi=
c60m_p1_clk,    CK_443X),
> +       CLK(NULL,       "usb_host_hs_hsic60m_p2_clk",&usb_host_hs_hsi=
c60m_p2_clk,    CK_443X),
> +       CLK(NULL,       "utmi_p1_gfclk",&utmi_p1_gfclk, CK_443X),
> +       CLK(NULL,       "usb_host_hs_utmi_p1_clk",&usb_host_hs_utmi_p=
1_clk,       CK_443X),
> +       CLK(NULL,       "utmi_p2_gfclk",&utmi_p2_gfclk, CK_443X),
> +       CLK(NULL,       "usb_host_hs_utmi_p2_clk",&usb_host_hs_utmi_p=
2_clk,       CK_443X),
> +       CLK(NULL,       "usb_host_hs_hsic480m_p1_clk",&usb_host_hs_hs=
ic480m_p1_clk,   CK_443X),
> +       CLK(NULL,       "usb_host_hs_hsic480m_p2_clk",&usb_host_hs_hs=
ic480m_p2_clk,   CK_443X),
> +       CLK(NULL,       "usb_host_hs_func48mclk",&usb_host_hs_func48m=
clk,        CK_443X),
>          CLK(NULL,       "usb_host_hs_fck",&usb_host_hs_fck,       CK=
_443X),
> +       CLK(NULL,       "otg_60m_gfclk",&otg_60m_gfclk, CK_443X),
> +       CLK(NULL,       "usb_otg_hs_xclk",&usb_otg_hs_xclk,       CK_=
443X),
>          CLK("musb_hdrc",        "ick",&usb_otg_hs_ick,        CK_443=
X),
> +       CLK(NULL,       "usb_tll_hs_usb_ch2_clk",&usb_tll_hs_usb_ch2_=
clk,        CK_443X),
> +       CLK(NULL,       "usb_tll_hs_usb_ch0_clk",&usb_tll_hs_usb_ch0_=
clk,        CK_443X),
> +       CLK(NULL,       "usb_tll_hs_usb_ch1_clk",&usb_tll_hs_usb_ch1_=
clk,        CK_443X),
>          CLK(NULL,       "usb_tll_hs_ick",&usb_tll_hs_ick,        CK_=
443X),
>          CLK(NULL,       "usim_fck",&usim_fck,      CK_443X),
>          CLK("omap_wdt", "fck",&wd_timer2_fck, CK_443X),
>          CLK(NULL,       "wd_timer3_fck",&wd_timer3_fck, CK_443X),
> -       CLK(NULL,       "otg_60m_gfclk_ck",&otg_60m_gfclk_ck,      CK=
_443X),
>          CLK(NULL,       "stm_clk_div_ck",&stm_clk_div_ck,        CK_=
443X),
>          CLK(NULL,       "trace_clk_div_ck",&trace_clk_div_ck,      C=
K_443X),
>          CLK(NULL,       "usim_fclk",&usim_fclk,     CK_443X),
> -       CLK(NULL,       "utmi_p1_gfclk_ck",&utmi_p1_gfclk_ck,      CK=
_443X),
> -       CLK(NULL,       "utmi_p2_gfclk_ck",&utmi_p2_gfclk_ck,      CK=
_443X),
> -       CLK(NULL,       "gpio1_dbck",&dummy_ck,      CK_443X),
> -       CLK(NULL,       "gpio2_dbck",&dummy_ck,      CK_443X),
> -       CLK(NULL,       "gpio3_dbck",&dummy_ck,      CK_443X),
> -       CLK(NULL,       "gpio4_dbck",&dummy_ck,      CK_443X),
> -       CLK(NULL,       "gpio5_dbck",&dummy_ck,      CK_443X),
> -       CLK(NULL,       "gpio6_dbck",&dummy_ck,      CK_443X),
>          CLK(NULL,       "gpmc_ck",&dummy_ck,      CK_443X),
>          CLK(NULL,       "gpt1_ick",&dummy_ck,      CK_443X),
>          CLK(NULL,       "gpt2_ick",&dummy_ck,      CK_443X),
> --
> 1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
