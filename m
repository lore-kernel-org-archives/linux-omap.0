From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Mon, 4 Jan 2016 18:34:55 +0100
Message-ID: <201601041834.56056@pali>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2852743590475315773=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160104170206.GC12777@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============2852743590475315773==
Content-Type: multipart/signed;
  boundary="nextPart1488441.WQRajYLEny";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1488441.WQRajYLEny
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 04 January 2016 18:02:06 Tony Lindgren wrote:
> Care to boot with CONFIG_OMAP_GPMC_DEBUG=3Dy and post the gpmc related
> dmesg output?

Hi Tony. We do not have serial console for N900 and so when kernel is=20
not fully bootable to userspace we cannot provide dmesg for you :-(

Maybe something with simple initramfs could work, but really if you have=20
serial console for N900 it should be for you lot of easier to get it.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1488441.WQRajYLEny
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaKrUAACgkQi/DJPQPkQ1Ko9gCbBFfJ2xniYDxIL3h8yPYApAic
ikQAnjulqc1gF5ZkMf9sjSDzPfkxscmI
=PqMg
-----END PGP SIGNATURE-----

--nextPart1488441.WQRajYLEny--


--===============2852743590475315773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2852743590475315773==--
