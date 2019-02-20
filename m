From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel
 driver
Date: Wed, 20 Feb 2019 08:18:09 -0800
Message-ID: <20190220161809.GR15711@atomide.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
 <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Grygorii Strashko <grygorii.strashko@ti.com> [190220 15:26]:
> Deprecate cpsw-phy-sel driver as it's been replaced with new
> TI phy-gmii-sel PHY driver.

I'm not going to pick up this one, seems that Dave can merge
this later on? That is unless Dave wants to ack this one.

Regards,

Tony

> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/Kconfig | 6 +++---
>  drivers/net/ethernet/ti/cpsw.h  | 6 ++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index bb126be1eb72..8b21b40a9fe5 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -49,10 +49,11 @@ config TI_DAVINCI_CPDMA
>  	  will be called davinci_cpdma.  This is recommended.
>  
>  config TI_CPSW_PHY_SEL
> -	bool
> +	bool "TI CPSW Phy mode Selection (DEPRECATED)"
> +	default n
>  	---help---
>  	  This driver supports configuring of the phy mode connected to
> -	  the CPSW.
> +	  the CPSW. DEPRECATED: use PHY_TI_GMII_SEL.
>  
>  config TI_CPSW_ALE
>  	tristate "TI CPSW ALE Support"
> @@ -64,7 +65,6 @@ config TI_CPSW
>  	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
>  	select TI_DAVINCI_CPDMA
>  	select TI_DAVINCI_MDIO
> -	select TI_CPSW_PHY_SEL
>  	select TI_CPSW_ALE
>  	select MFD_SYSCON
>  	select REGMAP
> diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
> index cf111db3dc27..907e05fc22e4 100644
> --- a/drivers/net/ethernet/ti/cpsw.h
> +++ b/drivers/net/ethernet/ti/cpsw.h
> @@ -21,7 +21,13 @@
>  			 ((mac)[2] << 16) | ((mac)[3] << 24))
>  #define mac_lo(mac)	(((mac)[4] << 0) | ((mac)[5] << 8))
>  
> +#if IS_ENABLED(CONFIG_TI_CPSW_PHY_SEL)
>  void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave);
> +#else
> +static inline
> +void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave)
> +{}
> +#endif
>  int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr);
>  
>  #endif /* __CPSW_H__ */
> -- 
> 2.17.1
> 
