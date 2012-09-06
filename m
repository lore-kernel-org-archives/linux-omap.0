From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] musb: Kill __init from function that are called at other
 times as well.
Date: Thu, 6 Sep 2012 20:37:26 +0300
Message-ID: <20120906173724.GE30717@arwen.pp.htv.fi>
References: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com>
 <20120906130425.GF29202@arwen.pp.htv.fi>
 <B7BE7E99-90E8-4E54-B146-C09C6643BAFE@antoniou-consulting.com>
 <20120906170740.GB17754@arwen.pp.htv.fi>
 <7CED20FA-3501-40ED-B289-28FDC04FCF20@antoniou-consulting.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7CED20FA-3501-40ED-B289-28FDC04FCF20-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 06, 2012 at 08:36:39PM +0300, Pantelis Antoniou wrote:
> Hi Felipe
>=20
> I see about __devinit.
> There's no crash because in those logs the __init modifiers are gone.

it'd be cool to see the crash, though ;-)

--=20
balbi

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSN9UAAoJEIaOsuA1yqREZ6oP/1C3vtDb9ABJIF05FO913apu
RNGwkETuZlvZEFYxLm5cwJDj+vHV5QTHeaXIre4Ap8MbP0BgHaDLvOHzs/081rjv
LGrHSJsgNpwgmtYNG3TtWbZqPFeOvVT0kNL5p/qnyoUkc+Ao34hqvOg0wOiqTzBC
ocZv1L7TslSPcPdEl1yMzcms51xBQyvYeRHPJTXmybSSMmvfp603nBOIMd6+Sy+A
ywG1yuEuyZTZzAfEH+5KkmfTFh3asIFt9E6WHA8GkW7Hz6k2kPNO0yNsQiTlcX8B
46UXdZhHez0pvf6Znhele+vhBYtIX0Itxs3I9V8EtJ9NEXO6bckJ5Ew1op1KaoL7
srr8tdP2hHd7F4Bqj5rNWL7wa4WDm0GVPOzFcDSioQocbbjAIwIfWo8wAG26RkBV
lG7FGAvh/h0yHch1rEAQjAROKesFFiZBH3jGsGfs4YYnkpY358gg4qKgHfhZ1vyJ
3yAxhyOHKrlk7Ku4ScK0adlxgRcZ8d6W4yUnXeErsCyyWeLRTi1qXm4jnLUAQWZJ
jA+JaT3BBl7tHSByB3V0ugZfYg8WqidkGd7MTBtpTL7Ke8BIdE1FeJ6zEjcl416d
7J8Lau/xaIvhgN34vKbpnNHwpgWM5zKXjRyti/bQB5PDbiVMqmxV6TobJ0xPl8eG
J5W4swa1GzLhOsCsnDXY
=bc71
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
