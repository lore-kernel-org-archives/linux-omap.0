From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Sun, 24 Nov 2013 18:00:00 +0100
Message-ID: <20131124165959.GA655@earth.universe>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 19, 2013 at 11:18:04AM +0100, Pali Roh=E1r wrote:
> This patch removing set_mode_hook function from board data and replacing =
it with
> new string variable of notifier power supply device. After this change it=
 is
> possible to add DT support because driver does not need specific board fu=
nction
> anymore. Only static data and name of power supply device is required.

I'm wondering if the watchdog thread should check some values, like
e.g. battery temperature. It should stop charging the battery if
some critical battery temperature threshold is reached.

-- Sebastian

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSkjCPAAoJENju1/PIO/qaoDsP/iVZpYZlYuwkLn2ZKexVlEYP
NdilWdxNGMKUBTdGIrBMpxSpBoJ8zuGZIH8qXOW0KHC//+iNHZNe3IuJ2rePzvsA
UWYRLkBfS1RMh19hBPSvoNgERAGXp+PbX4ndrTsutfgLizQjHEHC1AgpQO2m4W1R
pVf21lf2lvfLjatVtfZe+Yk1P/fdyUMpda1ytAHx2XtuBHDqxf0cQCO74WEfh6h/
wNyGkxvLXaOS5+6y8SobO4XIn/wzJzal7WAopBs3vw5ZIxtv08GvJTDlSLqj+/i1
Zz7BvEZLrng/s6h6/Yc0VQi1+OsGGtf5r1ibmTeHHuThJ8wrqmnq/QBAyAytZj16
jz2Ky2HjMKbNsTbDNAus0Q7O3x1B7SFleFm0N7M/jFkK/9kdl6jczWZACshvEpI1
Jsux/VpKOfl7e9nscY4ObKS4TWX1uZa+ATPacSDt9RRcPfja83zYbH34l28AKJTH
mMeTSdbzlyjCLFCKxtfEe0IrhUQN+JaqkR3MA9Gxs8mxF1KLL2pUuQMNAfw0HJJi
PQZXoGDL4ZLlqc61Q24iWA+CFHXjU91cdler8eXx+jXpC7dRVnJ0owocwJ5goUv7
yws/KiDGV5LPMNwznf0FDD0av1CHlhI2X1mcHcNrnP4Tyd5Qm9TpBRzWJEXHeioR
bKSZsApOiIYrZENCxC7r
=RsAT
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
