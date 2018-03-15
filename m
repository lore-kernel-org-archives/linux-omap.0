From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: add check for in-band mode
 setting with RGMII PHY interface
Date: Thu, 15 Mar 2018 15:31:02 +0100
Message-ID: <20180315143102.GA28577@lunn.ch>
References: <20180315064145.7022-1-sz.lin@moxa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180315064145.7022-1-sz.lin@moxa.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "SZ Lin (?????????)" <sz.lin@moxa.com>
Cc: Schuyler Patton <spatton@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> @@ -1014,7 +1014,13 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
>  		/* set speed_in input in case RMII mode is used in 100Mbps */
>  		if (phy->speed == 100)
>  			mac_control |= BIT(15);
> -		else if (phy->speed == 10)
> +
> +		/* in band mode only works in 10Mbps RGMII mode */
> +		else if ((phy->speed == 10) &&
> +			 ((phy->interface == PHY_INTERFACE_MODE_RGMII) ||
> +			 (phy->interface == PHY_INTERFACE_MODE_RGMII_ID) ||
> +			 (phy->interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
> +			 (phy->interface == PHY_INTERFACE_MODE_RGMII_TXID)))

Please use phy_interface_mode_is_rgmii()

	Andrew
