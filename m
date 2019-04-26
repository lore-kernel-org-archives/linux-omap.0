From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH v3 net-next 06/11] dt-bindings: net: ti: add new cpsw
 switch driver bindings
Date: Fri, 26 Apr 2019 10:50:25 +0300
Message-ID: <4dc2a645-4769-e873-d5d3-b6ef74367ca3@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-7-git-send-email-grygorii.strashko@ti.com>
 <20190425224021.GA4041@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190425224021.GA4041@lunn.ch>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>
List-Id: linux-omap@vger.kernel.org



On 26.04.19 01:40, Andrew Lunn wrote:
>> +Required Sub-nodes:
>> +- ports	: contains CPSW external ports descriptions
>> +	Required properties:
>> +	- #address-cells : Must be 1
>> +	- #size-cells : Must be 0
>> +	- reg : CPSW port number. Should be 1 or 2
>> +	- phys : phandle on phy-gmii-sel PHY (see phy/ti-phy-gmii-sel.txt)
>> +	- phy-mode : operation mode of the PHY interface [1]
>> +	- phy-handle : phandle to a PHY on an MDIO bus [1]
> 
> 
>> +		cpsw_port1: port@1 {
>> +			reg = <1>;
>> +			ti,label = "port1";
>> +			/* Filled in by U-Boot */
>> +			mac-address = [ 00 00 00 00 00 00 ];
>> +			phys = <&phy_gmii_sel 1>;
> 
> Hi Grygorii
> 
> phy-mode and phy-handle are required, but missing from your example.
> 
> Otherwise, this looks like a reasonable binding.

Yea. they configured in board files - will add.

Thanks. 

-- 
Best regards,
grygorii
