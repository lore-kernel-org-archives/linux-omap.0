From: grygorii <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH v4 net-next 06/11] net: ethernet: ti: introduce cpsw
 switchdev based driver part 1 - dual-emac
Date: Wed, 26 Jun 2019 17:47:20 +0300
Message-ID: <d6f1f1fb-21c3-ca5f-2585-8d1c3a4f571d@ti.com>
References: <20190621181314.20778-1-grygorii.strashko@ti.com>
 <20190621181314.20778-7-grygorii.strashko@ti.com>
 <20190626095839.GE6485@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190626095839.GE6485@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 26/06/2019 12:58, Ivan Khoronzhuk wrote:
> Hi Grygorii
> 
> Too much code, but I've tried pass thru.
> Probably expectation the devlink to be reviewed, but several
> common replies that should be reflected in non RFC v.
> 
> On Fri, Jun 21, 2019 at 09:13:09PM +0300, Grygorii Strashko wrote:
>> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> Part 1:
>> Introduce basic CPSW dual_mac driver (cpsw_new.c) which is operating in
>> dual-emac mode by default, thus working as 2 individual network interfaces.
>> Main differences from legacy CPSW driver are:
>>
>> - optimized promiscuous mode: The P0_UNI_FLOOD (both ports) is enabled in
>> addition to ALLMULTI (current port) instead of ALE_BYPASS. So, Ports in
>> promiscuous mode will keep possibility of mcast and vlan filtering, which
>> is provides significant benefits when ports are joined to the same bridge,
>> but without enabling "switch" mode, or to different bridges.
>> - learning disabled on ports as it make not too much sense for
>>   segregated ports - no forwarding in HW.
>> - enabled basic support for devlink.
>>
>>     devlink dev show
>>         platform/48484000.ethernet_switch
>>
>>     devlink dev param show
>>      platform/48484000.ethernet_switch:
>>     name ale_bypass type driver-specific
>>      values:
>>         cmode runtime value false
>>
>> - "ale_bypass" devlink driver parameter allows to enable
>> ALE_CONTROL(4).BYPASS mode for debug purposes.
>> - updated DT bindings.
>>
>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>

[...]

>> +
>> +    /* setup host port priority mapping */
>> +    writel_relaxed(CPDMA_TX_PRIORITY_MAP,
>> +               &cpsw->host_port_regs->cpdma_tx_pri_map);
>> +    writel_relaxed(0, &cpsw->host_port_regs->cpdma_rx_chan_map);
> 
> ----
>> +
>> +    /* disable priority elevation */
>> +    writel_relaxed(0, &cpsw->regs->ptype);
>> +
>> +    /* enable statistics collection only on all ports */
>> +    writel_relaxed(0x7, &cpsw->regs->stat_port_en);
>> +
>> +    /* Enable internal fifo flow control */
>> +    writel(0x7, &cpsw->regs->flow_control);
> ---
> 
> Would be nice to do the same in old driver.
> I mean moving it from ndo_open
> Also were thoughts about this.

I have no plans to perform any kind of optimization in old driver any more.

Agree with other comments.

[...]

Thank you.

-- 
Best regards,
grygorii
