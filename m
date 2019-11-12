From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v5 net-next 00/12] net: ethernet: ti: introduce new cpsw
 switchdev based driver
Date: Tue, 12 Nov 2019 11:48:30 +0200
Message-ID: <3c24b4c0-7ef2-71d3-b537-90def7c15fec@ti.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024160549.GY5610@atomide.com>
 <dc621a9d-eb92-5df9-81d7-ad2b037ac3c7@ti.com>
 <20191111170826.GT5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191111170826.GT5610@atomide.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sekhar Nori <nsekhar@ti.com>, netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 11/11/2019 19:08, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [191109 15:16]:
>> Hi Tony,
>>
>> On 24/10/2019 19:05, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Grygorii Strashko <grygorii.strashko@ti.com> [191024 10:10]:
>>>> This the RFC v5 which introduces new CPSW switchdev based driver which is
>>>> operating in dual-emac mode by default, thus working as 2 individual
>>>> network interfaces. The Switch mode can be enabled by configuring devlink driver
>>>> parameter "switch_mode" to 1/true:
>>>> 	devlink dev param set platform/48484000.ethernet_switch \
>>>> 	name switch_mode value 1 cmode runtime
>>>
>>> Just wondering about the migration plan.. Is this a replacement
>>> driver or used in addition to the old driver?
>>>
>>
>> Sry, I've missed you mail.
>>
>> As it's pretty big change the idea is to keep both drivers at least for sometime.
>> Step 1: add new driver and enable it on one platform. Do announcement.
>> Step 2: switch all one-port and dual mac drivers to the new driver
>> Step 3: switch all other platform to cpsw switchdev and deprecate old driver.
> 
> OK sounds good to me. So for the dts changes, we keep the old binding
> and just add a new module there?

yes, in general.
As you can see Patch 11 I've rearranged cpsw nodes between boards so cpsw_new is enabled
only on one board. But, Am5/dr7 board are good candidates to enable cpsw_new in batch as
the have only dual_mac default cfg.

> 
> Or do you also have to disable some parts of the old dts?

it will be the case for am3/am5 most probably.

-- 
Best regards,
grygorii
