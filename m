From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/RFT PATCH 0/7] gpio: omap: rework and fixes
Date: Fri, 22 May 2015 12:03:46 -0700
Message-ID: <20150522190346.GD10274@atomide.com>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@linaro.org> [150522 07:37]:
> Hi Tony,
> 
> As I promised in [1] I've prepared a new series for OMAP GPIO driver.

Great!
 
> Patches 1-2 are bug fixes.
> 
> Patches 3-6 is attempt (RFC/RFT) to rework OMAP GPIO driver taking into account
> that GPIO Chip and GPIO IRQ Chip functionality are mostly orthogonal.

Patches 1-5 seem to work for me, patch 6 does not.
So for patches 1-5, please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
 
> Patch 7 is second attempt (RFC/RFT) to Runtime PM APIs without checking current
> GPIO bank's state with BANK_USED() macro.

Made some comments on patches 6-7 on what I saw.

Regards,

Tony
