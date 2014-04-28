From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: Add support for DRA72x family of devices
Date: Mon, 28 Apr 2014 11:39:22 +0530
Message-ID: <535DF092.7000307@ti.com>
References: <1398333987-19454-1-git-send-email-rnayak@ti.com> <1398333987-19454-3-git-send-email-rnayak@ti.com> <201404241513.54380.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <201404241513.54380.arnd@arndb.de>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com, nm@ti.com, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 24 April 2014 06:43 PM, Arnd Bergmann wrote:
> On Thursday 24 April 2014, Rajendra Nayak wrote:
>>
>> -- DRA742
>> -  compatible = "ti,dra7xx", "ti,dra7"
>> +- DRA74x
>> +  compatible = "ti,dra74", "ti,dra7"
>> +
>> +- DRA72x
>> +  compatible = "ti,dra72", "ti,dra7"
> 
> Actually, what I meant was that you should list the fill name of the SoC,
> e.g. "ti,dra742", not just "ti,dra74". Leaving out the 'x' is not going
> to prevent this from breaking when you have a new dra745 that is incompatible.
> 
> You can always list more strings, e.g.
> 
> 	compatible = "ti,dra745", "ti,dra742", "ti,dra74", "ti,dra7";
> 
> if you have a dra745 product that is fully compatible with dra742, but the
> important part here is that the first string must be the full name.

Okay, I will update the device compatibles to something like this..

DRA742
compatible = "ti,dra742", "ti,dra74", "ti,dra7"
DRA722
compatible = "ti,dra722", "ti,dra72", "ti,dra7"

And the evm compatibles as

DRA742 EVM:  Software Developement Board for DRA742
compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
DRA722 EVM: Software Development Board for DRA722
compatible = "ti,dra72-evm", "ti,dra722", "ti,dra72", "ti,dra7"

I was also calling the .dtsi files as dra72x.dtsi and dra74x.dtsi, do you suggest I call
them dra742.dtsi and dra722.dtsi instead? Just that if we end up with a dra745 which is
fully compatible with dra742, as you mentioned above, we would be using a dra742.dtsi for a dra745
device which could be a little confusing.

> 
> 	Arnd
> 

