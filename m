From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Thu, 24 Nov 2011 11:04:39 +0100
Message-ID: <CACRpkdaStA_+SiqwnA-=jCi4XusHqcwgVzUUWyDg7byTPq1_JA@mail.gmail.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
	<1321274409-24643-2-git-send-email-rnayak@ti.com>
	<20111114172312.GI31337@atomide.com>
	<4EC1EB9D.1000503@ti.com>
	<CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
	<CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
	<CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw@mail.gmail.com>
	<CAJuYYwT_useS-8cH+qfDu5t7wh73yUuJAVXMjP5CXBS2VM3bag@mail.gmail.com>
	<CACRpkdax0GK=mNNao7FPc6JG0RwVywSEzGJPC_u73iJ_eOTgqQ@mail.gmail.com>
	<20111122175409.GE31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20111122175409.GE31337@atomide.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linus.walleij@stericsson.com, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 22, 2011 at 6:54 PM, Tony Lindgren <tony@atomide.com> wrote:

> Note that with device tree things get simpler for muxing as we can
> get rid of the hardcoded grouping of pins in mux drivers. Instead of
> hardcoded pingroups, the groups can be created dynamically based on
> what the driver DT entries have.

Yes, I know too little about DT to figure out how these should
come in.

> The reason why we want to avoid hardcoded pin groups is because trying
> to map all the pad combinations in the pinmux driver is not a scalable
> way to go. And it's not even possible at least on omaps because of the
> huge number of combinations with alternative pins and multiple packages.

Yes, that's a solid case!

> FYI I'm playing with a DT based pinmux-simple.c driver that should
> be pretty generic and work for all kinds of hardware hopefully.

I love it.

> It will be few days before I can post anything though, there are
> some pinctrl fwk issues to deal with first. Like the hardcoded
> pinmux_maps that assumes that dev entries are static. This means
> that multiple instances of pinmux drivers won't work..

I'm not following, but I guess I will understand when I see the
patches. The idea behind the current map concept is that you
get either a string or struct device * to identify the pin controller
and mapped device, that's as far as I thought it out, sorry for
any inherent limitations, they're not intentional...

Thanks,
Linus Walleij
