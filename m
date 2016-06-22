From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
Date: Wed, 22 Jun 2016 18:48:41 +0200
Message-ID: <201606221848.41305@pali>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <20160621112944.GV29844@pali> <20160621113215.GP22406@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3375846608549447269=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160621113215.GP22406@atomide.com>
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
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Pavel Machek <pavel@ucw.cz>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3375846608549447269==
Content-Type: multipart/signed;
  boundary="nextPart25738281.10MMZqv5ng";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart25738281.10MMZqv5ng
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 21 June 2016 13:32:16 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160621 04:32]:
> > On Tuesday 21 June 2016 04:25:36 Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [160615 05:08]:
> > > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160615 04:52]:
> > > > > On Wednesday 15 June 2016 04:02:02 Tony Lindgren wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160615 03:58]:
> > > > > > > Hi! I just quickly looked at N900 status matrix
> > > > > > > https://elinux.org/N900 and there is still one thing not
> > > > > > > finished in DT: It is slot-name for omap_hsmmc driver.
> > > > > > > So switch from legacy board code to DT is regression.
> > > > > >=20
> > > > > > That's fixed with the following in v4.7-rc series:
> > > > > >=20
> > > > > > db863d896681 ("mmc: omap_hsmmc: Check if MMC slot name is
> > > > > > passed in pdata") 10c1f7d32bf4 ("ARM: OMAP2+: n900 needs
> > > > > > MMC slot names for legacy user space")
> > > > >=20
> > > > > Great! Sorry, but now wiki is not fully updated with last
> > > > > changes and I do not have in my mind what was
> > > > > finished/merged and what not. It is going hard for me to
> > > > > track everything.
> > > >=20
> > > > OK well maybe take one more look and then ack if no more
> > > > issues.
> > >=20
> > > Pali, any news on this?
> >=20
> > I have not looked at this deeply yet. Please give me some more
> > time.
>=20
> OK I'd like to apply this series by Monday if no issues to have
> enough time for it in Linux next. Does that sound OK to you?
>=20
> Regards,
>=20
> Tony

Ok, now I looked at it and tested current version from torvalds tree.

There is still missing fixed support for IR, but that is waiting in=20
media tree queue for next merge window.

So after IR patches land in torvalds tree, I'm fine with dropping legacy=20
board code for n900 and you can add my Acked-by.

Sorry that it look so long time, but Nokia N900 is omap3 device with=20
most features & drivers.

I need to say that Nokia N900 support has good support in mainline=20
kernel, probably the best from all mobile phones. It is almost feature=20
complete, missing parts are: DSP, both cameras, bluetooth and RM radio.

So thanks everybody for this big improvement!

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart25738281.10MMZqv5ng
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldqwWkACgkQi/DJPQPkQ1L17ACfYr65RkvoYfWpUA280vKpcRTb
18wAnRal7ILsX4pWx0F2LGrwPaYnq7iI
=rPTL
-----END PGP SIGNATURE-----

--nextPart25738281.10MMZqv5ng--


--===============3375846608549447269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3375846608549447269==--
