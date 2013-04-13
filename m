From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: Latest randconfig build errors
Date: Sat, 13 Apr 2013 23:45:39 +0200
Message-ID: <20130413214539.GA32613@avionic-0098.mockup.avionic-design.de>
References: <20130304095136.GI17833@n2100.arm.linux.org.uk>
 <20130304184649.GO11806@atomide.com>
 <CAF6AEGv=3453KKS9-8YAgHrxMMbNvLMvt0pz-=qdG+zcd-Trrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGv=3453KKS9-8YAgHrxMMbNvLMvt0pz-=qdG+zcd-Trrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, arm@kernel.org, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2013 at 08:54:22AM -0400, Rob Clark wrote:
> On Mon, Mar 4, 2013 at 1:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> >> drivers/gpu/drm/tilcdc/tilcdc_slave.o:(.data+0x54): multiple definitio=
n of `__mod_of_device_table'
> >> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> >> drivers/gpu/drm/tilcdc/tilcdc_panel.o:(.data+0x54): multiple definitio=
n of `__mod_of_device_table'
> >> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> >> drivers/gpu/drm/tilcdc/tilcdc_drv.o:(.data+0x184): multiple definition=
 of `__mod_of_device_table'
> >> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> >
> > Rob, I assume you'll do a patch for this one?
>=20
>=20
> oh, I apologize for the late reply, I didn't see this email...
>=20
> There is a patch that we can merge to make tilcdc bool instead of
> tristate[1], which I suppose is ok for a temporary fix.  Although I'm
> all-ears if someone has a better idea about how to fix this.  The
> problem is that we have multiple sub-devices for different possible
> panel drivers, so that depending on DT tables, the correct ones get
> loaded for the hw.  But they are all built into a single module.
> Splitting them into multiple modules will be problematic, as panel
> drivers which are present really need to get probed before the
> toplevel drm device..

You could look at the Tegra driver. I had to solve a similar problem
there. What I did is basically parse the DT in the host1x driver and add
all device nodes which are required by DRM to a list. Later when the
individual devices are probed they are removed from that list, so that
when the list becomes empty we are sure that all required devices are
there and only then call the drm_platform_init() function.

This fits very well with how Tegra hardware is designed because host1x
is the parent for all DRM subdevices (DC, RGB/LVDS, HDMI, ...). So it is
probed before any of its children and it can easily parse the DT upfront
and initialize the list of required devices.

> I suppose in theory it is possible to make drm
> cope better with dynamically loaded outputs, but I'm not sure that
> there is any way to do this without breaking userspace which expects
> that all of the connectors/encoders are present once the drm device is
> loaded.

I had been thinking about this on and off for a while, but I haven't
come up with anything concrete. Ideally we could just have some kind of
event that userspace would listen for, so that new outputs can be
dynamically added and userspace informed about them. Last time I checked
most of the helpers assumed that the complete output configuration is
known when the DRM device is registered, so some major rework will be
required to efficiently make use of such dynamicity.

Thierry

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRadIDAAoJEN0jrNd/PrOhcRMP/iLNNmh/eHGZvavVqCkDHtV6
fWFh93PZJYuBgEUD0VqNjFRs8Hq39NpBgYqVdviK9xEiBhl8IRFx5Ml8hfZORG82
e3Ops6t9fxSwTUCy+cabXR+a1L1CZ2g6kB015xpvjYxLYf6GXTW04455ARY9ghqB
tvXqpoyGwTdUrMSGUKLv+VCk2diOudSXPlTrQj1JBXdLrAgr650jcYj+omczL2hy
Av3/7WUMyzemHqiXpOMReBilar5MJeXG3fXyLm0K21NtOs9ZtPktHMh5MtdyBJ/l
PaPk3v5xZvFBjW4jvw2jqPOZX9T3eqGEWQ1NgfrMpeE4+VH9kMN07PWDYFz/Xy0q
zM9jMYTsAJUF7lhDxWmcprxK15uuhCPhhStK83cNO3Jajb/O09cEmL4+qhghiDWI
rjNH8M5KMHv43kfm5Qzvh7zs2wQx+kbjUsR0Q3WaXgN4skny1il0H11ZX8FEBjd8
OsVw9xQS6QHxPL1QvBgKDeES8SHP4VpXR2bkU3RCE+G+SK4B+kN1yl/q+FEWxxHW
g3fmlXt3QmX6vwVfJRbP9LJpw+Shg63GVrAoa7jVV1LYoFDe1Ik/NA7j9GPlh9nC
pz3nUT6M7J03oYO/52hyklx87Y12JWaLfWHyz4m71tndKu4vejjKG4X4/n3ZCmWC
l68NeDeb5VQR1FjHHnc5
=IzKU
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
