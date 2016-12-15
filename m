From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH/RFC 0/7] Remove the omapdrm device from platform code
Date: Thu, 15 Dec 2016 13:04:38 +0200
Message-ID: <c59e26d6-0475-7d13-6bf1-ca785d0aa8f3@ti.com>
References: <1481672306-22564-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161214150506.GV4920@atomide.com>
 <88473bd0-0273-3d80-2249-e3ec0d1ee928@ti.com> <2042929.xqZ0CNKz48@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0644298602=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2042929.xqZ0CNKz48@avalon>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============0644298602==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2fsBEeNxdM7hCfQ3ci7Jv8VluAsImJDGv"

--2fsBEeNxdM7hCfQ3ci7Jv8VluAsImJDGv
Content-Type: multipart/mixed; boundary="n9ui20GWbVd6xGSec7f946t0fwGb0FaMU";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org,
 linux-omap@vger.kernel.org
Message-ID: <c59e26d6-0475-7d13-6bf1-ca785d0aa8f3@ti.com>
Subject: Re: [PATCH/RFC 0/7] Remove the omapdrm device from platform code
References: <1481672306-22564-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161214150506.GV4920@atomide.com>
 <88473bd0-0273-3d80-2249-e3ec0d1ee928@ti.com> <2042929.xqZ0CNKz48@avalon>
In-Reply-To: <2042929.xqZ0CNKz48@avalon>

--n9ui20GWbVd6xGSec7f946t0fwGb0FaMU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15/12/16 12:07, Laurent Pinchart wrote:

>> Or do you have any other ideas how to pass flags to the driver based o=
n
>> the SoC revision?
>=20
> Or retrieve the SoC revision in the driver. I know this is a bad thing =
to do=20
> in general, but when handling errata that are specific to certain ES ve=
rsions,=20
> it's hard to avoid. https://patchwork.kernel.org/patch/9141381/ has bee=
n=20
> developed for that (or at least a very similar) purpose.

Ah, that should work.

 Tomi


--n9ui20GWbVd6xGSec7f946t0fwGb0FaMU--

--2fsBEeNxdM7hCfQ3ci7Jv8VluAsImJDGv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUnjGAAoJEPo9qoy8lh7174wP/iASbNKS+hl3hKyj/dad5swC
ZSZsejDcGn+3Hzy0BdXI12thwnzTrOciDzaKTsUTKl3mi/1qcogkjL5GTFT5sxz+
0GJ5+AG/A+ylkaeIHxm0bh1HlbpU7r1VJX2OhrQh2vx12aFBAbCxRrZjPRQNNg11
LfzjvQ1+Ujt7muHgbAB+PFYkAgIfBt1xijP0AxVQIrasBLSyXt9uJ9Tzh/NkVJq3
+fLB53jfS/sLdV68s+cE3WOqMg34Mj3A0fbSrfAa3EUIINpC7mBW/TOe4/2g87kT
8PDU8p2buDyqVkWFEU/CBKukEwjjAMO6RzP18tLJKwMRAkfrRtmg4Y/Wmjn5vNCM
gcHcq/W9p70sGUPdAvESTjTAvV3mT4PlvtYrbXiHX6RQ+ScNcxBSrlplbvLKxJEV
TnEVbpvHA2Rk09boCxB2vMajqt5BVuNP+hbLHxpV5N/lzVbPlfZpOH1IZdZM5ftT
nXGmSrTFLWcXb1m5fTatEZ9hOQZnHq+9OCPMbxjcT0PhnvpvszprPfiQvhq88eHD
4LOB0C1rv6MH3cNaAp9bl+OgptU5sYa8/LxEA6iPyd83SNSwQrxbOYJGJtUfoYUM
gS8rv8GE6ZkMCToZS/pchniAywjuVgRkNdibKOa5qzRfUchgO1MlRFMfcDZhSCKD
/kTobLxYC12wh2TiODFs
=x/iL
-----END PGP SIGNATURE-----

--2fsBEeNxdM7hCfQ3ci7Jv8VluAsImJDGv--

--===============0644298602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0644298602==--
