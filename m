From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Strange OMAP3 LCD display regression - bisected.
Date: Mon, 3 Jun 2013 12:24:21 +0300
Message-ID: <51AC60C5.40706@ti.com>
References: <20130602165019.655da2eb@notabene.brown> <51AC44A2.8050605@ti.com> <20130603185730.0a337bba@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2IONFKOJSLJWQFPSCOQRJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45915 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423Ab3FCJYb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jun 2013 05:24:31 -0400
In-Reply-To: <20130603185730.0a337bba@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>

------enig2IONFKOJSLJWQFPSCOQRJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/06/13 11:57, NeilBrown wrote:
> On Mon, 3 Jun 2013 10:24:18 +0300 Tomi Valkeinen <tomi.valkeinen@ti.com=
>

>> I'll try blanking on my omap3 board with 3.10-rc (I think I haven't
>> tried it). Did you check if the DSS hardware lost context (visible fro=
m
>> the PM counters)?
>=20
> I turned on some debugging statements and the mentioned lost-context co=
unters
> in a way that suggested they were being handled correctly (save and res=
tore
> reported appropriately matching numbers).

I was mostly interested in whether the DSS goes into OFF mode when you
blank the panel or not. If it does, and it doesn't work after unblank,
it could suggest that somehow the DSS registers are not restored correctl=
y.

I did some testing on my Overo board (3430), and it works fine if I
blank the display, or suspend the device. However, I think I'm missing
something here, as the DSS domain just stays in ON-state, even if disable=
d.

>>>  A suspend/resume cycle at this point might bring it back, but it is =
often
>>>  shimmery (low vsync?) and once it had inverse colours.
>>>
>>>  I had noticed that the panel which normally gets a 22153 kHz pixel c=
lock was
>>>  only getting a 21600 kHz clock.  This turned out to be due to the fa=
ct
>>>  that dpi_calc_dispc_cb rejects odd divisors, and it used to use a di=
visor of
>>>  '3'.
>>
>> Normally panels should not be that picky. In my experience the pixel
>> clock has to be very far from the nominal, until the panel start to fa=
il.
>=20
> As I said, it works fine at first boot.  So the panel obviously copes. =
 But
> something weird happens at blank/unblack which is affect by the pixel c=
lock
> setting in a non-obvious way.

Right. You don't have the option to measure the pixel clock with an
oscilloscope?

>> However, the code in dpi_calc_dispc_cb only rejects odd divisors, if t=
he
>> pixel clock is greater than 100MHz. So I don't understand how you're
>> seeing it affect here. Are you sure the pclk is ~22MHz?
>=20
> If think you got some maths wrong.
> dpi_calc_dispc_cb() contains:
> 	if (ctx->pck_min >=3D 1000000) {
>=20
> which isn't 100MHz, unless the units are 0.1KHz, which seems unlikely.
> It looks to me like the units for pck_min is Hz, so the cut off is 1MHz=
=2E
> So that should be:
> 	if (ctx->pck_min >=3D 100000000) {
> ??

Indeed, it's plain wrong. The original patch introducing that limit is
b7f1fe541b01f6edaff0a5dd48027de6ac711ab6 , from which I copied the limit
to the new clock calculation. Both are from me, both are wrong. Sigh.

Thanks for pointing this out, I'll send a fix.

But, as I said earlier, I doubt that it affects your case. Especially if
the panel works after boot.

 Tomi



------enig2IONFKOJSLJWQFPSCOQRJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRrGDFAAoJEPo9qoy8lh713qcP/j7MT+po/DmbFMxlj6wiJXLY
P0TJuo92ay2cWqkswmn447P4t/+M9or9q6mDaNHpcA7BhYHzV/pWJXV4sxxpGdqN
EpHZM121oiE7NGMYYVmcw/jJDYII9SHlSyR0E7bWeN1UmexHrY7iv4ohKifNQlI2
1IHs5s9/+NUPfQaYGjBFOEzMw6n9pMsf0Mw+X9cQHTqS1+advktamp0dfrrLf606
p6sjA8uOHF4XP+OR+l2n9c246bN6+DaYZNQWiM8l7j4tvFB5Yp3s/K5dGAy32vIQ
6xm+Wq0du5WehoyBXLmSoA9QnkBBTSl1krij1+7++RVG4M/Q4Cv7A2t5lIt3xT7b
g5KIbwNjexpnWjRZqChJoqcQEWEXrMrW8JnexvhjrsZ3+/iy3iuk49yvKeAj11M2
WBMR/MpS7Me7Qipr+MTVl8g3p+Sujo72Q22fbmkxvCNb0LeJaLQ64t/Qe4KyOUCx
Ok+jJff7I/uNeePNfRPy67xwpMbGrKHPmAcMrwGWKE75cRiS6lGYVtTd/8yYG9EB
k6w57M9hiU+epxX9eqxZwcEP/gYJ5sbgHmojog0hN1xsFroxrxDI3/vaBlkU0oDC
A5Os7GswFWuQWxd8z8fHIemOyAcg4a4aM8zZX+6RBNHLO6DhCZZrClAI37IOieEZ
JdC+y8A/rhgUDz9/R47s
=ZCyg
-----END PGP SIGNATURE-----

------enig2IONFKOJSLJWQFPSCOQRJ--
