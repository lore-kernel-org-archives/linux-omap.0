From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: board-files: fix i2c_bus for tfp410
Date: Fri, 16 Nov 2012 16:27:01 +0200
Message-ID: <50A64D35.9050109@ti.com>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com> <20121116135155.GE18527@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5994315403964C074AB605C1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121116135155.GE18527-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--------------enig5994315403964C074AB605C1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-16 15:51, Felipe Balbi wrote:
> Hi,
>=20
> On Fri, Nov 16, 2012 at 02:22:33PM +0200, Tomi Valkeinen wrote:
>> The i2c handling in tfp410 driver, which handles converting parallel R=
GB
>> to DVI, was changed in 958f2717b84e88bf833d996997fda8f73276f2af. The
>=20
> commit summary should be added in () after commit hash. This would look=

> like:
>=20
> 'was changed in 958f271 (OMAPDSS: TFP410: pdata rewrite).'

Yep.

>> patch changed what value the driver considers as invalid/undefined.
>> Before the patch 0 was the invalid value, but as 0 is a valid bus
>                   ^
> 		  missing comma (,) character here.

Right.

>> number, the patch changed this to -1.
>>
>> However, the fact was missed that many board files do not define the b=
us
>> number at all, thus it's left to 0. This causes the driver to fail to
>> get the i2c bus, exiting from the driver's probe with an error, meanin=
g
>> that the DVI output does not work for those boards.
>>
>> This patch fixes the issue by changing the i2c_bus number field in the=

>> driver's platform data from u16 to int, and setting the bus number to =
-1
>> in the board files for the boards that did not define the bus. The
>> exception is devkit8000, for which the bus is set to 1, which is the
>> correct bus for that board.
>>
>> The bug exists in v3.5+ kernels.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
>> Reported-by: Thomas Weber <thomas-xePHB1Atl/Dsq35pWSNszA@public.gmane.org>
>> [for v3.5, v3.6 stable kernels]
>> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>=20
> This format is peculiar. Usually people use:
>=20
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v3.5 v3.6

Yes, I tried that. But my git send-email (1.7.10.4) rejects that line. I
don't know if it's my setup, that particular git version, or what...

> To be fair, the whole i2c_bus_num looks like a big hackery introduced b=
y
> the way panel drivers are written for OMAP DSS.
>=20
> TFP410 is an I2C client, not an OMAPDSS client. After a quick look at
> the driver, there's is no such thing as a DSS bus, so looks like you
> should have an I2C driver for TFP410 and the whole DSS stuff should be
> just a list of clients, but not a struct bus at all.
>=20
> The fact that you have to pass the I2C bus number down to the panel
> driver is already a big indication of how wrong this is, IMHO.

Without going deeper in the dss device model problems, I would agree
with you if this was about i2c panel, but this is not quite like that.

A panel controlled via i2c would be an i2c device. But TFP410 is not
controlled via i2c. It's not really controlled at all except via
power-down gpio. TFP410 doesn't need the i2c to be functional at all.

The i2c lines do not even touch TFP410 chip, so to be precise, the i2c
lines should not be TFP410's concern. The i2c lines come from the
monitor and go to OMAP's i2c pins. But TFP410 driver is a convenient
place to manage them.

(As a side note, TFP410 _could_ be controlled via i2c, if it would've
been setup so in the board hardware. That would be totally different
thing, though, than what's discussed here.).

Anyway, this patch wasn't meant to fix dss device model problems. It's
meant to fix a bug in the kernel.

 Tomi



--------------enig5994315403964C074AB605C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpk01AAoJEPo9qoy8lh71Th4P/RVKkIkem0ffBtQST/Pojj11
IQGgsEtOYVql2E33/H8dFi/JndQpaX81oveN767bGlrDo1Cwq2OOA8ufLKNX1v6U
BQGFcWeiFEIE8Mv8Depfw6Q/Fl1NTA0e7m8a3gt53Fzn1811e/8Tn5y+JASfKuAF
584a26VaQSe6nn1pY8rsISW9dOr+SZz3dwYFcY1k3Ucmq9raAmsRtB4QBzXVEx5g
GNc0Wrk6/WK5vXYENYeg/GsBKTh6ME1sPLWzevMhhjrr8292QfleOVFk1ILlBv8h
30PKzLV3u2WVXgFIkIsdRCN1nnx6vjmv4wV9Wr98EExah33jALIThPqkMb/OP/0q
BBii9Mer7v4Z2mTo+ysILrucn6VwyJ/9vCDaNOUzvkwVu1RFhw8RWwF73ouguC+Z
0nfoLGAtg0ZJYyO37E1WcQNHauUzR8z1cHwDFJfVe37msBe59VDIQlQWASizIrlB
q7xbbs3859emtAW21UE7HNIz9+uWOzbLsDo9imivDVc/esDG7ZfQWMyFNT+yiKqE
sWPx/tfZtGxAbsQVLSwy7zkrj5WnPM/W7DwMFz2mLBM+3wqqUUOwx/T8a/CgKh+/
dF3/3Ot3SYCpYDvOWrXSmoCenM+h89qriOxbX2id0vQzToOHTAUJ5c2rJlcKHcyv
HMSE5Y80WC4UOSumKSun
=0u+p
-----END PGP SIGNATURE-----

--------------enig5994315403964C074AB605C1--
