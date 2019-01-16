From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Wed, 16 Jan 2019 14:58:29 +0100
Message-ID: <20190116135829.GA10426@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181228193105.GW6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * Pavel Machek <pavel@ucw.cz> [181227 10:17]:
> > Ok, I really need SMS messages, too.
> >=20
> > Fortunately, they are on /dev/motmdm9, in PDU format. Quite
> > logical. And you probably need to acknowledge them, using PDU,
> > too... (because otherwise you'll just get the same SMS over and over
> > and over). Which is also logical, but hard to do from shell/python.
>=20
> Yeah so I found that Ruby pdu_tools module allows decoding PDUs
> properly while I did not have much luck with other tools.
>=20
> So I wrote a hasty script to read SMS, copy it to a Maildir and
> then ack it:
>=20
> https://github.com/tmlind/droid4-sms-tools

I could not get that one to work.

/var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:in
`class_eval': /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:
`@@{' is not allowed as a class variable name (SyntaxError)
/var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47: syntax error,
unexpected end-of-input
          unless defined? @@{:default=3D>true}
	                              ^
=66rom /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:in `block in =
cattr_accessor'
				=09

And I wanted to ask -- did you figure out how to acknowledge the
SMSs? +CGNNA does not seem to do the job:

07912470338016...
AT+CGNMA=3D1
+CGNMA:ERROR=3D9

> > Fortunately ttyUSB4 still works, so I can still use my old code... and
> > I started logging motmdm1 and 9 to a file as a backup... that should
> > be better than my existing solution. (But I don't get power benefits
> > etc.)
>=20
> So what are you using to ack the received SMS over ttyUSB4?
>=20
> My logs show that Android uses two different commands for ack.
> Either AT+GCNMA=3D1 or AT+CNMA=3D0,0 gets used depending on something
> that I have no idea of.. Maybe the network connected?

I believe I tried both... but for some reason I think you need to
paste back "acknowledge PDU"...?


Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw/OIUACgkQMOfwapXb+vJbkgCfZqQ749WAy9iVhYjTZLaBv7Pv
IaIAnjGYv3zjXtJ4rv6LEZLE41PhNmip
=fBDo
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
