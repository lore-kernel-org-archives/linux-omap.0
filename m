From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH v3 net-next 06/11] dt-bindings: net: ti: add new cpsw
 switch driver bindings
Date: Fri, 26 Apr 2019 00:40:21 +0200
Message-ID: <20190425224021.GA4041@lunn.ch>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-7-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556144667-27997-7-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>
List-Id: linux-omap@vger.kernel.org

> +Required Sub-nodes:
> +- ports	: contains CPSW external ports descriptions
> +	Required properties:
> +	- #address-cells : Must be 1
> +	- #size-cells : Must be 0
> +	- reg : CPSW port number. Should be 1 or 2
> +	- phys : phandle on phy-gmii-sel PHY (see phy/ti-phy-gmii-sel.txt)
> +	- phy-mode : operation mode of the PHY interface [1]
> +	- phy-handle : phandle to a PHY on an MDIO bus [1]


> +		cpsw_port1: port@1 {
> +			reg = <1>;
> +			ti,label = "port1";
> +			/* Filled in by U-Boot */
> +			mac-address = [ 00 00 00 00 00 00 ];
> +			phys = <&phy_gmii_sel 1>;

Hi Grygorii

phy-mode and phy-handle are required, but missing from your example.

Otherwise, this looks like a reasonable binding.

	   Andrew
