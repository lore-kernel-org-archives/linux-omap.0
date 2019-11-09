From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v5 net-next 00/12] net: ethernet: ti: introduce new cpsw
 switchdev based driver
Date: Sat, 9 Nov 2019 17:15:37 +0200
Message-ID: <dc621a9d-eb92-5df9-81d7-ad2b037ac3c7@ti.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024160549.GY5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191024160549.GY5610@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 24/10/2019 19:05, Tony Lindgren wrote:
> Hi,
> 
> * Grygorii Strashko <grygorii.strashko@ti.com> [191024 10:10]:
>> This the RFC v5 which introduces new CPSW switchdev based driver which is
>> operating in dual-emac mode by default, thus working as 2 individual
>> network interfaces. The Switch mode can be enabled by configuring devlink driver
>> parameter "switch_mode" to 1/true:
>> 	devlink dev param set platform/48484000.ethernet_switch \
>> 	name switch_mode value 1 cmode runtime
> 
> Just wondering about the migration plan.. Is this a replacement
> driver or used in addition to the old driver?
> 

Sry, I've missed you mail.

As it's pretty big change the idea is to keep both drivers at least for sometime.
Step 1: add new driver and enable it on one platform. Do announcement.
Step 2: switch all one-port and dual mac drivers to the new driver
Step 3: switch all other platform to cpsw switchdev and deprecate old driver.

-- 
Best regards,
grygorii
