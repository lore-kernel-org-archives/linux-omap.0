From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/9] ARM: dts: omap3: Add an empty chosen node to top
 level DTSI
Date: Mon, 2 Jan 2017 19:01:22 +0100
Message-ID: <201701021901.22476@pali>
References: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
 <1482158681-4530-3-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1790374566702098828=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1482158681-4530-3-git-send-email-javier@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1790374566702098828==
Content-Type: multipart/signed;
  boundary="nextPart1589658.ne9uvhShho";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1589658.ne9uvhShho
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 19 December 2016 15:44:34 Javier Martinez Canillas wrote:
> Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage")
> removed the skeleton.dtsi usage since we want to get rid of it.
>=20
> But this can cause issues when booting a kernel with a boot-loader
> that doesn't create a chosen node if this isn't present in the DTB
> since the decompressor relies on a pre-existing chosen node to be
> available to insert the command line and merge other ATAGS info.
>=20
> Fixes: 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage")
> Reported-by: Pali Rohar <pali.rohar@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Including empty chosen node fixes (or rather workaround) this problem.=20
You can add my Tested-By.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1589658.ne9uvhShho
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhqlXIACgkQi/DJPQPkQ1KykgCdFEGHXJMGa9F2NDojt3FoYAP8
N7IAoK8gbZurOMm8f2/DG9fuATNkyn6+
=rCS9
-----END PGP SIGNATURE-----

--nextPart1589658.ne9uvhShho--


--===============1790374566702098828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1790374566702098828==--
