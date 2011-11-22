From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Tue, 22 Nov 2011 09:54:09 -0800
Message-ID: <20111122175409.GE31337@atomide.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
 <1321274409-24643-2-git-send-email-rnayak@ti.com>
 <20111114172312.GI31337@atomide.com>
 <4EC1EB9D.1000503@ti.com>
 <CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
 <CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
 <CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw@mail.gmail.com>
 <CAJuYYwT_useS-8cH+qfDu5t7wh73yUuJAVXMjP5CXBS2VM3bag@mail.gmail.com>
 <CACRpkdax0GK=mNNao7FPc6JG0RwVywSEzGJPC_u73iJ_eOTgqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdax0GK=mNNao7FPc6JG0RwVywSEzGJPC_u73iJ_eOTgqQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linus.walleij@stericsson.com, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [111122 03:30]:
> On Tue, Nov 22, 2011 at 12:09 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
> > On 17 November 2011 19:27, Linus Walleij <linus.walleij@linaro.org> wrote:
> >>
> >> Maybe I'm mistaken about the device tree ambitions, but
> >> I was sort of hoping that it would not contain too much
> >> custom magic numbers that need to be cross-referenced
> >> elsewhere ... or rather - the more understandable the device
> >> tree is, the more we win.
> >
> > Device tree is expected to describe the hardware. So to
> > cross-reference the hardware manual to understand device tree should
> > be fine I guess. For instance, GPIO numbers in dts would be written as
> > a numeric number and not a enum or other format. And by looking up the
> > manual, we understand the actual details of the GPIO pin.
> >
> > If dt-compiler had a option to support #define like in C, the numbers
> > could have been made more easier to understand. Like, 3 to mean
> > GPIO_PULL_UP in Exynos dts file.
> 
> OK I think I get it now, so DT bindings shall really NOT be read
> by any of the pinctrl core, it is *supposed* to be all driver-specific.
> Then it makes perfect sense to have it as it is.

Yes the driver nodes should describe in DT which pins to use:

        serial@12340000 {
                compatible = "8250";
                reg = <0x12340000 0x40>;
                reg-shift = <2>;
                interrupts = < 10 >;
		pins = "uart1_rx", "uart1_tx";
        };

Note that we should use the actual signal names, not package specific
pad names. This way they have a high likelyhood to work for new packages
too by just mapping the signals to the new package.

> So for example in the pinctrl-coh901xxx.c example driver I have
> locally defined registers presets like:
> 
> #define U300_FLOATING_INPUT { \
>         .bias_mode = PIN_CONFIG_BIAS_HIGH_IMPEDANCE, \
>         .output = false, \
> }
> 
> #define U300_PULL_UP_INPUT { \
>         .bias_mode = PIN_CONFIG_BIAS_PULL_UP, \
>         .output = false, \
> }

I think things like above should also be set in the node for the
driver because it is board specific. For example, if you have an
external pull on the board for some line, then the internal pull
needs to be disabled.

I don't know how we should describe the driver set values though,
maybe something like:

        serial@12340000 {
                compatible = "8250";
                reg = <0x12340000 0x40>;
                reg-shift = <2>;
                interrupts = < 10 >;
		pins = "uart1_rx", "uart1_tx";
		pin-values = < 0x7 0x7 >;
	};

Note that with device tree things get simpler for muxing as we can
get rid of the hardcoded grouping of pins in mux drivers. Instead of
hardcoded pingroups, the groups can be created dynamically based on
what the driver DT entries have.

The reason why we want to avoid hardcoded pin groups is because trying
to map all the pad combinations in the pinmux driver is not a scalable
way to go. And it's not even possible at least on omaps because of the
huge number of combinations with alternative pins and multiple packages.

> Then this type of stuff shall keep its custom format in the device
> tree, and the driver for coh901xxx reads that out.
> 
> Thanks for helping me understand this crucial assumption of how
> it works...

FYI I'm playing with a DT based pinmux-simple.c driver that should
be pretty generic and work for all kinds of hardware hopefully.

It will be few days before I can post anything though, there are
some pinctrl fwk issues to deal with first. Like the hardcoded
pinmux_maps that assumes that dev entries are static. This means
that multiple instances of pinmux drivers won't work..

Cheers,

Tony
