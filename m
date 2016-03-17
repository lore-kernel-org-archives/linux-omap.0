From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Thu, 17 Mar 2016 07:32:05 -0700
Message-ID: <20160317143204.GM9329@atomide.com>
References: <20160316144709.GA3389@earth>
 <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com>
 <56E9B910.7000904@gmail.com>
 <20160317004917.GA6750@earth>
 <56EA6326.4000702@gmail.com>
 <20160317130115.GU8413@pali>
 <56EAACF4.2040005@gmail.com>
 <20160317133313.GL9329@atomide.com>
 <56EAB62D.80803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EAB62D.80803@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160317 06:51]:
> Hi,
> 
> On 17.03.2016 15:33, Tony Lindgren wrote:
> >
> >Check the schematics. If the hardware has external pull-ups on a
> >line then don't enable the internal pull-ups. Otherwise both the
> >external and intenal pulls are parallel the pull value will be
> >wrong. My guess is that on n900 all the i2c lines have external
> >pulls.
> 
> There are, 1k connected to VIO_18, but still, stock Nokia kernel enables the
> internal pull-ups as well. I doubt Nokia devs did that by mistake. Could it
> be that VIO_18 is disabled by the time  TPA6130A2 is probed?

Seems like a bug to me. My bets are on the deferred probe related
Peter posted.

> Also, what is the problem to have both internal and external pull-ups in
> parallel?

You can calculate the parallel resistor value of the weak internal
pull with the 1k external pull :) If the i2c line pulls are wrong
the signal quality won't match the spec and you will be getting
i2c bus errors. If you can read and write to the i2c chip, this
is not the issue.

Regards,

Tony
