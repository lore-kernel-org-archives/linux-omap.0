From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Linus HEAD build break
Date: Fri, 6 Nov 2015 16:34:12 +0100
Message-ID: <20151106153412.GA525@earth>
References: <871tc31atk.fsf@saruman.tx.rr.com>
 <87y4ebyznc.fsf@saruman.tx.rr.com>
 <CAAfyv35Dw_8jkoPOJek0Ta6Ve=fQ_xUiJcmxR5_NFfYOU+69Vg@mail.gmail.com>
 <87vb9fyyvn.fsf@saruman.tx.rr.com>
 <20151106145351.GA3218@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1584112463868473121=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151106145351.GA3218@atomide.com>
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


--===============1584112463868473121==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 06, 2015 at 06:53:52AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [151106 06:41]:
> > Belisko Marek <marek.belisko@gmail.com> writes:
> > > On Fri, Nov 6, 2015 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> > >> Felipe Balbi <balbi@ti.com> writes:
> > >>> your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties fo=
r bci
> > >>> subnode") breaks build on current linus/master (which current sits =
in
> > >>
> > >> this commit cannot be found in next. How come it's in linus/master ?
> > > I did post fix but Tony seems doesn't merge it:
> > > https://lkml.org/lkml/2015/10/13/816
> >=20
> > looking at that thread, I have no idea how come the old version was
> > merged in the first place. Tony was clear that it broke build and yet
> > this patch has made its way to mainline and it didn't even go through
> > linux-next, which makes the problem worse.
> >=20
> > Now we have a bisection point where the tree (well, some DTS files)
> > won't even build. This is quite messy.
>=20
> Yes didn't I drop the patch and pointed out it breaks the build?
>=20
> Guys, please stop doing this. Do not merge driver code that has
> not been sitting in linux next at least a week. And for the dts
> changes, please make sure you have proper acks.
>=20
> And now we have yet another merge window where things unexpectedly
> break during the merge window because of untested driver changes.
>=20
> Please repost the fix and I'll ack it and you guys send a new pull
> request to fix it ASAP explaining how it happened.

mh for some reason I accidently added it to my next branch. I'm not
sure why, since I did not intend to queue it at all. Sorry for the
mess.

I wonder why it has not been in next, though. Checking my next tree,
it should have been there since end of September.

-- Sebastian

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWPMhxAAoJENju1/PIO/qaUjsP/1Izt1b/85w+ofs+ksqk/DL7
5QiaiZdhL57Q1pYjXFgYYZtAPXrTafgsMWS8jn0pWEDhN5FFLQJe4syZCwlzupn6
eXzGKnalpTdYqbIKIWzNA7shYgO3n9dyUTygDfTeSsRhY6sb/tMah/2X722prW5c
gRWNHK5UTsXRvKeoF21MVDhwH1r/6jn3VtrWn/T4LBxS2gzJETBZ31vZ1DT2kcUk
39uO4pxJPK3hd4lCiz7Zi0FucpSu+48AN2E/BLzkn+oav24ygJp0roN6aTAix9We
KRe8QoobTvgAvEMQnZLpWFxiaKR3k0XEyWqf3hg5f5UqfickbPgmWwHt08T+Lgh5
HIJfFe8DXxGEFvxvcpV3PwI2b4NmL+lNGPWAyHR4MR1dPS8wzK4I1msCUF/HB3U7
cdCqRhhnrQVN2h0vtunXvIguB60g05OiY3VP90XONvVHFs4W9KIrFH3jsiJYOQV2
2055D6a97haUJL3OtW42m1WcL7m88SuTyCi4zQRKPlN6dFkY7UM+QPe89yIv+AXt
zf7Y1/XZ6A/bBPWvmV6Rub31GKeLZL/JpYLuuAoXzRp0aD/qs60nfm7gJVgeLZID
DuD/ocdsxEPEguJH9kdzprszJ7WXToPzcDaVYYKtCvRZG6V1zISvQlTtXUjllNCa
hMtOND2r/jgSb1cCNm8G
=9BfN
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--


--===============1584112463868473121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1584112463868473121==--
