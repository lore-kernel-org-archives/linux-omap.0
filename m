From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH 05/11] net: ethernet: ti: cpsw: add support for port
 interface mode selection phy
Date: Tue, 9 Oct 2018 02:50:48 +0200
Message-ID: <20181009005048.GB23588@lunn.ch>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-6-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008234949.15416-6-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>  	/* Configure GMII_SEL register */
> -	cpsw_phy_sel(cpsw->dev, slave->phy->interface, slave->slave_num);
> +	if (!IS_ERR(slave->data->ifphy))
> +		phy_set_netif_mode(slave->data->ifphy, slave->data->phy_if);

Is slave->data->phy_if also passed to phy_connect()? So you are going
to end up with both the MAC and the PHY inserting RGMII delays, and it
not working.

You need to somehow decide if the MAC is going to do the delay, or the
PHY. But not both.

	Andrew
