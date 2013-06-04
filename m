From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 3/3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ
 line
Date: Tue, 4 Jun 2013 14:05:05 -0400
Message-ID: <20130604180505.GG3803@titan.lakedaemon.net>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
 <1370040357-25794-4-git-send-email-khilman@linaro.org>
 <51AC667D.6070409@epfl.ch>
 <87mwr6kfbm.fsf@linaro.org>
 <20130603223935.GU3803@titan.lakedaemon.net>
 <878v2p3gh5.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25568 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750907Ab3FDSF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jun 2013 14:05:26 -0400
Content-Disposition: inline
In-Reply-To: <878v2p3gh5.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: florian.vaussard@epfl.ch, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, Jun 04, 2013 at 10:58:46AM -0700, Kevin Hilman wrote:
> Jason Cooper <jason@lakedaemon.net> writes:
> 
> > On Mon, Jun 03, 2013 at 03:19:25PM -0700, Kevin Hilman wrote:
> >> Florian Vaussard <florian.vaussard@epfl.ch> writes:
> >> 
> >> > Hello Kevin,
> >> >
> >> > On 06/01/2013 12:45 AM, Kevin Hilman wrote:
> >> >> On most OMAP3 platforms, the twl4030 IRQ line is connected to the
> >> >> SYS_NIRQ line on OMAP.  Therefore, configure the defaults for the
> >> >> SYS_NIRQ pin in the twl4030 DTS file.
> >> >>
> >> >> Boards that hook up the twl4030 differently can easily override this
> >> >> in their board-specific DTS file.
> >> >>
> >> >> This allows RTC wake from off-mode to work again on OMAP3-based
> >> >> platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
> >> >> 3530/Overo, 3730/Overo-STORM.
> >> >>
> >> >> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> >> >> ---
> >> >>   arch/arm/boot/dts/twl4030.dtsi | 17 +++++++++++++++++
> >> >>   1 file changed, 17 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> >> >> index b3034da..c7fe9f6 100644
> >> >> --- a/arch/arm/boot/dts/twl4030.dtsi
> >> >> +++ b/arch/arm/boot/dts/twl4030.dtsi
> >> >> @@ -13,6 +13,8 @@
> >> >>   	compatible = "ti,twl4030";
> >> >>   	interrupt-controller;
> >> >>   	#interrupt-cells = <1>;
> >> >> +	pinctrl-names = "default";
> >> >> +	pinctrl-0 = <&twl4030_pins>;
> >> >>
> >> >>   	rtc {
> >> >>   		compatible = "ti,twl4030-rtc";
> >> >> @@ -92,3 +94,18 @@
> >> >>   		#pwm-cells = <2>;
> >> >>   	};
> >> >>   };
> >> >> +
> >> >> +&omap3_pmx_core {
> >> >
> >> > Here you are making the TWL4030 to explicitly depend on OMAP3. Could
> >> > this chip be used by another target? If the case, I would put this
> >> > piece of code in the files including twl4030. Otherwise it's ok here.
> >> 
> >> I talked this over with Tony before posting.  In theorry, it could be
> >> used on other platforms.  In practice, it's only used on OMAP.  We can
> >> easily move this to board files if needed later, but thought it would be
> >> simpler to put it here.  I'll let Benoit decide.
> >
> > What about omap boards that don't use the twl4030?  eg I'm currently
> > tinkering with a board that uses a tps6507x...
> 
> Then you'll be inclding tps6507x.dtsi instead of twl4030.dtsi and won't
> be affected by this patch at all.

Gah!  I saw omap3_pmx_core being modified and missed that the mod was in
twl4030.dtsi.  Of course, you are right.

> Your board file should setup the muxing (using this as an example) for
> how your board wires the TPS chip to the OMAP.

Yes, that's the fun part, I'm trying to get a vanilla kernel to boot on
the Seagate Wireless Plus.  They didn't exactly hand out schematics ;-)

thx,

Jason.
