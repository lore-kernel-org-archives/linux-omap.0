From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: omap5: Add l4 interconnect hierarchy and
 ti-sysc data
Date: Wed, 12 Dec 2018 12:46:02 +0200
Message-ID: <ebc7e271-8717-fe9d-d24f-ae406860b913@ti.com>
References: <20181115224546.61475-1-tony@atomide.com>
 <9b7e07ae-66f9-cedf-937d-b1c5c510e018@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9b7e07ae-66f9-cedf-937d-b1c5c510e018@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 12/12/2018 12.12, Peter Ujfalusi wrote:
> Tony,
> 
> On 16/11/2018 0.45, Tony Lindgren wrote:
>> Similar to commit 8f42cb7f64c7 ("ARM: dts: omap4: Add l4 interconnect
>> hierarchy and ti-sysc data"), let's add proper interconnect hierarchy
>> for l4 interconnect instances with the related ti-sysc interconnect
>> module data as in Documentation/devicetree/bindings/bus/ti-sysc.txt.
>>
>> Using ti-sysc driver binding allows us to start dropping legacy platform
>> data in arch/arm/mach-omap2/omap*hwmod*data.c files later on in favor of
>> ti-sysc dts data.
>>
>> This data is generated based on platform data from a booted system
>> and the interconnect acces protection registers for ranges. To avoid
>> regressions, we initially validate the device tree provided data
>> against the existing platform data on boot.
> 
> Reverting this patch in linux-next-20181210 will make the ethernet
> working again.
> 
> bootlog w/ revert: https://pastebin.com/dpRk1xWv
> bootlog w/o revert: https://pastebin.com/PWrBttxd

on omap5-uevm.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
