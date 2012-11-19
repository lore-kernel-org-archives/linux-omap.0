From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: tfp410 and i2c_bus_num
Date: Mon, 19 Nov 2012 11:27:44 +0200
Message-ID: <20121119092744.GB4211@arwen.pp.htv.fi>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
 <20121116135155.GE18527@arwen.pp.htv.fi>
 <50A64D35.9050109@ti.com>
 <20121116151959.GA19411@arwen.pp.htv.fi>
 <50A65E40.9040208@ti.com>
 <20121116182146.GC20496@arwen.pp.htv.fi>
 <50A72390.3050509@ti.com>
 <20121118113437.GB30462@arwen.pp.htv.fi>
 <50A9D3DD.6040807@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50A9D3DD.6040807-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Mon, Nov 19, 2012 at 08:38:21AM +0200, Tomi Valkeinen wrote:
> (dropping Tony and stable)
>=20
> On 2012-11-18 13:34, Felipe Balbi wrote:
>=20
> > how are you toggling the gpio ? You said tfp410 isn't controlled at all
> > except for the power down gpio. Who provides the gpio ?
>=20
> It's a normal OMAP GPIO, going to TFP410. I use gpio_set_value() to
> set/unset it.

ok, fair enough.

> >> Well, it's not that simple. TFP410 manages hot plug detection of the
> >> HDMI cable (although not implemented currently), so the we'd need to
> >> convey that information to the i2c-edid somehow. Which, of course, is
> >> doable, but increases complexity.
> >=20
> > I'd say it would decrease it since you would have a single copy of
> > i2c-edid.c for DRM or DSS or any other panel/display framework.
>=20
> Well. Reading EDID via i2c is one or two i2c reads. There's nothing else
> to it.

still avoids duplication :-)

> If we had a separate, independent i2c-edid driver, we'd have to somehow
> link the i2c-edid driver and tfp410 (or whatever driver would handle the
> video link in that particular case) so that the i2c-edid driver would
> know about hotplug events. We would also need to link the drivers so
> that the edid can be associated with the video pipeline the tfp410 chip
> is part of, and to the particular slot in the pipeline where the tfp410 i=
s.

that should all be doable, just look at how v4l2 handles pipelining the
video data (all in userland though) and you'll see it's definitely
possible.

> I haven't tried writing such a driver, but it sounds much more complex
> to me than doing one or two i2c reads in the tfp410 driver.

until you have e.g. tfp999, tfp534, tfp678 (hypothetical device numbers,
they probably don't exist) which are all SW incompatible and you have to
duplicate i2c reads in all of them. Whereas if you had a dedicated
i2c-edid.c driver, you would only have to tell them where to get EDID
structure from.

Also, if you have systems with different panel interfaces, they will use
the same i2c-edid.c and just instantiate that class multiple times.

> >> Another thing is that even if in this case the i2c and EDID reading are
> >> separate from the actual video path, that may not be the case for other
> >> display solutions. We could have a DSI panel which reports its
> >> resolution via DSI bus, or we could have an external DSI-to-HDMI chip,
> >> which reads the EDID via i2c from the monitor, but reports them back to
> >> the SoC via DSI bus.
> >=20
> > In this last case we would see just the DSI, not the I2C bus, so it's
> > like I2C bus doesn't exist, so in fact we would have two possibilities:
> >=20
> > a) read EDID via I2C bus (standard HDMI)
> > b) read EDID via DSI.
>=20
> Right. And currently reading edid is done via read_edid call with
> omapdss, and the caller doesn't care if read_edid uses i2c or DSI, so it
> should just work.
>=20
> > b) doesn't exist today so we need to care about it until something like
> > what you say shows up in the market. Until then, we care for EDID over
> > I2C IMHO.
>=20
> There are chips such as I described, although not supported in the mainli=
ne.

fair enough.

> >> So we need a generic way to get the resolution information, and it mak=
es
> >> sense to have this in the components of the video path, not in a
> >> separate driver which is not part of the video path as such.
> >=20
> > But the I2C bus isn't part of the video path anyway. It's a completely
> > separate path which is dedicated to reading EDID. If you need a generic
>=20
> While reading EDID is totally separate from the video data itself, it is
> not separate from the hotplug status of the cable. And the EDID needs to
> be associated with the video path in question, of course.

yes, but that can't be done in another way right ? Try something like
having a EDID provider and an EDID consumer. The provider will be
i2c-edid.c or dvi-edid.c and the consumer will a generic layer which
tfp410 would use to request certain attributes from the EDID structure.

I think that would look a lot nicer as the underlying implementation for
requesting EDID would be completely encapsulated from its users.

