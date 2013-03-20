From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 01/21] usb: phy: nop: Add some parameters to platform
 data
Date: Wed, 20 Mar 2013 18:19:48 +0200
Message-ID: <20130320161947.GJ1567@arwen.pp.htv.fi>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
 <1363794300-31526-2-git-send-email-rogerq@ti.com>
 <20130320155555.GG1567@arwen.pp.htv.fi>
 <20130320161324.GL16413@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/D3X8sky0X3AmG5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130320161324.GL16413@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--W/D3X8sky0X3AmG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2013 at 09:13:24AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130320 09:00]:
> > On Wed, Mar 20, 2013 at 05:44:40PM +0200, Roger Quadros wrote:
> > > Add clk_rate parameter to platform data. If supplied, the
> > > NOP phy driver will program the clock to that rate during probe.
> > >=20
> > > Also add 2 flags, needs_vcc and needs_reset.
> > > If the flag is set and the regulator couldn't be found
> > > then the driver will bail out with -EPROBE_DEFER.
> > >=20
> > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > > Acked-by: Felipe Balbi <balbi@ti.com>
> >=20
> > Hi Tony,
> >=20
> > maybe you might prefer to merge commit 1f0972f from my next branch which
> > is exactly this patch. Basically, if you:
> >=20
> > $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git=
 next
> > $ git merge 1f0972f
> >=20
> > you get $SUBJECT and can apply the others without fear of conflicts
> > later.
>=20
> OK thanks will use commit 1f0972f, so let's consider that commit immutabl=
e.

yeah, once it hits my 'next' branch, I don't rebase anymore.

cheers

ps: that's valid for 'next' and 'fixes'

--=20
balbi

--W/D3X8sky0X3AmG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSeGjAAoJEIaOsuA1yqREgfMQAI3BsA8bkQwbJl1JKrwp+kv+
9JUPJClLwXT7TFYE0pJYCgSd/zn6283BL5WdWV9ROgjagD1PEDp3oChDX9mVTwVz
7RkoGY1KCsvTQQB7hmO1ewhDspsxvewiwL3ju4Of1VjP1Bh8Xkme/pdDUZVvShbz
OGJ+djlf0TxAjdsEg07mac5gpbErWQ2YLIYg6x+MBwphshKNOPJ6J8sYV5F8YACS
sAELbxYuDwd698nIpxj9aerSZ5u05siOSSK7UfWzTDTXAysTKw/5ST0kQxgPr/v/
7DbOhyLjHjyV2C5o19eqqLhDULqFaS6Hr94nGRe9SChhYtJlPIvZtd436LIyv4kA
bw/oV5tz9Vg/s1A583kR/8xytd6wRNbIGJYYJwrQsY5B4xiyEmuna+fVkknUiFRM
+u/TmyE1XgmykLzZAERa2asy3vlOphwS4bUeWHZ5etPNjwn2S2uYRfVby/Et0BPK
zhlijQEnf6T4rDR1OFoqmhmEBMLQT3SXb5TESPULHmPuCqakQyQzzPAD3Wjzo052
3iF4vtRg6S39D8VJVWtxHwFbFwkyTQnCr7tcb8Ko5E//ELbIYmDhUi+h23Z21Uh6
/JW2+Wvh/iTCVaxctZOoAtLnU07rjB7lATyGyy+W7FyDhlh5jq5hwC3l1l5JNgz6
r6tfwBgDnfu3VLa9EeDN
=RSGV
-----END PGP SIGNATURE-----

--W/D3X8sky0X3AmG5--
