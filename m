From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Wed, 31 Oct 2012 14:19:03 +0100
Message-ID: <20121031131903.GF19021@game.jcrosoft.org>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 21:12 Sun 28 Oct     , Linus Walleij wrote:
> On Wed, Oct 24, 2012 at 7:28 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> >> drivers/spi/spi-pl022.c
> >
> > Default/sleep transitions could be moved into bus code.
> 
> No that's not a good idea as long as we have both the platform bus
> and the AMBA bus doing essentially the same thing. We will then be
> having two copies of the same code in two different busses running
> out of sync. There may be other busses too.
> 
> But I could prepare static helpers in <linux/pinctrl/consumer.h>
> that any bus could use. Or any driver. Probably any driver,
> because of this:
> 
> As noted the bus cannot really execute the pinctrl calls to
> e.g. put a drivers pins into "sleep". Since if e.g. the bus is walking
> the suspend() ladder, shall it put the pins into sleep *before*
> or *after* calling the suspend() hook in the driver?
> 
> The answer is that it does not know. Because drivers have
> different needs. Depending on how the hardware and
> system is done.
> 
> I already tried to make this point:
> 
> pinctrl_set_state(state_sleep);
> clk_disable();
> power_off_voltage_domain();
> 
> May for some drivers have to be:
> 
> clk_disable();
> power_off_voltage_domain();
> pinctrl_set_state(state_sleep);
> 
> (etc)
> 
> I'm not making this up, it is a very real phenomenon on the
> Ux500 and I don't think we are unique.
I agree with Linus

you can not handle pinctrl as bus levell

as each driver need different requirement before enabling the pin

as example you may need to clock the ip before muxing the pin and invertly

on some IP the pinctrl is optionnal, on other mandatory

you can not expect every driver to have the same need and requirement

yes we will have a few code duplication

but today it's few lines and those few lines will be place at different init
stage on the drivers ditto for remove or sleep/idle


> 
> Moving this handling to bus code or anywhere else
> invariably implies that resource acquisition/release order
> does not matter, and my point is that it does.

100% agreed

Best Regards,
J.
> 
> >> drivers/i2c/busses/i2c-nomadik.c
> >
> > Don't see pinctrl in linux-next.
> 
> This code is here:
> http://marc.info/?l=linux-i2c&m=134986995731695&w=2
> 
> Yours,
> Linus Walleij
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
