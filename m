From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when status is changed
Date: Wed, 18 Sep 2013 18:43:49 +0200
Message-ID: <201309181843.49850@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com> <201309181756.12782@pali> <20130918163649.GL21559@radagast>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4274049.RbU57Pnz8g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130918163649.GL21559@radagast>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Anton Vorontsov <anton@enomsg.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, freemangordon@abv.bg, Aaro Koskinen <aaro.koskinen@iki.fi>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart4274049.RbU57Pnz8g
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 September 2013 18:36:49 Felipe Balbi wrote:
> On Wed, Sep 18, 2013 at 05:56:12PM +0200, Pali Roh=C3=A1r wrote:
> > On Wednesday 18 September 2013 15:57:13 Javier Martinez
> > Canillas
> >=20
> > wrote:
> > > to split the patch in two since the patch was solving
> > > two separate issues
> >=20
> > My patch does not solving *two* issues. It is *one*
> > regression and both parts of patch are needed for fixing
> > it. Read commit message again. It does not make sense to
> > split patch fixing kernel regression into more one line
> > patches - or please clarify why.
>=20
> issue 1) twl4030-usb.c doesn't initialize atomic notifier head
> issue 2) musb doesn't call notifier chain
>=20
> do you need a drawing ?

Regression 1) power supply drivers not working since v3.5

Look at firsts emails.


Do you really have problem to do what *you* need with 1 line=20
patch which I sent? Or what what you want?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4274049.RbU57Pnz8g
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlI52EUACgkQi/DJPQPkQ1IgdwCgnGUMAxGx9VQ/j8Ha5XzPFmiM
Q7gAnRl+2/1B+8eCuCgPQ3qMaHz1mtqf
=4hO2
-----END PGP SIGNATURE-----

--nextPart4274049.RbU57Pnz8g--
