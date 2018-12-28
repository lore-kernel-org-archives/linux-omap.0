From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Fri, 28 Dec 2018 21:46:14 +0100
Message-ID: <20181228204614.GA9431@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181228193105.GW6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Yeah so I found that Ruby pdu_tools module allows decoding PDUs
> properly while I did not have much luck with other tools.
>=20
> So I wrote a hasty script to read SMS, copy it to a Maildir and
> then ack it:
>=20
> https://github.com/tmlind/droid4-sms-tools

Aha, that was quick :-). Interesting, let me take a look.

> > Proper solution involves special support for ofonod...
>=20
> Yeah at least we're dealing with standard PDU format now for
> incoming SMS.
>=20
> Also looks like there is no status on the modem for these incoming
> messages as checked with mmcli. I guess the idea with raw PDU
> access is that the message is delivered directly to the client
> and then acked instead of being queued in the modem?

I'm not sure what "directly" and "client" is here, but yes, it seems
that motmdm9 just delivers messages, and if you don't ack them,
network will just keep retransmitting the message.

> > Fortunately ttyUSB4 still works, so I can still use my old code... and
> > I started logging motmdm1 and 9 to a file as a backup... that should
> > be better than my existing solution. (But I don't get power benefits
> > etc.)
>=20
> So what are you using to ack the received SMS over ttyUSB4?

I have ofone with direct AT access --
https://github.com/pavelmachek/unicsy_demo/blob/master/ofone/at.py .

And then better solution using ofone + ofonod.

https://github.com/maemo-leste/bugtracker/issues/150

Now, ttyUSB4 provides quite a rich interface, and you can actually
select what if you want messages in text and PDU format, and if you
want modem to auto-acknowledge messages for you.

(But I don't think all options work).

It may be even possible to select if you want the messages to be
queued or delivered directly.

> My logs show that Android uses two different commands for ack.
> Either AT+GCNMA=3D1 or AT+CNMA=3D0,0 gets used depending on something
> that I have no idea of.. Maybe the network connected?

Not sure what goes on there.

> Sending SMS via /dev/motmdm3 needs move investigation, but at
> least ModemManager mmcli can be used to create and send SMS.
>=20
> Hmm or what are you using to send SMS over ttyUSB4?
> I think you already replied with some of that info earlier
> but I can't find it..

Same as above -- in text mode sending messages is very easy (can be
done by hand in minicom, or at.py can do it), and ofonod can already
do PDU encoding etc.

> Oh one more thing, I noticed that on /dev/motmdm1, typing
> AT+SCRN=3D0 supresses notifications except for WAKEUP, and then
> 1 is used to enable them again. That allows the UART to idle
> instead of getting network status messages every few seconds :)

What kind of battery life do you get with all the optimalizations?
IIRC I was getting 7h with ttyUSB4 in use...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwmi5YACgkQMOfwapXb+vI2+wCgtsn0dqWzuSNmTJ3PVOBlu5aW
X7wAn1KV/kVHN+45c6CD9RStnD34mPyj
=5X3+
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
