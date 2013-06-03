From: NeilBrown <neilb@suse.de>
Subject: Re: Strange OMAP3 LCD display regression - bisected.
Date: Mon, 3 Jun 2013 18:57:30 +1000
Message-ID: <20130603185730.0a337bba@notabene.brown>
References: <20130602165019.655da2eb@notabene.brown>
	<51AC44A2.8050605@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Erd0s945olQIZWB_J9W/3NW"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48361 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009Ab3FCI5o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jun 2013 04:57:44 -0400
In-Reply-To: <51AC44A2.8050605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>

--Sig_/Erd0s945olQIZWB_J9W/3NW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jun 2013 10:24:18 +0300 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:

> Hi,
>=20
> On 02/06/13 09:50, NeilBrown wrote:
>=20
> > The details:
> >  I'm currently trying to move from a 3.7 kernel on my GTA04 to a 3.10-rc
> >  kernel (hopefully to have 3.10 fully working by the time it comes out.=
.).
>=20
> I presume the panel driver is not in the mainline? Is there anything
> special with the panel, or is it just a "dummy" DPI panel that doesn't
> need any kind of configuration?

Not in mainline.  If you are interested it is here:

http://git.neil.brown.name/?p=3Dgta04.git;a=3Dblob;f=3Ddrivers/video/omap2/=
displays/panel-tpo-td028ttec1.c;h=3Dc127e47b88ff2822fc0f168ed6706e16d6115ab=
f;hb=3D69c0e01e14bd9651a1768f8108d21d39334e724b

Needs lots of cleanup.  Pokes at a bunch of SPI registers which I might have
documentation for somewhere but haven't had time to look at it yet.


>=20
> >  Once I got it compiling and booting I found that while the display wor=
ked
> >  perfectly at boot, after it has been turned off (ioctl(FBIOBLANK)) and=
 back
> >  on again, it is all white - no discernible image at all.
>=20
> I'll try blanking on my omap3 board with 3.10-rc (I think I haven't
> tried it). Did you check if the DSS hardware lost context (visible from
> the PM counters)?

I turned on some debugging statements and the mentioned lost-context counte=
rs
in a way that suggested they were being handled correctly (save and restore
reported appropriately matching numbers).

>=20
> >  A suspend/resume cycle at this point might bring it back, but it is of=
ten
> >  shimmery (low vsync?) and once it had inverse colours.
> >=20
> >  I had noticed that the panel which normally gets a 22153 kHz pixel clo=
ck was
> >  only getting a 21600 kHz clock.  This turned out to be due to the fact
> >  that dpi_calc_dispc_cb rejects odd divisors, and it used to use a divi=
sor of
> >  '3'.
>=20
> Normally panels should not be that picky. In my experience the pixel
> clock has to be very far from the nominal, until the panel start to fail.

As I said, it works fine at first boot.  So the panel obviously copes.  But
something weird happens at blank/unblack which is affect by the pixel clock
setting in a non-obvious way.

>=20
> However, the code in dpi_calc_dispc_cb only rejects odd divisors, if the
> pixel clock is greater than 100MHz. So I don't understand how you're
> seeing it affect here. Are you sure the pclk is ~22MHz?

If think you got some maths wrong.
dpi_calc_dispc_cb() contains:
	if (ctx->pck_min >=3D 1000000) {

which isn't 100MHz, unless the units are 0.1KHz, which seems unlikely.
It looks to me like the units for pck_min is Hz, so the cut off is 1MHz.
So that should be:
	if (ctx->pck_min >=3D 100000000) {
??

>=20
> >  I tried reverting the "OMAPDSS: fix TV-out issue with DSI PLL" patch f=
rom
> >  3.10-rc as below, and it seems to behave better, returning from blank
> >  properly. This is without disabling the "no odd divisors" code.
>=20
> Odd, indeed. Without reverting the patch, the DSS uses a clock from the
> PRCM as func clock and for pixel clock. As the common clock framework is
> somehow involved in the breakage, maybe (pure guess) something related
> to the PRCM clock is configured wrong.
>=20
> And with reverting the above patch, DSS uses DSI PLL for fclk and pclk,
> and DSI PLL in turn only needs sysclk, so maybe the possible problem
> with PRCM doesn't affect this case.
>=20

I'll try the patch that Paul and Jean-Philippe suggested and report the
results.

Thanks

NeilBrown


--Sig_/Erd0s945olQIZWB_J9W/3NW
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUaxaeznsnt1WYoG5AQJrNQ//Wg/1y/3d7RFJ8jKKl9/tuEtEZ3gGapOA
MnhNMSVavZmGVweeMoEkVetujH4Zzb0USx1zIDIpG11mPGcTKMDCaHMxGcQLjt9T
Nm9HPcHXJEEVRpNvSkU9xV650jGpZib1TJUWOXYOkeOnmbVRN8e+kcto5dp113dF
7CQhPLZu0Nz8h2pLFfNpYK2Ow1w0sPRnXhPj3kyb6kY/UZNLkevILl64jbuAtdW/
0rU0jHNXTbpQJ5XmotIMW69mm6jgRW5st8U4u9gPc3VyzgbZ+ERWS8VzEc7nZvdo
/VBXna6GKG9c1M1/ZpJKBEMl94eIV/PFyM/tpp74erfgGMJka3nzbdPK2HxTxxYP
gSyBHsGryvDtaCI/1BuCQhM1owLa3Y7lz2hD1kZHynt+Cu4mRpy0Ur+6CGY0Y4xt
9pyzuLw5+ZlBqkPiCKdTcHJxUAVN/Mp11eknzyDhBSwBwGfKhH7UBgr9RqVBajUL
E19lWKWBQ9I3SFbz2fj9GFhRafeUSEb7JnFjqeVtJ48nWQ1eWbpBW9XJoE3VZiKd
awn0m2TwWnWQpRcmfB0F+NDwzLKYnR18mU9nnz5HSNZi3kqNZk7i47IXJT2VKg71
X9IuvPe07+hdvJjKEkf427F6GepifRBDu8K87WSLy7zhTNg12LGQ7+XFZzDL1TrI
LVVdwO9cUPI=
=ReTO
-----END PGP SIGNATURE-----

--Sig_/Erd0s945olQIZWB_J9W/3NW--
