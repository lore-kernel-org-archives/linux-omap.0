From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
Date: Sat, 7 Nov 2015 03:44:57 +0100
Message-ID: <20151107024457.GA18676@earth>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
 <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
 <20151107091925.7dcd14a7@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6350227625245360941=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151107091925.7dcd14a7@canb.auug.org.au>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Tyler Baker <tyler.baker@linaro.org>, Felipe Balbi <balbi@ti.com>, Olof Johansson <olof@lixom.net>, Marek Belisko <marek@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============6350227625245360941==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 07, 2015 at 09:19:25AM +1100, Stephen Rothwell wrote:
> On Fri, 6 Nov 2015 10:36:34 -0800 Kevin Hilman <khilman@kernel.org> wrote:
> > On Fri, Nov 6, 2015 at 8:13 AM, Sebastian Reichel <sre@kernel.org> wrot=
e:
> > > This reverts commit af19161aaed7ff8d1a52b2e517460f2fa0774e32,
> > > which breaks the omap3 device tree build due to a wrong reference.
> > >
> > > I accidently queued this change via the power supply subsystem while
> > > telling Marek at the same time, that it should go through Tony's tree.
> > > Following that I did miss Stephen's messages about the build failure =
in
> > > linux-next and since he switched to merging an older snapshot nobody
> > > else noticed the problem in my tree. I didn't notice myself, since I
> > > did not build any device tree files assuming none have changed by me.
> > >
> > > Signed-off-by: Sebastian Reichel <sre@kernel.org> =20
> >=20
> > We also found this in kernelci.org build testing, and verified that
> > this fixes the build.
> >=20
> > Tested-by: Kevin Hilman <khilman@linaro.org>
> >=20
> > Thanks Felipe for reporting, and thanks Sebastian for the quick fix.
>=20
> I think "quick fix" is a bit rich.  I reported this to Sebastian on
> Sept 29, Oct 2 , Oct 8, Oct 16, and Oct 21.

Yes, I did see them after searching for them. My filter rules put
your mails together with the LKML mails (which I usually skip over
quite fast), so I did not notice the first one. Since the follow up
mails were in the same thread as the one(s) previously marked as
dont-care, I didn't notice them either.

> The only response I got was from Marek Belisko on Oct 8 and 21. I
> have been using the battery tree (git://git.infradead.org/battery-2.6.git=
#master)
> from Sept 25, so none of the commits after that have been in any linux-ne=
xt
> release.
>
> Yes, I am a little annoyed.

Sorry :(

> Do people have trouble receiving my emails?

I did create two extra rules for your mails directly after preparing
the revert, so I hope it won't happen again.

On Sat, Fri, 6 Nov 2015 14:36:25 -0800, Kevin Hilman wrote:
> I don't think the problem was not getting your emails, looks like the
> problem was a major disconnect between what was sent to Linus and what
> was in -next. :(

Is there an easy way to check this, so that I can create a cronjob
checkin it? Having an additional automatic "your tree differs from
linux-next" would be helpful, since that would make me search for
the problem/a mail from Stephen.

-- Sebastian

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWPWWjAAoJENju1/PIO/qa7nAQAId59kZTxwC5AkvBjaeig7xZ
8837Y8Ruxq9BmPMwlrb8biKDMuB09WbNdQQ6wGpuEsLtreqXkmVOgwN0vEwe/ZrT
zwKcgVMIauiqP5badIzKriBnR+i/bV4BBi2lrwQHrTNdeaM78WDG1MTDgQ0PiTNw
N8USO+5z5CwUhhbqeeIoCv/IN4dqgAAEMS08RKgacGkS6Ckk/ixxiRXnGWzvwGFb
m70y5E7PtiQyOhh/Dp3DlJCwy0AHF5K842m9a6yTOhgHHRQbdEBkRIaINctyDN0R
O4lYRw9BxDu9CXAi2md6WhFrfeIteNy8n8PC5H6debJlYOQbGLh3FSom1BZIZYWx
3FpNW17KDJSzP70JXgUE/WxinwVEFs0SQkYTJZJBiQwvMgB39Bpzc0xy9A9DhlZc
85KfEsnKZs2OIcWdJgvCtjyjn6DqTkCAHw0MaKl20e7h9xOK5IwrYehjCuDTMUwn
+5oYInqp3aYJqQvKMoT973anAQtYlafa0NcP9Qsl31CualaY7ciodcH5WNNU9Xni
3AXC/i3xj5bjnXJ9Y+sIa+iDh19jO08ms7erROpIoN0n1towmmt/ARtAg9epjekg
AYleQZhiLJihg9isFD2iPs2gkpIuBYQc5glH6KlhUHjNq2LfYwQmbry8Zw/blNHP
/HfAcY1Y1JDMu7qlctdI
=Fepb
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--


--===============6350227625245360941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6350227625245360941==--
