From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 1/3] Documentation: common clk API
Date: Wed, 21 Mar 2012 08:59:11 +0000
Message-ID: <201203210859.11899.arnd@arndb.de>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org> <201203170905.33191.arnd@arndb.de> <alpine.DEB.2.00.1203201731550.22974@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1203201731550.22974@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Turquette, Mike" <mturquette@ti.com>, linux-arm-kernel@lists.infradead.org, Amit Kucheria <amit.kucheria@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Saravana Kannan <skannan@codeaurora.org>, Jeremy Kerr <jeremy.kerr@canonical.com>, Magnus Damm <magnus.damm@gmail.com>, Deepak Saxena <dsaxena@linaro.org>, patches@linaro.org, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Zhao <richard.zhao@linaro.org>, Shawn Guo <shawn.guo@freescale.com>, Linus Walleij <linus.walleij@stericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 March 2012, Paul Walmsley wrote:
> Hello Arnd,
> 
> On Sat, 17 Mar 2012, Arnd Bergmann wrote:
> 
> > I think it's rather pointless, because the option is not going to
> > be user selectable but will get selected by the platform unless I'm
> > mistaken. The platform maintainers that care already know the state
> > of the framework.
> 
> This is where we have differing views, I think.  Clearly, Sascha, 
> Saravana, Rob, and I have at least slightly different opinions on the 
> durability of the existing API and code.  So it seems reasonable to assume 
> that others who have not followed the development of the common clock code 
> might mistake the implementation or API as being stable and well-defined.
> 
> It sounds like the primary objection is to the use of CONFIG_EXPERIMENTAL.  
> So here is a patch to simply note the status of this code in its Kconfig 
> text.

Yes, looks good to me. If there are no objections, I'll apply this one.

Thanks,

	Arnd
