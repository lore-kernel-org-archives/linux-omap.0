From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] serial: omap: fix the overrun case
Date: Fri, 21 Sep 2012 14:35:07 +0300
Message-ID: <20120921113506.GF16003@arwen.pp.htv.fi>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
 <20120921110050.GC16003@arwen.pp.htv.fi>
 <505C4CA4.6020507@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <505C4CA4.6020507@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com
List-Id: linux-omap@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2012 at 04:46:52PM +0530, Shubhrajyoti wrote:
> On Friday 21 September 2012 04:30 PM, Felipe Balbi wrote:
> > On Fri, Sep 21, 2012 at 03:52:56PM +0530, Shubhrajyoti D wrote:
> >> Overrun also causes an internal flag to be set, which disables further
> >> reception. Before the next frame can
> >> be received, the MPU must:
> >> =E2=80=A2 Reset the RX FIFO.
> >> =E2=80=A2 clear the internal flag.
> >>
> >> In the uart mode a dummy read is needed. Add the same.
> > Very nice patch but I think commit log can be a bit more verbose.
> ok
> > Please make the problem a little clearer. Why do we even get that
> > interrupt fired if BRK_ERROR_BITS aren't set ?
> I did not get this point.
>=20
> it it is !  BRK_ERROR_BITS I return.

That's what I mean. rlsi handler is basically taking care of those
bits... So how come we get RLSI IRQ when those bits aren't set ?

Meaning, you shouldn't ever need that check, right ? Ideally, whenever
that handler is called, it's because BRK_ERROR_BITS are set.

Maybe add a WARN_ONCE() kinda thing just to see if that will ever really
happen ??

--=20
balbi

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXFDqAAoJEIaOsuA1yqRElv8P/2oKFBENn+fMMf8mQuxRrKCZ
dLKgYFOIde6OXh41xlwCOL5Q0f2m70OU3PTKjMSii/Md68CIf2SCAhCjkqgoKjl2
w1NSHA30JzohDmf/7ZzAfFejup0K3k4AFOcSkQZpTuCzH/rvwcx9/TAjk+KHa4v2
pfzfhK7hRCnByqVqRp3HXCUeVBBiUeAfC91pKFUfq5iYfmbvFiwhM9kENBuTL7f8
4hiEYTek3Zj41+eCUAqSCowiifpCBanJf62Mx/eJMFWV7DFBu2nxHSwUvClmd1zN
eVfVu0MoX64lkyx1pSirCQHRxG4JZ5fBL7A/9urZEnd2fUhX6ym20zgpQGVqX1ah
VzwxAw3UzO+OqzSWuGHPtAUjUoOvr+omfVLOmOrd3UgPy3r0BXfnGjtcouTmUlfZ
h3ThT7dQxYlm8fVfwe/3DC6gbEV8gUJ7Dj/Wjn05NIR4HgZoVnZjjsvqGlhqHIcr
4QeFJWFoO5wjQfUU137h/IOYwX+KcnV0h4HRLN27oHdU4OKc8OOGrRq1yoIsKAHw
wP6R+Jx9lLAKGKSimEwaMdexxKWJcJ2ittS5RCY+xCCPEhSB1kuRVQV9svsE/NkZ
zzdV9MNI6tYLQhIcq8naverAf/T6kJALMgFg8nHfiFu28OlI4dbeed4odF63RVTh
KoUAoZUsESQ5oUL2sOyi
=qqxD
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
