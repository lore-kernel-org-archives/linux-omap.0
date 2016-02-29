From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7: Support QSPI MODE-0 operation at 64MHz
Date: Mon, 29 Feb 2016 17:22:45 +0530
Message-ID: <56D4310D.5020608@ti.com>
References: <1456375652-14071-1-git-send-email-vigneshr@ti.com>
 <20160226191342.GF13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160226191342.GF13417@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 02/27/2016 12:43 AM, Tony Lindgren wrote:
> Hi,
> 
> * Vignesh R <vigneshr@ti.com> [160224 20:49]:
>> According to Data Manual(SPRS915P) of AM57x, TI QSPI controller on
>> DRA74(rev 1.1+) can support up to 64MHz in MODE-0, whereas MODE-3 is
>> limited to 48MHz. Hence, switch to MODE-0 for better throughput.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  arch/arm/boot/dts/dra7-evm.dts | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
>> index cfc24e52244e..15f10bdc8c31 100644
>> --- a/arch/arm/boot/dts/dra7-evm.dts
>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>> @@ -653,15 +653,13 @@
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&qspi1_pins>;
>>  
>> -	spi-max-frequency = <48000000>;
>> +	spi-max-frequency = <64000000>;
>>  	m25p80@0 {
>>  		compatible = "s25fl256s1";
>> -		spi-max-frequency = <48000000>;
>> +		spi-max-frequency = <64000000>;
>>  		reg = <0>;
>>  		spi-tx-bus-width = <1>;
>>  		spi-rx-bus-width = <4>;
>> -		spi-cpol;
>> -		spi-cpha;
>>  		#address-cells = <1>;
>>  		#size-cells = <1>;
>>  
> 
> Do we have any earlier pre DRA74(rev 1.1)versions in use too?

Yes, there are pre 1.1 boards (production boards are all rev 1.1+), but
QSPI is broken on them due to erratas (even w/o this patch).

> 
> What about the spi-cpol and spi-cpha changes? Those should be
> at least documented?
> 

Ok, I will add a NOTE in the documentation saying "spi-cpol" and
"spi-cpha" are not supported by ti-qspi in
Documentation/devicetree/bindings/spi/ti_qspi.txt.

-- 
Regards
Vignesh
