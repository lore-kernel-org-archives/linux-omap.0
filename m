From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
Date: Mon, 18 Feb 2019 18:22:31 +0200
Message-ID: <a9eea4d0-88d4-e903-8a9f-7f1b8b276c21@ti.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
 <20190218144430.GE15711@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190218144430.GE15711@atomide.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, grygorii.strashko@ti.com, vkoul@kernel.org, netdev@vger.kernel.org, f.fainelli@gmail.com, marc.w.gonzalez@free.fr, niklas.cassel@linaro.org
List-Id: linux-omap@vger.kernel.org



On 18/02/2019 16.44, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [190218 14:36]:
>> Hi,
>>
>> cd28d1d6e52e: ("net: phy: at803x: Disable phy delay for RGMII mode") broke the
>> ethernet networking on evmsk (and most likely on the evm as well):
>> https://patchwork.ozlabs.org/patch/1028527/
>>
>> v1 patch to fix the situation:
>> https://patchwork.ozlabs.org/patch/1040617/
>>
>> It turned out that the at803x driver is actually broken and need to be fixed
>> along with the DT data.
>>
>> The following series is proposed to fix the driver:
>> https://patchwork.ozlabs.org/project/netdev/list/?series=92611
>>
>> but the PHT mode needs to be switched to rgmii-id from rgmii-txid:
>> The rx delay is enabled by default and the driver never disabled it so when
>> asking rgmii-txid it actually got rgmii-id.
>>
>> The patch can be backported to stable, I have tested that it is not causing
>> regression with the old, broken driver.
> 
> Can the dts changes be merged before the driver changes or
> does it cause the phy to stop working?

The phy is not working atm, but this change will not cause regression
even if it is merged first.

> 
> Regards,
> 
> Tony
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
