From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Wed, 6 Jan 2016 08:42:35 +0100
Message-ID: <B2CEA92E-5F60-43C1-8265-F7C66FBD90D6@goldelico.com>
References: <cover.1451995297.git.hns@goldelico.com> <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com> <568C5451.8070709@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568C5451.8070709@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>
Cc: =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Am 06.01.2016 um 00:40 schrieb Nishanth Menon <nm@ti.com>:

> On 01/05/2016 06:01 AM, H. Nikolaus Schaller wrote:
>> tested on OMP5432 EVM
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap5-board-common.dtsi | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
>> index 5cf76a1..30c0d3b 100644
>> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
>> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
>> @@ -358,6 +358,14 @@
>> 			#clock-cells = <0>;
>> 		};
>> 
>> +		rtc {
>> +			compatible = "ti,palmas-rtc";
>> +			interrupt-parent = <&palmas>;
>> +			interrupts = <8 IRQ_TYPE_NONE>;
> 
> IRQ_TYPE_NONE is not correct here -> it should have some polarity - if
> it had none, there'd be no interrupt, right?

Well, it just translates IRQ_TYPE_NONE through

Linux/include/dt-bindings/interrupt-controller/irq.h

to 

interrupts = <8 0>;

which is given as an example in

Documentation//devicetree/bindings/rtc/rtc-palmas.txt

Since I don't know anything about the rtc driver beyond the bindings documentation I assume it is correct...
I have added Laxman Dewangan because he introduced this interrupts = <8 0>;

> 
>> +			ti,backup-battery-chargeable;
>> +			ti,backup-battery-charge-high-current;
>> +		};
>> +
>> 		palmas_pmic {
>> 			compatible = "ti,palmas-pmic";
>> 			interrupt-parent = <&palmas>;
>> 
> 
> 
> -- 
> Regards,
> Nishanth Menon


BR,
Nikolaus
