From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] gpio: omap: Fix bad device access with setup_irq()
Date: Sat, 17 Jan 2015 10:10:57 +0000
Message-ID: <20150117101057.GZ11502@n2100.arm.linux.org.uk>
References: <1421448650-15904-1-git-send-email-tony@atomide.com>
 <54B9AA9D.7080300@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54B9AA9D.7080300@oracle.com>
Sender: linux-gpio-owner@vger.kernel.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 16, 2015 at 04:19:41PM -0800, santosh shilimkar wrote:
> On 1/16/2015 2:50 PM, Tony Lindgren wrote:
> >Similar to omap_gpio_irq_type() let's make sure that the GPIO
> >is usable as an interrupt if the platform init code did not
> >call gpio_request(). Otherwise we can get invalid device access
> >after setup_irq():
> >
> I let Linus W comment on it but IIRC we chewed this issue last
> time and the conclusion was the gpio_request() must have to be called
> directly or indirectly in case of irq line.

That's really not the issue here.

The issue is that it's possible to claim the interrupt, and then the
driver goes wrong - not only does it attempt in that case to access
hardware which is runtime suspended, if the interrupt is subsequently
freed, it will then do a pm_runtime_put().

The interrupt code is wrong there, plain and simple.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
