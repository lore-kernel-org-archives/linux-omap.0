From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Tue, 30 Oct 2012 15:11:57 +0100
Message-ID: <CACRpkdZVboPbr8SQHnkbhqkMsYO8eR_a+PA-EAkRsF8Mr_K3dw@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
	<20121024161429.GA16350@core.coreip.homeip.net>
	<CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
	<4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
	<20121024185818.GB772@arwen.pp.htv.fi>
	<20121025205901.GA3827@sirena.org.uk>
	<20121026062008.GA21734@arwen.pp.htv.fi>
	<20121026160316.GY18814@opensource.wolfsonmicro.com>
	<20121029194901.GA30152@arwen.pp.htv.fi>
	<20121030112410.GM4511@opensource.wolfsonmicro.com>
	<20121030114949.GC28722@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20121030114949.GC28722@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
To: balbi@ti.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 30, 2012 at 12:49 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Oct 30, 2012 at 11:24:10AM +0000, Mark Brown wrote:

>> We need some place to put the SoC integration; power domains seem like
>> the obvious place to me but YMMV.  Nothing about having this out of the
>
> except that pin muxing has nothing to do with power domain. To me that
> sounds like an abuse of the API.

It could be renamed to "power resources" or something as long as
it's related to resource handling related to the PM calls.

But I worry that it violates the Unix principle to do one thing and one
thing only.

A device power resource framework goes in the opposite direction,
trying to do a lot of unrelated things in a central place as opposed
to distributing the task.

>> drivers requires that this be done by individual subsystems in isolation
>> from each other.  Half the point here is that for the reusable IPs this
>> stuff often isn't driver specific at all, it's often more about the SoC
>> integration than it is about the driver and so you'll get a consistent
>> pattern for most IPs on the SoC.
>
> and all of that SoC-specific detail is already hidden behind power
> domains, runtime PM, pinctrl, clk API, regulator framework, etc.

I agree.

pinctrl has already done a fair job at trying to be abstract in the
states requested from the core, in <linux/pinctrl/pinctrl-state.h>.

And I accept the idea to  try to centralize more as well, maybe
as a helpful struct and some inlines for the pinctrl core. I think
this is enough, and pushing all handles into central code creates
a problem elsewhere.

(But I'm not so certain ... so I might just
change opinion one of those days depending on what
arguments will be made.)

Yours,
Linus Walleij
