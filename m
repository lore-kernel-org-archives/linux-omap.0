From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Wed, 16 Mar 2016 15:47:10 +0100
Message-ID: <20160316144709.GA3389@earth>
References: <201507251228.27128@pali>
 <201601050034.12810@pali>
 <20160306152339.GA428@earth>
 <201603121342.33099@pali>
 <56E68B71.2030202@ti.com>
 <20160316133319.GR8413@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160316133319.GR8413@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 16, 2016 at 02:33:19PM +0100, Pali Roh=E1r wrote:
> Hi! We found out that tpa6130a2 device is being initialized before
> i2c_2 bus is initialized. So that is reason why tpa6130a2 fails...

What do you mean by initialize? A call to tpa6130a2_probe()? In that
case I wonder about client->adapter. Is it NULL?

> Any idea why kernel first try to initialize one i2c device even before
> bus itself is initialized?

Just dump the stack during the tpa6130a2 initialization and you can
see it in the kernel log:

dump_stack();

---------------

I just had another look at the driver and I think there is a race
condition for tpa6130a2_add_controls() and tpa6130a2_stereo_enable().

As far as I can see both functions check for "tpa6130a2_client !=3D
NULL". tpa6130a2_client is set before the probe function has finished,
though. Simplified probe:

=2E..
tpa6130a2_client =3D client;
set_default_regs();
acquire_power_gpio();
acquire_regulator();
tpa6130a2_power(1); // needs tpa6130a2_client
check_device();
tpa6130a2_power(0); // needs tpa6130a2_client
=2E..

If tpa6130a2_add_controls() or tpa6130a2_stereo_enable() is called
after tpa6130a2 probe has started, but before probe has completed,
tpa6130a2_client is set, but not yet initialized. The race condition
can be fixed easily by moving the tpa6130a2_client assignment directly
after the regulator acquisition.

-- Sebastian

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW6XHrAAoJENju1/PIO/qaHjIP/RGK/cFh+JqhTcQgOT1ptrS2
9nuiWD/A9A4/EhPzXepQxM5ahjecRvaHJXB5V5lNyfKwD0WsGbBpezBUWtpLS7jN
DMhvxOVoJ8ABnnDBQW1aqUPKI5oUG/lFvvfoQjIky3IvTVndUl7FUGetSiphx0Aw
L8vQpxCVH+RccilW3OOqgtwjz3/W2vXo8nxYC0jdGr2W39731HIOtCi1WErek6qI
mvmT5Pia+HL5Tr4bhTxsL1nNMmMeaCecTJ78OzxLyhwb2JgMix4eeBHiu4Q7qzW4
WMmlVNjl3e2WnYcREjrZa485Waq8JTBgFPtlctPJdMEJsMPpqWXhNUhjFpS0/9+Y
XL3xxzEOo3ldfEjrC2WTGb6IGPFlkqFUYFPlgN0Ff7/da1CAFgQXuCZV0MTTycLD
mL/x7oHCh05b12675UYeCahf7fMDPbilZkGvHRphCPdwg2/nRNx02/vloS6MI+gW
BCHVlokIZiSVVwC/SxH7comJoXVpKYNjBTTo2UXTreUsmLZszGz0HlDC/ighkN/v
opd34wurhXTuAxt2Wt4Nz1BjRpYjfmGpIev9SuJMTMVWwkUb0UFnfENTxg2JPMcf
nrkh+3nf+Wlf/4HEhaAVCsujGbs/yffr5qI7uZgeYRA1lHidwxapOCu0C96Wpr2N
q/0pY34Y+DrqRNzU0JAW
=4mG3
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
