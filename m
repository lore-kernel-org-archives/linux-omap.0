From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 07 Mar 2012 13:59:59 +0200
Message-ID: <1331121599.4348.22.camel@deskari>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	 <1331040371.2059.113.camel@deskari>
	 <CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
	 <1331044544.2059.150.camel@deskari>
	 <CAF6AEGvtGjgw+uEKTu34ukXNqZ-+gS6pQtv2oFM11X8ik1zY5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Kh+ELHS8OQiG3E7kro5V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:59840 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751655Ab2CGMAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:00:04 -0500
Received: by lahi5 with SMTP id i5so7009419lah.25
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:00:02 -0800 (PST)
In-Reply-To: <CAF6AEGvtGjgw+uEKTu34ukXNqZ-+gS6pQtv2oFM11X8ik1zY5w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org


--=-Kh+ELHS8OQiG3E7kro5V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-06 at 09:29 -0600, Rob Clark wrote:
> On Tue, Mar 6, 2012 at 8:35 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:
> > On Tue, 2012-03-06 at 08:01 -0600, Rob Clark wrote:
> >> On Tue, Mar 6, 2012 at 7:26 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> >
> >> > Can there be more than one omapdrm device? I guess not. If so, the i=
d
> >> > should be -1.
> >>
> >> in the past, we have used multiple devices (using the platform-data to
> >> divide up the dss resources), although this was sort of a
> >> special-case.  But in theory you could have multiple.  (Think of a
> >> multi-seat scenario, where multiple compositors need to run and each
> >> need to be drm-master of their own device to do mode-setting on their
> >> corresponding display.)
> >>
> >> I think if we use .id =3D -1, then we'd end up with a funny looking
> >> bus-id for the device: "platform:omapdrm:-1"
> >
> > I don't know about that, but it's the way platform devices are meant to
> > be used if there can be only one instance. If the case where there are
> > multiple omapdrm devices is rather theoretical, or only used for certai=
n
> > debugging scenarios or such, I think having the id as -1 in the mainlin=
e
> > is cleaner.
>=20
> well, I don't care much one way or another, but need to check if there
> is a small patch needed in drm core code that generates the bus-id for
> .id =3D -1..

Hmm, why does the drm core care about it?

And generally, I think if the bus id is -1, there is no bus id in a
sense. For example, with bus id 0 you'll get a device "omapdrm.0". With
bus id -1 you'll get a device "omapdrm".

> >> >> +arch_initcall(omap_init_gpu);
> >> >> +
> >> >> +void omapdrm_reserve_vram(void)
> >> >> +{
> >> >> +#ifdef CONFIG_CMA
> >> >> +     /*
> >> >> +      * Create private 32MiB contiguous memory area for omapdrm.0 =
device
> >> >> +      * TODO revisit size.. if uc/wc buffers are allocated from CM=
A pages
> >> >> +      * then the amount of memory we need goes up..
> >> >> +      */
> >> >> +     dma_declare_contiguous(&omap_drm_device.dev, 32 * SZ_1M, 0, 0=
);
> >> >
> >> > What does this actually do? Does it reserve the memory, i.e. it's no=
t
> >> > usable for others? If so, shouldn't there be a way for the user to
> >> > configure it?
> >>
> >> It can be re-used by others.. see http://lwn.net/Articles/479297/
> >
> > The link didn't tell much. I looked at the patches, and
> > dma_declare_contiguous allocates the memory with memblock_alloc. So is
> > that allocated memory available for any users? If so, why does the
> > function want a device pointer as an argument...
> >
> > Is the memory available for normal kmalloc, or only available via the
> > CMA functions? Surely there must be some downside to the above? =3D) An=
d
> > if so, it should be configurable. You could have a board with no displa=
y
> > at all, and you probably don't want to have 32MB allocated for DRM in
> > that case.
>=20
> Basically the short version is memory from a CMA carveout can be
> re-used for unpinnable memory.  Not kmalloc, but it can be used for
> anon userspace pages, for example.  Userspace needs memory too.

Okay, let me ask the other way. Is 32MB enough for everyone? Hardcoding
a value like that without any possibility to adjust it just sounds like
a rather bad thing.

 Tomi


--=-Kh+ELHS8OQiG3E7kro5V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPV02/AAoJEPo9qoy8lh71TOAP/i55JYm7sLDUqlPaJ8Kx/EUQ
TDGvX6V5BFNprm3jmAcd2Z1M7XWGoDLiEyd46NuWZdCPSSbFUhJD74NgzGQ6s9KW
vylCIQpFgLgwUaYqQZcbO5OTD+5Nekxq6ADOQzzo5w25VUSVcr3cU8HqNiUstN+z
7/H0QdPKZfs0CP1EdM9SuZaSf7bkhRia2TdC1yPa1Kzia5PJf40rjIil8STb4UKr
3rWDAbaMEaR1VqXv5R2qh6mlbyThXvp7nf+Se0QPSRcTz0mx5Og/4dgm426YRGQK
KsE3t6fx2s5qzrZiwTsUWgYsjDpxz+4HMZW9J8GlVC7sJ7yAvrIN0v6TomBzJj80
0wIMp3fAw5I1WW7GFAYPxnzsPDCpjgzmAKk4/S2G/hPyI7SxZzuacO6RQ7h40x60
lxnYrNz15nmSNeAcFd8oWrnCBKGiQWvUT4fe9/u4EIDOSWoGPgGZ1NhAGv6mzvXm
HSkC/7jucDnGkDS70ZP30Hqq8qN8BS6BAuDXTEMCm4qd/b5/num88uLZEMbRAocq
d3taEv3n6lqpQquRN7eueiaABhR7NTF1GmkyocgcPkTlHe06H2m7AAGnznAe3tqT
bZDLRgCpMwjHGUlydVn3SrSvi3sQPSKr99ydy7Xl5++z56Q8B4BIGnw0K50MwdH2
9V4QWYxC44//Fs7v2W3F
=X+Jv
-----END PGP SIGNATURE-----

--=-Kh+ELHS8OQiG3E7kro5V--

