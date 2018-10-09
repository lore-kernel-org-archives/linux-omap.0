From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 02/11] dt-bindings: phy: add cpsw port interface mode
 selection phy bindings
Date: Tue, 9 Oct 2018 15:10:34 -0500
Message-ID: <3fa09831-0f70-dfcc-3fd9-f877215a4631@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-3-grygorii.strashko@ti.com>
 <20181009144000.GL5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009144000.GL5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/09/2018 09:40 AM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [181008 23:54]:
>> +Examples:
>> +	phy_gmii_sel: phy-gmii-sel {
>> +		compatible = "ti,am3352-phy-gmii-sel";
>> +		syscon-scm = <&scm_conf>;
>> +		#phy-cells = <2>;
>> +	};
> 
> Now that this driver can live in it's proper place in the

right

> dts, you may want to consider just using standard reg
> property for it instead of the syscon-scm. And also get
> rid of the syscon reads and writes.

Could you help clarify how to get syscon in this case?
syscon_node_to_regmap(dev->parent->of_node)?

Also, there are could be more then one gmii_sel registers in SCM in the future,
so I hidden offsets in of_match data. 
As result, "reg" not needed at all now.

-- 
regards,
-grygorii
