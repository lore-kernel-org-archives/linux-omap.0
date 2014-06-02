From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] gpio: of: Allow -gpio suffix for property names
Date: Mon, 2 Jun 2014 16:14:23 -0700
Message-ID: <20140602231423.GF11004@atomide.com>
References: <1398266889-17489-1-git-send-email-thierry.reding@gmail.com>
 <1398266889-17489-2-git-send-email-thierry.reding@gmail.com>
 <CACRpkdbF3N5bFY1sFkabDHO7J0F8sb1uU0xL+mjkuF-z7VocMQ@mail.gmail.com>
 <20140602230457.GE11004@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140602230457.GE11004@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140602 16:06]:
> * Linus Walleij <linus.walleij@linaro.org> [140425 00:53]:
> > On Wed, Apr 23, 2014 at 5:28 PM, Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > 
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Many bindings use the -gpio suffix in property names. Support this in
> > > addition to the -gpios suffix when requesting GPIOs using the new
> > > descriptor-based API.
> > >
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > 
> > It appears this can save quite a lot of code in drivers, work that
> > I trust Thierry to persue based on this to some extent so patch is
> > tentatively applied unless something comes up.
> 
> Looks like this patch causes a regression where GPIOs on I2C will
> no longer return -EPROBE_DEFER but seem to return -ENOENT instead.
> 
> This breaks drivers using things like devm_gpiod_get_index()
> on a GPIO that's on a I2C bus not probed yet.
> 
> Reverting commit dd34c37aa3e (gpio: of: Allow -gpio suffix for
> property names) fixes things.

Looks like something like below fixes the issue.

Regards,

Tony

8< -----------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 2 Jun 2014 16:13:46 -0700
Subject: [PATCH] gpio: of: Fix handling for deferred probe for -gpio suffix

Commit dd34c37aa3e (gpio: of: Allow -gpio suffix for property names)
added parsing for both -gpio and -gpios suffix but also changed
the handling for deferred probe unintentionally. Because of the
looping the second name will now return -ENOENT instead of
-EPROBE_DEFER. Fix the issue by breaking out of the loop if
-EPROBE_DEFER is encountered.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2614,7 +2614,7 @@ static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 
 		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
 						&of_flags);
-		if (!IS_ERR(desc))
+		if (!IS_ERR(desc) || (PTR_ERR(desc) == -EPROBE_DEFER))
 			break;
 	}
 
