From: grygorii <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH v4 net-next 10/11] ARM: dts: am57xx-idk: add dt nodes
 for new cpsw switch dev driver
Date: Wed, 26 Jun 2019 17:42:20 +0300
Message-ID: <311aa679-2656-ad1c-d2fb-b16efa1c33c4@ti.com>
References: <20190621181314.20778-1-grygorii.strashko@ti.com>
 <20190621181314.20778-11-grygorii.strashko@ti.com>
 <20190625224953.GD6485@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625224953.GD6485@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 26/06/2019 01:49, Ivan Khoronzhuk wrote:
> On Fri, Jun 21, 2019 at 09:13:13PM +0300, Grygorii Strashko wrote:
>> Add DT nodes for new cpsw switch dev driver.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> arch/arm/boot/dts/am571x-idk.dts         | 28 +++++++++++++
>> arch/arm/boot/dts/am572x-idk.dts         |  5 +++
>> arch/arm/boot/dts/am574x-idk.dts         |  5 +++
>> arch/arm/boot/dts/am57xx-idk-common.dtsi |  2 +-
>> arch/arm/boot/dts/dra7-l4.dtsi           | 53 ++++++++++++++++++++++++
>> 5 files changed, 92 insertions(+), 1 deletion(-)
>>
> 
> [...]
> 
>> diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
>> index f7bd26458915..5c7663699efa 100644
>> --- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
>> +++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
>> @@ -367,7 +367,7 @@
>> };
>>
>> &mac {
>> -    status = "okay";
>> +//    status = "okay";
> ?

This i'm going to clean up as part of next submission.

-- 
Best regards,
grygorii