> > way for that case you wanna cope with other methods for reading EDID,
> > then you need a generic layer which doesn't care if it's I2C or DSI.
> > Currently implementation is hardcoded to I2C anyway.
>=20
> No, reading edid is done via generic read_edid call. TFP410 uses i2c to
> read edid, but it could do it in any way it wants.

it's not very well designed, then, if tfp410 still needs to fetch the
i2c adapter. It still has to know about the underlying bus for reading
EDID.

> > In fact current implementation is far worse than having an extra
> > i2c-edid.c driver because it doesn't encapsulate EDID implementation
> > from tfp410.
> >=20
> > Then moment you need to read EDID via DSI, you will likely have to pass
> > a DSI handle to e.g. TFP410 so it can read EDID via DSI.
>=20
> TFP410 is a parallel RGB to DVI chip. It's not related to DSI. The DSI
> case would be with some other chip.

it doesn't change what I said, however. Another chip will need to be
passed in a DVI handle.

> > What I'm suggesting, however, is that you have a layer hiding all that.
> > Make your i2c-edid.c driver read EDID and report it to this generic
> > layer, if some other driver in kernel needs the information, you should
> > be calling into this generic edid layer to get the cached values.
> >=20
> > If you don't need that data in kernel, then just expose it through a set
> > of standard sysfs files and teach Xorg about those.
>=20
> We need the data in the kernel.
>=20
> >> And while the above issues could perhaps be solved, all we do is read
> >> one or two 128 byte datablocks from the i2c device. I'm not sure if the
> >> extra complexity is worth it. At least it's not on the top of my todo
> >=20
> > When you have EDID over DSI, what will you do ?
>=20
> Write the code to read the EDID =3D). How that is done in practice depends
> on the chip in question, using chip specific DSI commands.

fair enough

> >> list as long as the current solution works =3D).
> >=20
> > that's your choice.
> >=20
> >>> If you have a generic i2c-edid.c simple driver, I guess X could be
> >>> changes to read those values from sysfs and take actions based on tho=
se.
> >>
> >> We handle the EDID inside the kernel, although I'm not sure if drm also
> >> exposes the EDID to userspace.
> >=20
> > I suppose it does, but haven't looked through the code.
> >=20
> >>> Looks like even drm_edid.c should change, btw.
> >>
> >> Yes, DRM handles it in somewhat similar way.
> >=20
> > another reason to make a generic i2c-edid.c. It make no sense to have
> > two pieces of code doing exactly the same thing, which is reading edid
> > over an I2C link.
>=20
> We could have a library with the code that does the one or two i2c
> reads. And while I think it'd be good, we're talking about one or two
> i2c reads. It wouldn't be a huge improvement.

fair enough... it looks like this is going nowhere, so best we come back
to this later. No reason to block your patch.

cheers

--=20
balbi

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqfuQAAoJEIaOsuA1yqREL7UP/3rZIdTmVWiatNw9PWzfsLwU
4oqYY6v+wwb49k9f7RaUAOgpjVrajhq4bvRzCcPTFAGn0PkAv0OsPC81zjR9ZHne
HsUGx9Dsp5EOPjPawW05nM3cJK7/mTJJJpquTuDXM2QDkRfQctu0TE1W6yRfolLB
k0I8ZSyxFKHg974UhhmymjKyXKD1HuXYLGIyP8e2jRF2HotPX2F5QKE+SuuJWrUK
VRObWlP3FF5aAEQEvChEDTZYWdD7UCZoyOsNE622DZ45GGXaSVNYgBD/cH0+G/EV
M+1zhornUiu0qnLbNUO60YG+e2jNC1jz4+hvdT3h1R55+mY2EgfHfAeUkHEaYD9l
3bSGj7tstYu79czBVfikwAax/PMTY+/BTtG/DfxXR3rKlbuImbYXUx09BRX9YJRY
hWv4iA6pENyZhrdkbmDi2lf5/c3dMsAhxA90FsR/oVQd65S3kZHaX0Y9qcuDj7qz
9hC3UPXzIeR58G68jSgM8DAiucGn/uFYiqf10kMPlo4NkwTyl4Sd7nSkk3+gMT9M
i4TjoijyrFfCdGKS7Vl5i0Hu2FRW4gaDdC9DP/C06EY+mRaq4qJZ/9rTZU0bzLE4
66PW5T5jfhVRkq67N8U1pRvUIha1yzFBJ5lYApYdFaoYvFElRsZKBXFk+CCFiK1m
oAV+98YkoDJcg49kagYR
=0iNB
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
