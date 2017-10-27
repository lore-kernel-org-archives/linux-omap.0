From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Fri, 27 Oct 2017 12:19:05 +0200
Message-ID: <20171027101905.GA4287@amd>
References: <20171025203459.GA22035@amd>
 <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
 <20171026095734.GA10141@amd>
 <20171026120130.dicanunwcdmjntnb@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026120130.dicanunwcdmjntnb@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So I got it to work; here are my notes from debugging. I put them on
https://elinux.org/N950 , too.

If someone knows how to fix the backlight, it would still be useful.

Best regards,
								Pavel
							=09

Run your kernels with something like:

# power off your phone
sudo ../maemo/0xffff/src/0xFFFF -l -m kernel:arch/arm/boot/$IMG -b
# plug in the phone.
Your usually get an error here:

Waiting for ASIC ID...
Error: Invalid size of ASIC ID
Error: Reading ASIC ID failed
Error: No device detected
^C

Hit ^c, and restart 0xFFFF. You should get

Sending image...
  100% [#################################################################]
Done

now.

You should get /!\ Warning! screen now. Some bootloader versions way
for ~10 seconds, some don't. Some bootloader versions power off
immediately if you attempt to supply command line arguments.

Watch the screen. It will go dark. If it blinks, it is a good
sign. You may want to check with flashlight, maybe there's almost
invisible text there.

Ignore the notification LED. It seems to blink even without kernel involvem=
ent.

Keyboard "debug enabled" LED can be used for debugging.




--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnzCBkACgkQMOfwapXb+vLyUACfV5lvq1AY+SdRLi6JBfhS8ElB
kwQAnizQgTnMxUWjzH2OTQ22qRwm0wYP
=YlY8
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
