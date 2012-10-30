From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Tue, 30 Oct 2012 15:16:02 +0100
Message-ID: <CACRpkdZysB2mxj5wZfE0N+iwTE-_AXbOV0bKRP5kSo=1hieKGg@mail.gmail.com>
References: <20121024161429.GA16350@core.coreip.homeip.net>
	<CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
	<4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
	<20121024185818.GB772@arwen.pp.htv.fi>
	<20121025205901.GA3827@sirena.org.uk>
	<20121026062008.GA21734@arwen.pp.htv.fi>
	<20121026160316.GY18814@opensource.wolfsonmicro.com>
	<20121029194901.GA30152@arwen.pp.htv.fi>
	<20121030112410.GM4511@opensource.wolfsonmicro.com>
	<20121030114949.GC28722@arwen.pp.htv.fi>
	<20121030140714.GO4511@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20121030140714.GO4511@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 30, 2012 at 3:07 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> Essentially all the patches I'm seeing adding pinctrl are totally
> mindless, most of them are just doing the initial setup on boot and not
> doing any active management at runtime at all.

None of the Ux500 pinctrl patches are like that.

I concludes in some other mails that all Ux500 drivers
will need to handle atleast two states (default and sleep)
and some a third state (idle).

And this is what we're doing in our patches.

Arguably it can all be pushed to power domains, but that
will as said mandate all affected systems to implement
power domains, and effectively moving code from
drivers/* to arch/arm/* in our case atleast.

Yours,
Linus Walleij
