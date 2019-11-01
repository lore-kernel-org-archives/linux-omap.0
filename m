From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v5 net-next 05/12] dt-bindings: net: ti: add new cpsw
 switch driver bindings
Date: Fri, 1 Nov 2019 19:29:22 +0200
Message-ID: <0f79794b-ca33-fc00-645a-9cd37aa6fdd4@ti.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024100914.16840-6-grygorii.strashko@ti.com>
 <20191029022305.GK15259@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191029022305.GK15259@lunn.ch>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

hi Andrew,

On 29/10/2019 04:23, Andrew Lunn wrote:
>> +TI SoC Ethernet Switch Controller Device Tree Bindings (new)
>> +------------------------------------------------------
>> +
>> +The 3-port switch gigabit ethernet subsystem provides ethernet packet
>> +communication and can be configured as an ethernet switch.
> 
> Hi Grygorii
> 
> Maybe referring it to a 3-port switch will cause confusion, since in
> this use case, it only has 2 ports, and you only list two ports in the
> device tree.

Yeah. This is how it's defined in TRM - Port 0 (CPU port) is the same as external Port from
CPSW switch core point of view.

> 
>> It provides the
>> +gigabit media independent interface (GMII),reduced gigabit media
>> +independent interface (RGMII), reduced media independent interface (RMII),

[...]

>> +
>> +&mac_sw {
>> +	pinctrl-names = "default", "sleep";
>> +	status = "okay";
>> +};
>> +
>> +&cpsw_port1 {
>> +	phy-handle = <&ethphy0_sw>;
>> +	phy-mode = "rgmii";
>> +	ti,dual_emac_pvid = <1>;
>> +};
>> +
>> +&cpsw_port2 {
>> +	phy-handle = <&ethphy1_sw>;
>> +	phy-mode = "rgmii";
>> +	ti,dual_emac_pvid = <2>;
>> +};
>> +
>> +&davinci_mdio_sw {
>> +	ethphy0_sw: ethernet-phy@0 {
>> +		reg = <0>;
>> +	};
>> +
>> +	ethphy1_sw: ethernet-phy@1 {
>> +		reg = <1>;
>> +	};
>> +};
> 
> In an example, it is unusual to split things up like this. I
> understand that parts of this will be in the dtsi file, and parts in
> the .dts file, but examples generally keep it all as one. And when you
> re-write this in YAML so it can be used to validated real DTs, you
> will have to combine it.

Thank you. I'll update.

-- 
Best regards,
grygorii
