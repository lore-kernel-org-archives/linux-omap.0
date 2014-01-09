From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Thu, 9 Jan 2014 10:27:27 +0200
Message-ID: <52CE5D6F.3050700@ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
 <52CE5123.9050702@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4187821396962864553=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
Cc: Tony Lindgren <tony@atomide.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============4187821396962864553==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VPQAPc17Q8mJBxtiS6N4leCEnUxGgOv1q"

--VPQAPc17Q8mJBxtiS6N4leCEnUxGgOv1q
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-09 10:08, Hiremath, Vaibhav wrote:

> No, that's what is causing issue to me. Can you try predefined address =
flow?
> Just to highlight, I get UNDERFLOW during boot itself, immediately when=
 it gets mapped to userspace.
>=20
> Boot LOG:
>=20

> [    4.822549] Freeing unused kernel memory: 440K (c0919000 - c0987000)=

> [    5.276615] OMAPFB: pan_display(0)
> [    5.276625] OMAPFB: setcmap
> [    5.276635] OMAPFB: setcmap
> [    5.293518] OMAPFB: user mmap region start a0000000, len 1536000, of=
f 0
> [    5.300171] omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling th=
e overlay

Hmm that's interesting... So you have some tool that's ran early, which
draws something on the screen? Or maybe that's X starting?

Ah... I think I understand now. As I mentioned, AM4x has issues already.
I think the CPU/others can block DSS when accessing memory. So, if we
have bad caching for the mapped framebuffer, the CPU will use more
bandwidth when reading/writing to it, and that will cause DSS to underflo=
w.

 Tomi



--VPQAPc17Q8mJBxtiS6N4leCEnUxGgOv1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzl1vAAoJEPo9qoy8lh710+YP/iz+A2RU6jrKV1LlNkvAe//u
pEZj7C183Gk1j6btYHi5SFQuE7PlTQ2nE6rMFxVerU/nIpWJS3VSBr/yAOspMlQG
jtO4oPGHgZnD5kGksNhRahD1W3H88fk1oe3IWEGViFXrxfP9DBIXft45UEQNwiFP
zFRWRDdYdzLezQrPL4afqBzkypBJ/wsy8heJkmI3Xc6ExY3Htrgp8fR8lsPdVXw6
nacP6ooRrKF7Kj2IceztnJPaDY66ARiyK3GyJ1TaBZjJgXc9MhYOZ11hYXjQcizQ
1uACHKduSoJCDAnFDQZQq6ONhSBC8Naxmh7owZFkk2MIn2c65dtvxAKHuSuHxmdz
6QLE1+GKLCSkuWOgnRQn2OV6A4l3Gyp08aGhTJPRz0pK/GYNzrgEFD/9qZ5QPLkb
8YBI99EDeQgZL1XpaJi/ZYYSb+hd2NzWCT3YeSD4tKZIGF6ffPz/XiSUmcd3ql9j
PnlOnZ/pXe+OWc8Uxd/IgabrzE0RP/m8MoBkUvOHJX7owVOsHI84jiWW8u33ZvFg
DcrGBG5kqLDvBcbMyonbCP1OO2AwcBHD35fmPhHaJSa+RhevFvJaH/ZVAawtHXbU
NALcACcjqGewT1j1SxarxIQhqsJXAixsQ8E82O1wzx/GnaNM9wJhibffBWw8LVIo
QBp4xUEAGacFuc2H2c/O
=1I2p
-----END PGP SIGNATURE-----

--VPQAPc17Q8mJBxtiS6N4leCEnUxGgOv1q--


--===============4187821396962864553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4187821396962864553==--
