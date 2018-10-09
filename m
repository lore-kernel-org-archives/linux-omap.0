From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 05/11] net: ethernet: ti: cpsw: add support for port
 interface mode selection phy
Date: Tue, 9 Oct 2018 15:28:29 -0500
Message-ID: <fd5c9503-8eed-0f7f-e9db-1bc870a23a93@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-6-grygorii.strashko@ti.com>
 <20181009005048.GB23588@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009005048.GB23588@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

On 10/08/2018 07:50 PM, Andrew Lunn wrote:
>>   	/* Configure GMII_SEL register */
>> -	cpsw_phy_sel(cpsw->dev, slave->phy->interface, slave->slave_num);
>> +	if (!IS_ERR(slave->data->ifphy))
>> +		phy_set_netif_mode(slave->data->ifphy, slave->data->phy_if);
> 
> Is slave->data->phy_if also passed to phy_connect()? So you are going
> to end up with both the MAC and the PHY inserting RGMII delays, and it
> not working.

No. This logic not changed comparing to how it was.

  * "rgmii" (RX and TX delays are added by the MAC when required)

rgmii_id = 0 --> CPSW: 0 : Internal Delay, PHY - no delay

  * "rgmii-id" (RGMII with internal RX and TX delays provided by the PHY, the
     MAC should not add the RX or TX delays in this case)
  * "rgmii-rxid" (RGMII with internal RX delay provided by the PHY, the MAC
     should not add an RX delay in this case)
  * "rgmii-txid" (RGMII with internal TX delay provided by the PHY, the MAC
     should not add an TX delay in this case)

rgmii_id = 1 --> CPSW: 1 : No Internal Delay, PHY/board -  delay

> 
> You need to somehow decide if the MAC is going to do the delay, or the
> PHY. But not both.

Again, this series does not change logic - only interfaces and DT.

Thank you for review.

-- 
regards,
-grygorii
