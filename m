From: =?UTF-8?Q?Andr=c3=a9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCH] ARM: dts: Add omap3-echo
Date: Fri, 27 Dec 2019 15:28:28 +0100
Message-ID: <53e6cbbd-1094-cba2-4942-981502a738d4@dawncrow.de>
References: <20191224161005.28083-1-nerv@dawncrow.de>
 <20191224184503.GK35479@atomide.com>
 <60412339-53BF-4DC1-8AF6-4FB0E75D429C@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60412339-53BF-4DC1-8AF6-4FB0E75D429C@goldelico.com>
Content-Language: de-LU
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>, Adam Ford <aford173@gmail.com>
Cc: linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Am 25.12.19 um 18:01 schrieb H. Nikolaus Schaller:
> I think the am3703 is a dm3730 (omap3630) where the SGX and the
> DSP have not passed production test and are "disabled" by eFuses.
> This is a common procedure in silicon production to increase yield.
> 
> Therefore, there is a register which allows to dynamically determine
> what components (SGX and DSP) are available on a specific SoC chip.
> See "Table 1-6. Chip Identification" in the common
> "AM/DM37x Multimedia Device TRM".
> 
> Such bits exists for omap34xx and for omap36xx (aka am37xx/dm37xx).
> 
> That way there is no need to disable/enable sgx through device tree
> variations and introducing more complexity by introducing more and more
> DTS for variants (am3703.dtsi, am3715.dtsi, dm3720.dtsi, dm3730.dtsi?).
> 
> BTW: what about a board that is/was produced in either am3703 or dm3730
> variants? Can they still share an omap36xx.dtsi based DTB?
> 
> So IMHO if there is an issue with sgx enabled on am3703 but no SGX
> hardware available on a specific SoC, the sysc setup should somehow read
> the bits and effectively disable all SGX related setup if it is not
> available on the SoC. If I remember correctly, some older hwmods did
> such things by checking SoC variant bits.

I like the idea, but I'm not in the position to vote for it and I don't
understand the sysc code enough to implement that.

Am 25.12.19 um 13:53 schrieb Adam Ford:
> On Wed, Dec 25, 2019 at 6:05 AM André Hentschel <nerv@dawncrow.de> wrote:
>> And then include am3703.dtsi in omap36xx.dtsi before sgx support?
> I can see value in having a 3703 base and including that in the 36xx
> with SGX and DSP nodes, but why not jus make SGX disabled by default.
> Those who want/need it can enable it on a per-board basis.
>> Or would it be better to have sgx support in a separate dtsi?
> 
> I am not sure how much DSP stuff is in there, but the DM3730 is the
> AM3703 + DSP and 3D.

For clarification this reduced table should help:
     DM3730 | DM3725 | AM3715 | AM3703
DSP    X    |   X    |        |    
SGX    X    |        |   X    |    

Where X is "supported"
