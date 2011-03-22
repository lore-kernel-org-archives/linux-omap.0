From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Tue, 22 Mar 2011 23:33:07 +0900
Message-ID: <20110322143307.GB24004@linux-sh.org>
References: <20110322142619.1109.89105.sendpatchset@t400s> <20110322142855.GB2202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110322142855.GB2202@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com, srk@ti.com, khilman@ti.com, chinyeow.sim.xt@renesas.com, linux-sh@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 22, 2011 at 02:28:55PM +0000, Mark Brown wrote:
> On Tue, Mar 22, 2011 at 11:26:19PM +0900, Magnus Damm wrote:
> 
> > The tca6416 driver makes use of the I2C bus for chatting
> > with the actual hardware device. Without this patch both
> > the I2C bus driver and the tca6416 driver are initialized
> > at the subsys_initcall() level. This may lead to problems
> > with the tca6416 driver being initialized before the I2C
> > bus driver.
> 
> While this change seems reasonable I'm curious what the problems caused
> by out of order registration are?

I'm also curious as to why link order isn't a sufficient gaurantee like
it is for everyone else?
