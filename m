From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Tue, 3 Sep 2013 15:39:00 +0100
Message-ID: <20130903143900.GJ3084@sirena.org.uk>
References: <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <20130829110534.GV10783@sirena.org.uk>
 <CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
 <20130829180101.GO10783@sirena.org.uk>
 <CA+Bv8XavoekzHM6DU3BFdq8W+XK6aGr7bvW60W3L6gR2Cu2p4Q@mail.gmail.com>
 <20130829191051.GT10783@sirena.org.uk>
 <CA+Bv8XYp9zzoYa=-Obr3CW4KmQkB9mswaFj11pxffYqPY7Qwqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z+vV71AWp02Mr0PV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:48645 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab3ICOj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 10:39:26 -0400
Content-Disposition: inline
In-Reply-To: <CA+Bv8XYp9zzoYa=-Obr3CW4KmQkB9mswaFj11pxffYqPY7Qwqw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>


--Z+vV71AWp02Mr0PV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2013 at 07:06:01AM -0700, Russ Dill wrote:
> On Thu, Aug 29, 2013 at 12:10 PM, Mark Brown <broonie@kernel.org> wrote:

> > I was thinking about the majority of regulators where setting a voltage
> > would be a single bitfield update (plus ramp delay, which is going to
> > need to be accounted for in the power on case).  If we need to do longer
> > sequences things get a bit more tricky in terms of interface but it
> > seems doable.

> The sequence for TPS65217 on beaglebone is rather long, it's 8
> register writes. It has to write the new value to the DCDC3 register
> and the apply bit to the DCDC register, but both registers are
> password locked registers. The password sequence is to write the
> password register, then the register, then the password register
> again, then the register again.

Oh dear, that's a bit annoying.  It's doable obviously if people decide
to go down that route but it's work and this is a very common system.

--Z+vV71AWp02Mr0PV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJfSBAAoJELSic+t+oim98ToP/iasNxlM3WzXPz9WTnQgRfnT
ZfmXGxw3wQNT7GJ7e0XEjo3eYHyWHCHEt2m9xC7jxUWQzpf0+Fgz/jPDZcImbbVX
dOGleZyLCnhSO2QJ5AWpIBxUWHTkjp5DaNYkufiJtK6+8hzr420E9xNNrJZom8XG
w9idVdz/j+hP7I6fx3ljqHP/EoPHtorbTBeBWAcUeNZPie3oPDmkM0hRhObywH9M
7VmFDblHCtui+GTsqhMKp7pbgTfqyv5P//TYWDD+SKlN8vnFtWwQoT9Di8M2Mxul
jTL8fEuBbhWlBOA7bg2hLzL0dzhy8sBs8UJvfuYTP77OtW2p0zhc/ogmANhL8pi3
F+ym5WLfYR+9++6Xu/Lje024+mwlFZezyUUiuJVDVfzGCC1QdB4WkcCh2ja3zoo+
eBJqfs8qwGjeuHvq5oKFRSUcZ8UcnjJGzW2bYd7l7MX2dgemKiSmIvm5lDfgxmVl
eo73tp9NNKx7mAkPfEDBTL4UvG06JCGLhCyIII4pLOkI5gF7b/1gNM1d4jdUsW4/
Cq84HVzMAVkamrBSedbd2we897PlTRp/verh9lJGKEkUDQoRa0FvJ3XehMSi9e8D
/BKlqgvI7cnQQrLx8eJP3SKL6tEI8ssHJAdEP/SnlwMN9dJY8f0vUsLJzjf7N2ij
vY+3owlS5PSpEzRRPpr7
=ggZr
-----END PGP SIGNATURE-----

--Z+vV71AWp02Mr0PV--
