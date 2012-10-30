From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Tue, 30 Oct 2012 14:12:52 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA5C598@DBDE01.ent.ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
	<CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
	<CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
	<20121001154451.GI4840@atomide.com>
	<CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
 <CACRpkdaeu3JaLqSbqETT=D0mdUu5VpwRpS_Xohd6M963rw8QMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47249 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab2J3ON0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 10:13:26 -0400
In-Reply-To: <CACRpkdaeu3JaLqSbqETT=D0mdUu5VpwRpS_Xohd6M963rw8QMg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@wwwdotorg.org>, Grant Likely <grant.likely@secretlab.ca>, "dong.aisheng@linaro.org" <dong.aisheng@linaro.org>

On Wed, Oct 03, 2012 at 18:06:10, Linus Walleij wrote:
> On Wed, Oct 3, 2012 at 12:52 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> > On Tue, Oct 02, 2012 at 01:29:37, Linus Walleij wrote:
> 
> >> This is what we're doing for ux500 and should be a good model.
> >
> > I have looked into this, but not seen any named modes.
> 
> OK maybe it's not easy to find. If you look into:
> arch/arm/mach-ux500/board-mop500-pins.c
> you find our work in progress. Note that this is not (yet)
> using device tree. (We want to migrate all our pinctrl
> stuff first, then do DT.)
> 
> So for example this macro:
> 
> #define DB8500_PIN(pin,conf,dev) \
>         PIN_MAP_CONFIGS_PIN_DEFAULT(dev, "pinctrl-db8500", pin, conf)
> 
> Will define a config for the "default" mode for a certain
> pin.
> 
> This:
> 
> #define DB8500_PIN_SLEEP(pin, conf, dev) \
>         PIN_MAP_CONFIGS_PIN(dev, PINCTRL_STATE_SLEEP, "pinctrl-db8500", \
>                             pin, conf)
> 
> Will mutatis mutandis define a "sleep" mode for a pin.
> 
> Sorry for the macros. We'll get rid of them in the DT.
> (Now that Stephen has patched in preprocessing it will
> even look good.)
> 

Hi Linus Walleij/Tony,

I completely understood this named modes, I have added named
modes like this in am335x-xxx.dts files

am33xx_pinmux: pinmux@44e10800 {
	pinctrl-names = "default", "sleep";
	pinctrl-0 = <&user_leds_s0>;
	pinctrl-1 = <&user_leds_s1>;

	user_leds_s0: user_leds_s0 {
		pinctrl-single,pins = <
			0x54 0x7        /* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
			0x58 0x17       /* gpmc_a6.gpio1_22, OUT PULLUP | MODE7 */
			0x5c 0x7        /* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
			0x60 0x17       /* gpmc_a8.gpio1_24, OUT PULLUP | MODE7 */
		>;
	};

	user_leds_s1: user_leds_s1 {
		pinctrl-single,pins = <
			0x54 0x2e       /* gpmc_a5.gpio1_21, INPUT | MODE7 */
			0x58 0x2e       /* gpmc_a6.gpio1_22, INPUT | MODE7 */
			0x5c 0x2e       /* gpmc_a7.gpio1_23, INPUT | MODE7 */
			0x60 0x2e       /* gpmc_a8.gpio1_24, INPUT | MODE7 */
		>;
	};
};

I think "pinctrl-1" state will be used in driver
suspend/resume calls.

I have the pinmux/conf settings for default state but fully
optimized pinmux/conf values in idle & suspend states are not
available yet. Even though if I add here, I am unable to test
these pins in suspend state because suspend/resume of AM35xx
is not added yet

I have two options now
- add only default states for now, I can add reset of
the state details once suspend/resume is supported. 
- add same values in all the states, modify those once
suspend/resume is added for AM335x.

Thanks
AnilKumar
