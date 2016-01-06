From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Wed, 6 Jan 2016 09:11:21 +0100
Message-ID: <8FE6954B-6411-4593-9CE5-717A469A6AA8@goldelico.com>
References: <cover.1451995297.git.hns@goldelico.com> <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com> <568C5451.8070709@ti.com> <20160106010011.GG12777@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160106010011.GG12777@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Laxman Dewangan <ldewangan@nvidia.com>
Cc: Nishanth Menon <nm@ti.com>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Am 06.01.2016 um 02:00 schrieb Tony Lindgren <tony@atomide.com>:

> * Nishanth Menon <nm@ti.com> [160105 15:40]:
>> On 01/05/2016 06:01 AM, H. Nikolaus Schaller wrote:
>>> tested on OMP5432 EVM
>>> 
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> arch/arm/boot/dts/omap5-board-common.dtsi | 8 ++++++++
>>> 1 file changed, 8 insertions(+)
>>> 
>>> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
>>> index 5cf76a1..30c0d3b 100644
>>> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
>>> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
>>> @@ -358,6 +358,14 @@
>>> 			#clock-cells = <0>;
>>> 		};
>>> 
>>> +		rtc {
>>> +			compatible = "ti,palmas-rtc";
>>> +			interrupt-parent = <&palmas>;
>>> +			interrupts = <8 IRQ_TYPE_NONE>;
>> 
>> IRQ_TYPE_NONE is not correct here -> it should have some polarity - if
>> it had none, there'd be no interrupt, right?
> 
> Also I'm not seeing just zeroes coming from RTC after typing hwclock
> on omap5-uevm. It's working on x15 though.
> 
> Nikolaus, is hwclock command working for you on omap5-uevm?

Well, yes and no. It appears it *was* working when tested last time
(we sometimes have months of delay for submitting patches upstream).

I have found an SD image with 4.3-rc6 with this patch in the dtb and
there it works. With 4.4-rc8 it does not work. hwclock command hangs for
10 seconds (I guess some timeout).

I have checked the dtb and in both cases it is interrupts = <8 0>;

xxd /sys/firmware/devicetree/base/ocp/i2c@48070000/palmas@48/rtc/interrupts
0000000: 0000 0008 0000 0000

So I think something has changed in the rtc driver or somewhere else.

BR,
Nikolaus
