From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Re: [PATCH] OMAP3: Update USBHOST pinmux settings
Date: Fri, 26 Sep 2008 11:40:57 -0400
Message-ID: <1f11a5490809260840w2b04d06ds69e993c4ffd10b2e@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC958E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:57032 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYIZPk6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 11:40:58 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1160159wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2008 08:40:57 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC958E@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 26, 2008 at 11:34 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> From: Anand Gadiyar <gadiyar@ti.com>
>
> Add pin-mux settings for OHCI in PHY mode.
> Also change settings for EHCI in TLL mode.
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>  arch/arm/mach-omap2/mux.c             |   67 +++++++++++++++++++++++++++-------
>  arch/arm/plat-omap/include/mach/mux.h |   26 ++++++++++++-
>  2 files changed, 80 insertions(+), 13 deletions(-)
>
> Index: tony/arch/arm/mach-omap2/mux.c
> ===================================================================
> --- tony.orig/arch/arm/mach-omap2/mux.c 2008-09-04 12:57:33.000000000 +0530
> +++ tony/arch/arm/mach-omap2/mux.c      2008-09-26 20:49:24.963867406 +0530
> @@ -298,13 +298,13 @@ MUX_CFG_34XX("T2_3430_USB2HS_PHY_D7", 0x
>
>  /* TLL - HSUSB: 12-pin TLL Port 1*/
>  MUX_CFG_34XX("Y8_3430_USB1HS_TLL_CLK", 0x5da,
> -               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
> -MUX_CFG_34XX("Y9_3430_USB1HS_TLL_STP", 0x5d8,
>                OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("Y9_3430_USB1HS_TLL_STP", 0x5d8,
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLUP)
>  MUX_CFG_34XX("AA14_3430_USB1HS_TLL_DIR", 0x5ec,
> -               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("AA11_3430_USB1HS_TLL_NXT", 0x5ee,
> -               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("W13_3430_USB1HS_TLL_D0", 0x5dc,
>                OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("W12_3430_USB1HS_TLL_D1", 0x5de,
> @@ -324,13 +324,13 @@ MUX_CFG_34XX("Y13_3430_USB1HS_TLL_D7", 0
>
>  /* TLL - HSUSB: 12-pin TLL Port 2*/
>  MUX_CFG_34XX("AA8_3430_USB2HS_TLL_CLK", 0x5f0,
> -               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
> -MUX_CFG_34XX("AA10_3430_USB2HS_TLL_STP", 0x5f2,
>                OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AA10_3430_USB2HS_TLL_STP", 0x5f2,
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLUP)
>  MUX_CFG_34XX("AA9_3430_USB2HS_TLL_DIR", 0x5f4,
> -               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("AB11_3430_USB2HS_TLL_NXT", 0x5f6,
> -               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("AB10_3430_USB2HS_TLL_D0", 0x5f8,
>                OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("AB9_3430_USB2HS_TLL_D1", 0x5fa,
> @@ -350,13 +350,13 @@ MUX_CFG_34XX("T2_3430_USB2HS_TLL_D7", 0x
>
>  /* TLL - HSUSB: 12-pin TLL Port 3*/
>  MUX_CFG_34XX("AA6_3430_USB3HS_TLL_CLK", 0x180,
> -               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_OUTPUT)
> -MUX_CFG_34XX("AB3_3430_USB3HS_TLL_STP", 0x166,
>                OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AB3_3430_USB3HS_TLL_STP", 0x166,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLUP)
>  MUX_CFG_34XX("AA3_3430_USB3HS_TLL_DIR", 0x168,
> -               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_OUTPUT)
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("Y3_3430_USB3HS_TLL_NXT", 0x16a,
> -               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_OUTPUT)
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("AA5_3430_USB3HS_TLL_D0", 0x186,
>                OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("Y4_3430_USB3HS_TLL_D1", 0x184,
> @@ -373,6 +373,49 @@ MUX_CFG_34XX("AA13_3430_USB3HS_TLL_D6",
>                OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
>  MUX_CFG_34XX("AA12_3430_USB3HS_TLL_D7", 0x172,
>                OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +
> +/* PHY FSUSB: FS Serial PHY 4-pin mode for Port 1*/
> +MUX_CFG_34XX("AF10_3430_USB1FS_PHY_MM1_RXDP", 0x5d8,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AG9_3430_USB1FS_PHY_MM1_RXDM", 0x5ee,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("W13_3430_USB1FS_PHY_MM1_RXRCV", 0x5dc,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("W12_3430_USB1FS_PHY_MM1_TXSE0", 0x5de,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("W11_3430_USB1FS_PHY_MM1_TXDAT", 0x5e0,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("Y11_3430_USB1FS_PHY_MM1_TXEN_N", 0x5ea,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +
> +/* PHY FSUSB: FS Serial PHY 4-pin mode for Port 2*/
> +MUX_CFG_34XX("AF7_3430_USB2FS_PHY_MM2_RXDP", 0x5f2,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AH7_3430_USB2FS_PHY_MM2_RXDM", 0x5f6,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AB10_3430_USB2FS_PHY_MM2_RXRCV", 0x5f8,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AB9_3430_USB2FS_PHY_MM2_TXSE0", 0x5fa,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("W3_3430_USB2FS_PHY_MM2_TXDAT", 0x1d4,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("T4_3430_USB2FS_PHY_MM2_TXEN_N", 0x1de,
> +               OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_OUTPUT)
> +
> +/* PHY FSUSB: FS Serial PHY 4-pin mode for Port 3*/
> +MUX_CFG_34XX("AH3_3430_USB3FS_PHY_MM3_RXDP", 0x166,
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AE3_3430_USB3FS_PHY_MM3_RXDM", 0x16a,
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AD1_3430_USB3FS_PHY_MM3_RXRCV", 0x186,
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AE1_3430_USB3FS_PHY_MM3_TXSE0", 0x184,
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AD2_3430_USB3FS_PHY_MM3_TXDAT", 0x188,
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +MUX_CFG_34XX("AC1_3430_USB3FS_PHY_MM3_TXEN_N", 0x18a,
> +               OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
> +
>  };
>
>  #define OMAP34XX_PINS_SZ       ARRAY_SIZE(omap34xx_pins)
> Index: tony/arch/arm/plat-omap/include/mach/mux.h
> ===================================================================
> --- tony.orig/arch/arm/plat-omap/include/mach/mux.h     2008-09-04 12:57:33.000000000 +0530
> +++ tony/arch/arm/plat-omap/include/mach/mux.h  2008-09-26 20:50:39.160537766 +0530
> @@ -723,7 +723,31 @@ enum omap34xx_index {
>        AB12_3430_USB3HS_TLL_DATA4,
>        AB13_3430_USB3HS_TLL_DATA5,
>        AA13_3430_USB3HS_TLL_DATA6,
> -       AA12_3430_USB3HS_TLL_DATA7
> +       AA12_3430_USB3HS_TLL_DATA7,
> +
> +       /* PHY FSUSB: FS Serial PHY 4-pin mode for Port 1*/
> +       AF10_3430_USB1FS_PHY_MM1_RXDP,
> +       AG9_3430_USB1FS_PHY_MM1_RXDM,
> +       W13_3430_USB1FS_PHY_MM1_RXRCV,
> +       W12_3430_USB1FS_PHY_MM1_TXSE0,
> +       W11_3430_USB1FS_PHY_MM1_TXDAT,
> +       Y11_3430_USB1FS_PHY_MM1_TXEN_N,
> +
> +       /* PHY FSUSB: FS Serial PHY 4-pin mode for Port 2*/
> +       AF7_3430_USB2FS_PHY_MM2_RXDP,
> +       AH7_3430_USB2FS_PHY_MM2_RXDM,
> +       AB10_3430_USB2FS_PHY_MM2_RXRCV,
> +       AB9_3430_USB2FS_PHY_MM2_TXSE0,
> +       W3_3430_USB2FS_PHY_MM2_TXDAT,
> +       T4_3430_USB2FS_PHY_MM2_TXEN_N,
> +
> +       /* PHY FSUSB: FS Serial PHY 4-pin mode for Port 3*/
> +       AH3_3430_USB3FS_PHY_MM3_RXDP,
> +       AE3_3430_USB3FS_PHY_MM3_RXDM,
> +       AD1_3430_USB3FS_PHY_MM3_RXRCV,
> +       AE1_3430_USB3FS_PHY_MM3_TXSE0,
> +       AD2_3430_USB3FS_PHY_MM3_TXDAT,
> +       AC1_3430_USB3FS_PHY_MM3_TXEN_N,
>
>  };
>  --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Anand,

Can you configure the USBHOST to just use the OHCI controller with a
Phy and not use the EHCI controller at all?

Regards
~ Ashwin
