From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 3/3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ line
Date: Tue, 04 Jun 2013 10:58:46 -0700
Message-ID: <878v2p3gh5.fsf@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
	<1370040357-25794-4-git-send-email-khilman@linaro.org>
	<51AC667D.6070409@epfl.ch> <87mwr6kfbm.fsf@linaro.org>
	<20130603223935.GU3803@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:47762 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3FDR6t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jun 2013 13:58:49 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so579634pbb.34
        for <linux-omap@vger.kernel.org>; Tue, 04 Jun 2013 10:58:49 -0700 (PDT)
In-Reply-To: <20130603223935.GU3803@titan.lakedaemon.net> (Jason Cooper's
	message of "Mon, 3 Jun 2013 18:39:35 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: florian.vaussard@epfl.ch, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

> On Mon, Jun 03, 2013 at 03:19:25PM -0700, Kevin Hilman wrote:
>> Florian Vaussard <florian.vaussard@epfl.ch> writes:
>> 
>> > Hello Kevin,
>> >
>> > On 06/01/2013 12:45 AM, Kevin Hilman wrote:
>> >> On most OMAP3 platforms, the twl4030 IRQ line is connected to the
>> >> SYS_NIRQ line on OMAP.  Therefore, configure the defaults for the
>> >> SYS_NIRQ pin in the twl4030 DTS file.
>> >>
>> >> Boards that hook up the twl4030 differently can easily override this
>> >> in their board-specific DTS file.
>> >>
>> >> This allows RTC wake from off-mode to work again on OMAP3-based
>> >> platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
>> >> 3530/Overo, 3730/Overo-STORM.
>> >>
>> >> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>> >> ---
>> >>   arch/arm/boot/dts/twl4030.dtsi | 17 +++++++++++++++++
>> >>   1 file changed, 17 insertions(+)
>> >>
>> >> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
>> >> index b3034da..c7fe9f6 100644
>> >> --- a/arch/arm/boot/dts/twl4030.dtsi
>> >> +++ b/arch/arm/boot/dts/twl4030.dtsi
>> >> @@ -13,6 +13,8 @@
>> >>   	compatible = "ti,twl4030";
>> >>   	interrupt-controller;
>> >>   	#interrupt-cells = <1>;
>> >> +	pinctrl-names = "default";
>> >> +	pinctrl-0 = <&twl4030_pins>;
>> >>
>> >>   	rtc {
>> >>   		compatible = "ti,twl4030-rtc";
>> >> @@ -92,3 +94,18 @@
>> >>   		#pwm-cells = <2>;
>> >>   	};
>> >>   };
>> >> +
>> >> +&omap3_pmx_core {
>> >
>> > Here you are making the TWL4030 to explicitly depend on OMAP3. Could
>> > this chip be used by another target? If the case, I would put this
>> > piece of code in the files including twl4030. Otherwise it's ok here.
>> 
>> I talked this over with Tony before posting.  In theorry, it could be
>> used on other platforms.  In practice, it's only used on OMAP.  We can
>> easily move this to board files if needed later, but thought it would be
>> simpler to put it here.  I'll let Benoit decide.
>
> What about omap boards that don't use the twl4030?  eg I'm currently
> tinkering with a board that uses a tps6507x...

Then you'll be inclding tps6507x.dtsi instead of twl4030.dtsi and won't
be affected by this patch at all.

Your board file should setup the muxing (using this as an example) for
how your board wires the TPS chip to the OMAP.

Kevin

