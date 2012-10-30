From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Tue, 30 Oct 2012 11:20:07 -0700
Message-ID: <20121030182007.GA21851@core.coreip.homeip.net>
References: <20121025205901.GA3827@sirena.org.uk>
 <20121026062008.GA21734@arwen.pp.htv.fi>
 <20121026160316.GY18814@opensource.wolfsonmicro.com>
 <20121029194901.GA30152@arwen.pp.htv.fi>
 <20121030112410.GM4511@opensource.wolfsonmicro.com>
 <20121030114949.GC28722@arwen.pp.htv.fi>
 <20121030140714.GO4511@opensource.wolfsonmicro.com>
 <20121030151642.GE29159@arwen.pp.htv.fi>
 <20121030155821.GU4511@opensource.wolfsonmicro.com>
 <20121030172513.GA3993@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121030172513.GA3993@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Linus Walleij <linus.walleij@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 30, 2012 at 07:25:13PM +0200, Felipe Balbi wrote:
> On Tue, Oct 30, 2012 at 03:58:21PM +0000, Mark Brown wrote:
> > 
> > But then this comes round to the mindless code that ought to be factored
> > out :)  Only the more interesting cases that do something unusual really
> > register here.
> 
> fair enough. I see your point. Not saying I agree though, just that this
> discussion has been flying for far too long, so feel free to provide
> patches implementing what you're defending here ;-)
> 
> Guess code will speak for itself. On way or another, we need OMAP keypad
> driver working in mainline

Are you saying that introducing pincrtl infrastructure actually _broke_
the driver in mainline?

Thanks.

-- 
Dmitry
