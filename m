From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 6/6] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Mon, 11 Apr 2016 13:21:12 -0700
Message-ID: <20160411202112.GE5995@atomide.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-7-git-send-email-fcooper@ti.com>
 <20160317151147.GA29802@rob-hp-laptop>
 <56EAD315.1030307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EAD315.1030307@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: Rob Herring <robh@kernel.org>, thierry.reding@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, linux@arm.linux.org.uk, paul@pwsan.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
List-Id: linux-omap@vger.kernel.org

* Franklin S Cooper Jr. <fcooper@ti.com> [160317 08:55]:
> 
> 
> On 03/17/2016 10:11 AM, Rob Herring wrote:
> > On Mon, Mar 07, 2016 at 07:23:44PM -0600, Franklin S Cooper Jr wrote:
> >> From: Vignesh R <vigneshr@ti.com>
> >>
> >> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
> >> for dt bindings.
> >>
> >> Signed-off-by: Vignesh R <vigneshr@ti.com>
> >> [fcooper@ti.com: Add eCAP and use updated bindings for PWMSS and ePWM]
> >> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> >> ---
> >> Version 5 changes:
> >> Add DT node for eCAP and update eCAP binding documentation
> >>
> >> Version 4 changes:
> >> Updated link to the latest documentation
> >>
> >>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |  9 +++
> >>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  9 +++
> >>  .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 15 +++-
> >>  arch/arm/boot/dts/dra7.dtsi                        | 84 ++++++++++++++++++++++
> >>  4 files changed, 116 insertions(+), 1 deletion(-)
> >
> >> +			ehrpwm1: pwm@48440200 {
> >> +				compatible = "ti,dra7xx-ehrpwm",
> >> +					     "ti,am33xx-ehrpwm";
> >> +				#pwm-cells = <3>;
> >> +				reg = <0x48440200 0x80>;
> >> +				clocks = <&ehrpwm1_tbclk>;
> >> +				clock-names = "tbclk";
> >> +				status = "disabled";
> >> +			};
> >> +
> >> +			ecap1: ecap@48440100 {
> > This also is a PWM? Then it should also be pwm@...
> 
> The enhanced capture module primary purpose is to measure
> time between external signals which is called capture mode.
> It also has a PWM mode. So I wouldn't recommend generalizing
> the entire node to pwm.

So is this patch safe for me to apply now or do we need more
changes?

Regards,

Tony
