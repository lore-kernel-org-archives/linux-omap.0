From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Linus HEAD build break
Date: Fri, 6 Nov 2015 17:09:31 +0100
Message-ID: <20151106160930.GB525@earth>
References: <871tc31atk.fsf@saruman.tx.rr.com>
 <87y4ebyznc.fsf@saruman.tx.rr.com>
 <CAAfyv35Dw_8jkoPOJek0Ta6Ve=fQ_xUiJcmxR5_NFfYOU+69Vg@mail.gmail.com>
 <87vb9fyyvn.fsf@saruman.tx.rr.com>
 <20151106145351.GA3218@atomide.com> <20151106153412.GA525@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5439973015174192452=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151106153412.GA525@earth>
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
Cc: Belisko Marek <marek.belisko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============5439973015174192452==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 06, 2015 at 04:34:12PM +0100, Sebastian Reichel wrote:
> On Fri, Nov 06, 2015 at 06:53:52AM -0800, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [151106 06:41]:
> > > Belisko Marek <marek.belisko@gmail.com> writes:
> > > > On Fri, Nov 6, 2015 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> > > >> Felipe Balbi <balbi@ti.com> writes:
> > > >>> your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties =
for bci
> > > >>> subnode") breaks build on current linus/master (which current sit=
s in
> > > >>
> > > >> this commit cannot be found in next. How come it's in linus/master=
 ?
> > > > I did post fix but Tony seems doesn't merge it:
> > > > https://lkml.org/lkml/2015/10/13/816
> > >=20
> > > looking at that thread, I have no idea how come the old version was
> > > merged in the first place. Tony was clear that it broke build and yet
> > > this patch has made its way to mainline and it didn't even go through
> > > linux-next, which makes the problem worse.
> > >=20
> > > Now we have a bisection point where the tree (well, some DTS files)
> > > won't even build. This is quite messy.
> >=20
> > Yes didn't I drop the patch and pointed out it breaks the build?
> >=20
> > Guys, please stop doing this. Do not merge driver code that has
> > not been sitting in linux next at least a week. And for the dts
> > changes, please make sure you have proper acks.
> >=20
> > And now we have yet another merge window where things unexpectedly
> > break during the merge window because of untested driver changes.
> >=20
> > Please repost the fix and I'll ack it and you guys send a new pull
> > request to fix it ASAP explaining how it happened.
>=20
> mh for some reason I accidently added it to my next branch. I'm not
> sure why, since I did not intend to queue it at all. Sorry for the
> mess.
>=20
> I wonder why it has not been in next, though. Checking my next tree,
> it should have been there since end of September.

I missed Stephen's messages about the build failure [0] and he
switched to using a checkout from 20150925, which is directly before
the patch. As a result this patch and all following patches have not
been tested in linux-next :(

I will send a revert to you guys in a few minutes, so that I can get
your ACK for sending it as pull request to Torvalds.

[0] https://lkml.org/lkml/2015/9/28/844

-- Sebastian

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWPNCxAAoJENju1/PIO/qaN5gP/ivDXGOJ/Bo/ukyv+K7jKgX0
MdDUtIMGvdF3hR4okKDyDKCAC62DJcp9kdqj+zgGWBUViHw/LGNa/9ODhGkdQcNx
SU7Dpz7s1AAcfdYSsAvHAz1UJDjBMlhTllPgXP2bzQasnU5L+eTkvraYRAv7eTyS
sRgLM+r355vzvqzwAiyW1ZEbvttFd5rQWxOXlQpSm2OXTxkjM0F9ui5mR2ug9Bfs
42fuSoaY5KaKF2oa1Rvr3kfhZ67mN7jTwWLuDSWYC88Y1nwoP1tBXvR2SRX5YZm4
VRsdSV/0eU+g6Jfx197H8lR8BNmzQ7KdFpL1Y5mezZyRwj1Gd8ohJtKs1d4Gx4FK
dVb5BHfxtqiAZqT+CO2ohouaaN9XYFbLU0uc2QseoWLKfyTvO+CaATzYOXPL6yzj
HGI1kFdW1hECwkGxasDJizzxckluvFzRYpCzA9svujMIw6IB0/vo6ARoDvL9QwxX
QLTFLL2H4Jthq4igVKyUTBEW7QkSmlCtitzU6QNpucCe2te5nRWDPzDuM5bFdssX
OE4hLVCBqGvA40d6Nvfl8jqQOrCgjtf0iFvLMQpRkMCkq8qh0X7R/J+gepKYLIsO
nrIj3heSjuwQfm+LW/0vQLcYLuzsjzDf1Na3+QAr4N/yjK0gZOEhrW5jAq5uAS3+
mvTAT4mG0P7O2V9WGrHI
=dH1S
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--


--===============5439973015174192452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5439973015174192452==--
