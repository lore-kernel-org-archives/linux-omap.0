From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regulator regression in next-20180305
Date: Wed, 7 Mar 2018 07:17:06 -0800
Message-ID: <20180307151706.GG5799@atomide.com>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <CGME20180306163044epcas2p1b5bc62e4cba6c6e8c8ea7e75329c11ef@epcas2p1.samsung.com>
 <20180306163035.GE13586@sirena.org.uk>
 <bb1adc11-40ff-d37d-60f1-d6e706b058a6@samsung.com>
 <20180307141027.GD7290@sirena.org.uk>
 <339dfd3e-5c5d-1e91-8890-5bfb69049d12@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <339dfd3e-5c5d-1e91-8890-5bfb69049d12@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-omap@vger.kernel.org

* Maciej Purski <m.purski@samsung.com> [180307 14:38]:
> 
> On 03/07/2018 03:10 PM, Mark Brown wrote:
> > On Wed, Mar 07, 2018 at 01:57:12PM +0100, Maciej Purski wrote:
> > 
> > > I'm trying to figure out what is so special about these boards. The only
> > > strange thing, that I haven't noticed at first, is that all regulators share
> > > a common supply - dummy regulator. It is defined in anatop_regulator.c.
> > 
> > No, that's a regulator framework thing - the regulator framework will
> > use the dummy regulator as a supply when there's nothing described in
> > the DT so long as the client doesn't explicitly tell it that the supply
> > might be optional.
> > 
> 
> Ok, thanks for explanation. I think I have found a possibly dangerous
> scenario, but I can't see this situation possible in Fabio's case.
> 
> Assume, that we have a chain of supplies, consisting of at least 3. Say: A->B->C.
> 
> When we're setting voltage on A, we lock it, call balance_voltage(), lock
> suppliers and call set_voltage_rdev(). So we have regulators A, B, C locked.
> Then set_voltage_rdev() is trying to set voltage of its supply by calling
> set_voltage_unlocked().
> 
> Now we're on the regulator B. Set_voltage_unlocked() calls
> balance_voltage(), which again locks its supplies, if they exist. B's supply
> is C, so we end up with having a deadlock on regulator C.
> 
> Tony and Fabio, do you find this scenario possible on your boards?

For mmc0 at least typically the supply is on the PMIC for omap
variants and it's controlled over i2c or spi bus like most other
regulators. Then boards some have additional GPIO controlled
regulators. So yeah some kind of locking issue between two or
more regulators on i2c or spi bus could be the reason.

Regards,

Tony
