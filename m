From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Sun, 24 Nov 2013 20:26:09 +0100
Message-ID: <20131124192608.GA11338@earth.universe>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
 <20131124165959.GA655@earth.universe>
 <201311242001.16299@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201311242001.16299@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2013 at 08:01:16PM +0100, Pali Roh=E1r wrote:
> > I'm wondering if the watchdog thread should check some values,
> > like e.g. battery temperature. It should stop charging the
> > battery if some critical battery temperature threshold is
> > reached.
>=20
> For checking battery temperature is needed third driver=20
> (rx51_battery.ko).

I know, but that doesn't mean one can skip the check.

> And I think this should not be implemented in driver itself but in
> charger manager framework...

There is a reason, that the HW has a watchdog. I think the safety
relevant stuff should be done in the watchdog thread. This ensures,
that charging depends on reading the safety relevant sensors.

Of course the watchdog stuff could be moved into the charger manager
framework...

> Currently on Maemo 5 this is handled in userspace (with open=20
> source dsme daemon).

I assume it currently also takes care of the bq2415x watchdog? That
means if the daemon dies charging will stop, because the watchdog
does no longer trigger.

When your patch is applied you have introduced a safety issue.
When the daemon dies charging will continue and temperature is
no longer checked.

-- Sebastian

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSklLQAAoJENju1/PIO/qaqZ8P/3Ud47p1oEEhOwFzgsAKTiFa
6PTa2mnMb6siZ3L3zgb2zCrHbp92NVUHYmeQjVl1SiZ3B4DekVbCJwGWvkGAjiVb
3cwP41vl/OXBA6IVJyrGDvpGKcndaTgILtXcXiSOe4mLMSQhoXbOcOOj66n25Hkd
IIXWq9fHwgWnmHY8fvSMvjr8Tvy/XOZf1gMmTNimTVXGmBDL30SaUu+ya/Mymo32
LES4AZl2AbvJKO2AJOZEWQuIKSt8HrggyHwyCGpOH9mfd5CEfPFf/WuNCOgVXVe+
4VwhUiwXolaQf83JubZHgooxfLw9jXj3m1b0cHvqCGtm3COXP9223hLNvtScbWXV
IVDC9cDDcSWR6zGXXaCTSsAAqokL58lhJy3TsQPqB3wWnDEaDVBzDJtnXuwaA3LI
RHQP/SLNAm8VNY3MEujd2a4/ciJgxfU0yyz1vwk1YZ1oLf8J1Up16UHKLdMwgt76
E6NqeMBNcBzef7z+fOWFOewJpMhucfgK/Z8PYqYAsviOjkC6b8E7uYk3tNlDFTqM
ZcJpLfkDSj9VPcdacGXnnc3ibrqkdzeArLWdJVdsyYYK4INjt+1YPpPe+SpBvR+Z
xmYNvTfX+0dkHQFTU5Nej24dVDcdKx4PXZxzICd6Ti/zAhwQZF6Y/QuXjV6MUt7J
/WjnmNYlPaH5+B2uHF/I
=gGhw
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
