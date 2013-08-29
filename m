From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 16:49:29 +0100
Message-ID: <20130829154929.GJ10783@sirena.org.uk>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <20130829110534.GV10783@sirena.org.uk>
 <CAGa+x85u0OpB9o71xUTs15wt8Te-o5f0C9o22GHzZwOjn5F6=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+lkmz3FEiWbOcRWA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:40635 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab3H2Ptz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 11:49:55 -0400
Content-Disposition: inline
In-Reply-To: <CAGa+x85u0OpB9o71xUTs15wt8Te-o5f0C9o22GHzZwOjn5F6=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Russ Dill <Russ.Dill@ti.com>, Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>


--+lkmz3FEiWbOcRWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2013 at 08:29:37AM -0700, Kevin Hilman wrote:
> On Thu, Aug 29, 2013 at 4:05 AM, Mark Brown <broonie@kernel.org> wrote:

> > Someone is going to have to walk me through the context for me to fully
> > understand what this is all about - what's the problem?

> The basic problem is how to have low-level platform code (or possibly
> firmware) send commands to a regulator to scale voltage.  This has to
> happen *very* late in the suspend process, so having the drivers do it
> themselves is not feasible.

Why does it have to happen this late and are the sequences definitely
fixed ones not ones that could depend on the system state at the time
we suspend?  It'd help to know what exactly is being controlled here...

> The proposal in this series is to define the i2c commands sequence to
> be sent to the regulator in the i2c node of the DT.  The
> platform-specific code then reads the sequence from the DT and sends
> the commands (or in in the case of the current series, passes the
> sequence to some firmware on a microcontroller which does the
> sequence.)

Surely specifying things in terms of the actual sequence would be better
than trying to specify the I2C commands if you want this to be done from
Linux?  If the firmware has to cope directly then this would require the
firmware to understand what it's doing of course.

--+lkmz3FEiWbOcRWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSH22FAAoJELSic+t+oim9/+wQAJ5bhMAsYg7F4fi1x9S9ryGC
7AnizA9Dvl5I7qwTbA2ti9gexhebW7zpxo/SwkzDRsJdLusSILBvCYdQlxmbc2kQ
d3w1qMocaQ6TYO55biA7Qcdl45k4kiXzbeZOH8m/mPZOT7sxfNwCiGxTcvNsN1Zt
n9aLaoV9LaxOMELCzPWB35D0OzxMs588s9snXQIMF9Y1L/dDO045wHhL/AISRsyr
isTfI/ndL/JvAbOFpbamgshVsrX8IbIxbWAVus2/F6RVxZEb1qp2F1W2XVqdYIJg
DQNLPLQDQrlwLIkqgo0kDdyGJ6Sh6qyz/UOmDhf4eh0Mg777jmlk+DDya16YBxYJ
qjoZrOJ7S+mg4uFjSBafScjRF/p4mAqekNHyhQK+/+rxtFNf9E84wdjcZLvdXuyy
yFeBtFcH4+OCmUByyIdqhjLxzC1IrzP+dqMWzHZI+EnGdravoUq6Ep9EzNu31kQd
Tpz0unT+cQ6fdvb3q3ZrH50eB8oBmRW8IlnpDYW+oRD1leyhRNZbh8t4Zqt8/9NS
pXfGDQEsClm8etI69Ymjls2pvtM9i69t8AqI7bFtKFd+5JqGajQu2J4CwQ1U2Q8b
8ssSy94WAUZaqiSQ03ZBlSrh4rG5VhDA6engDhmDi6E5WMdISVWtXXbZUo1Ax3Yp
yEfg77EeBzvmPHri8Tcd
=ZMG7
-----END PGP SIGNATURE-----

--+lkmz3FEiWbOcRWA--
