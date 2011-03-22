From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Tue, 22 Mar 2011 16:31:44 +0000
Message-ID: <20110322163144.GC2202@sirena.org.uk>
References: <20110322142619.1109.89105.sendpatchset@t400s> <20110322142855.GB2202@sirena.org.uk> <20110322143307.GB24004@linux-sh.org> <AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com> <20110322153226.GC30303@linux-sh.org> <AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com> <20110322155730.GD30303@linux-sh.org> <AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, dmitry.torokhov@gmail.com, srk@ti.com, khilman@ti.com, chinyeow.sim.xt@renesas.com, linux-sh@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 23, 2011 at 01:20:23AM +0900, Magnus Damm wrote:
> On Wed, Mar 23, 2011 at 12:57 AM, Paul Mundt <lethal@linux-sh.org> wrote:

> > In this case I would suspect general indifference or simply copying other
> > drivers. I2C is a bit of a tricky case with regards to ordering in
> > general, but at least input devices are relatively straightforward.

> I remember having to move the init order around at least once before
> in the case of i2c, so I'm not so surprised when new initcall issues
> come up now and then.

It's mostly an issue for PMICs (and possibly some other similar things)
so that the regulators are present before their consumers try to start.
I'm not aware of any issues with I2C itself.

> The "may" above comes from that I don't know the i2c bus driver
> initcall time on non-SH-Mobile platforms. So this may trigger on other
> platforms, or it may not depending on their cpu/board code and I2c bus
> driver.

In general embedded platforms register I2C early as things like PMICs
typically hang off them.  Grant was trying to push people to use
deferred registration for this stuff but it didn't happen yet and I'd
personally be more comfortable with more infastructure supporting that.
