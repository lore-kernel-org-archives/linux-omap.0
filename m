From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 10/10] ARM: dts: n950: add display support
Date: Fri, 24 Mar 2017 16:58:45 +0200
Message-ID: <fe873378-a93f-5829-215c-fb4a3cc3f514@ti.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-10-sre@kernel.org> <20170324142939.GY10760@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1422025471=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170324142939.GY10760@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============1422025471==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="En8nGJL65BTfuest09LKL0mpjHIsVdwhI"

--En8nGJL65BTfuest09LKL0mpjHIsVdwhI
Content-Type: multipart/mixed; boundary="h7rL7tetiVqrMwlGsQW4sCim5OI7DhMeA";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <fe873378-a93f-5829-215c-fb4a3cc3f514@ti.com>
Subject: Re: [PATCHv2 10/10] ARM: dts: n950: add display support
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-10-sre@kernel.org> <20170324142939.GY10760@atomide.com>
In-Reply-To: <20170324142939.GY10760@atomide.com>

--h7rL7tetiVqrMwlGsQW4sCim5OI7DhMeA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/03/17 16:29, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [170304 16:45]:
>> Add basic panel support for the Nokia N950. It must be tweaked a
>> little bit later, since the panel was built into the device
>> upside-down. Also the first 5 and the last 5 pixels are covered
>> by plastic.
>=20
> This one seems safe to apply separately to shrink the pending
> patches a bit. Please confirm if that's the case and I'll apply
> this one.

No, I think there are too many open questions to apply this one. And we
need to move to common DRM drivers at some point (hopefully soon) so the
bindings must be aligned with those if and when possible.

 Tomi


--h7rL7tetiVqrMwlGsQW4sCim5OI7DhMeA--

--En8nGJL65BTfuest09LKL0mpjHIsVdwhI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY1TQlAAoJEPo9qoy8lh712HIQAKu3t3O8/cwS4XmgzcX87zid
/icv54ftPNdVoU7SDJvAp1E9WE8D+PN1B/Av4sNKhwFMfAfJssbvCqqUi1Q6b/F6
DDbC5TzJM8YhRimBAHg/jbmffNDK4cCZS8rP/yYCPnX1iegbBDI3UOXpC0xHX8Lb
mCXmQ4sGtaNWxEuqxNuVZg9haN/7C2GRgW7Bgtbs5nrI2S4nOhcICHqnHXYZKYV+
8YJYVL/3leXGrdvJXLoMk8vawVKyFcXhDzDP89nU+cYd/YT+mi0AA+Bn3FWgCQ2w
W084t1u1JOEWWenWaVAoJC7qLukDZesjsTMsz/YEWWp3XJqneWOsROLuYhAZkkKs
vIoVYSs0pdjGZsn76QYDOx/jY/9xkMgdGBIA8daipEu3uUGNDGyj/IbAE5gtLxrb
FxhZqw7yFRD18WIjVy/Z6jFHvS6vWYPLEvPisPjx/rJ5XoG4VqNKwmPE4OGe7+pP
e3C11bL/nqdR/5us6rU0WQX0WgYyqp1oDiWwfFXcTZxy4MiBHBeXjH2wJCrX98lt
ziASxnFtD3D8S+AeJ7zulNV51zpoaF7ux0MWNy6kvtBqIhvDrctKVqHGvCPsJbOR
RAn42fD9SPJjNViRjIB3dar6friGSk6fGde1x/FxOi9oSHJvPXOB/c3TIa8SgUQd
Wp53iSKKvIXNcJm29lSj
=PrLa
-----END PGP SIGNATURE-----

--En8nGJL65BTfuest09LKL0mpjHIsVdwhI--

--===============1422025471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1422025471==--
