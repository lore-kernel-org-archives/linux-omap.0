From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Mon, 23 Sep 2013 10:07:24 -0700
Message-ID: <20130923170724.GG2684@atomide.com>
References: <1379860848-29020-1-git-send-email-javier.martinez@collabora.co.uk>
 <20130923164519.GF2684@atomide.com>
 <524073BC.9080907@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <524073BC.9080907@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Balaji T K <balajitk@ti.com>, Jon Hunter <jgchunter@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130923 10:09]:
> On 09/23/2013 06:45 PM, Tony Lindgren wrote:
> > 
> > Hmm does this still work for legacy platform data based
> > drivers that are doing gpio_request() first?
> > 
> 
> Yes it still work when booting using board files. I tested on my OMAP3 board and
> it worked in both DT and legacy booting mode.

OK great.
 
> > And what's the path for clearing things for PM when free_irq()
> > gets called? It seems that this would leave the GPIO bank
> > enabled causing a PM regression?
> > 
> 
> Indeed, I did set bank->mod_usage |= 1 << offset so the bank is enabled if the
> device goes to suspended and then resumed but I completely forget about the
> clearing path when the IRQ is freed.
> 
> Which makes me think that we should probably maintain two usage variables, one
> for GPIO and another one for IRQ and check both of them on the suspend/resume pm
> functions.

Yes that it seems that they should be treated separately.

Regards,

Tony
