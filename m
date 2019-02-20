From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
Date: Wed, 20 Feb 2019 10:30:25 +0200
Message-ID: <2543f0cd-f3d7-b958-785a-b24e37587d7f@ti.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
 <20190218144430.GE15711@atomide.com>
 <a9eea4d0-88d4-e903-8a9f-7f1b8b276c21@ti.com>
 <20190218162613.GH15711@atomide.com>
 <c35030fb-9107-1919-5c18-1a39ace8c036@ti.com>
 <20190219165231.GK15711@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190219165231.GK15711@atomide.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, grygorii.strashko@ti.com, vkoul@kernel.org, netdev@vger.kernel.org, f.fainelli@gmail.com, marc.w.gonzalez@free.fr, niklas.cassel@linaro.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 19/02/2019 18.52, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [190219 08:02]:
>> On 18/02/2019 18.26, Tony Lindgren wrote:
>>> OK so sounds like these are OK to wait for v5.1 merge window
>>> then as the dts changes alone won't fix anything?
>>
>> I think it would be better to send these to 5.0 to avoid the regression
>> siting in linux-next.
>>
>> The patches are actually doing to the correct thing (we need rgmii-id,
>> not rmgii-txid for these boards).
>> It was just a matter of luck that it worked with rgmii-txid as the
>> driver was broken and did not disabled the rxid when it should have.
> 
> OK applying into omap-for-v5.0/fixes-v2. I'll send a pull
> request on Thursday most likely then, let's see if it makes
> it for v5.0.

Thank you!

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
