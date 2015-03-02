From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 09/21] drm/omap: handle mismatching color format and buffer
 width
Date: Mon, 2 Mar 2015 11:50:35 +0200
Message-ID: <54F4326B.6040209@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>	<1424956829-22892-10-git-send-email-tomi.valkeinen@ti.com>	<20150227130158.GX24485@phenom.ffwll.local> <CAPj87rP4675D9WY8eGUPCePcx7Oi+faYs5K4B_BGtyh1H4RmJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ktXkBgmDVlWSs6di3Ub5fl6mLHCpcIQCv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35679 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbCBJuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2015 04:50:44 -0500
In-Reply-To: <CAPj87rP4675D9WY8eGUPCePcx7Oi+faYs5K4B_BGtyh1H4RmJA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Stone <daniel@fooishbar.org>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>

--ktXkBgmDVlWSs6di3Ub5fl6mLHCpcIQCv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27/02/15 16:40, Daniel Stone wrote:
> Hi,
>=20
> On 27 February 2015 at 13:01, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Thu, Feb 26, 2015 at 03:20:17PM +0200, Tomi Valkeinen wrote:
>>> omapdrm doesn't check if the width of the framebuffer and the color
>=20
> s/width/pitch/
>=20
>>> format's bits-per-pixel match.
>=20
> s/match/are compatible/
>=20
>>> For example, using a display with a width of 1280, and a buffer
>>> allocated with using 32 bits per pixel (i.e. 1280*4 =3D 5120 bytes), =
with
>=20
> Might be clearer to say 'i.e. byte stride of ...', and also s/with usin=
g/for/.

Above you said pitch, here you say stride. They are the same thing, right=
?

>>> a 24 bits per pixel color format, leads to the following mismatch:
>>> 5120/3 =3D 1706.666... bytes. This causes bad colors and a tilt on th=
e
>=20
> s/bytes/pixels/
>=20
>>> screen.
>>>
>>> Add a check into omapdrm to return an error if the user tries to use
>>> such a combination.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>  drivers/gpu/drm/omapdrm/omap_fb.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omap=
drm/omap_fb.c
>>> index 2975096abdf5..bf98580223d0 100644
>>> --- a/drivers/gpu/drm/omapdrm/omap_fb.c
>>> +++ b/drivers/gpu/drm/omapdrm/omap_fb.c
>>> @@ -463,6 +463,14 @@ struct drm_framebuffer *omap_framebuffer_init(st=
ruct drm_device *dev,
>>>                       goto fail;
>>>               }
>>>
>>> +             if (mode_cmd->width % format->planes[i].stride_bpp !=3D=
 0) {
>>
>> width is in pixels. No idea what you're trying to check here, but this=

>> probably isn't it.

Yep, I don't know what I was smoking when writing the patch...

> stride_bpp is very misnamed: it is the bits per pixel for that plane,
> and not stride at all. I think the check should in fact be be (pitch %

I don't know why Rob named it like that. "The bpp of the stride"? Shrug.

> format->planes[i].stride_bpp), which would achieve the desired result,
> i.e. that the stride can be expressed as an integer number of pixels.

Yes, that looks correct.

>> Also drm checks that things fit into the specified pitch (which is in
>> bytes), see the pichtes[i] < width * cpp check in framebuffer_check.
>=20
> This isn't that check. At some stages, OMAP IIRC requires pitch to be
> specified in pixels rather than bytes, so this makes sure that's
> possible to express.

Right, that's what this patch was trying to achieve.

However... After thinking about this and going through some of the DISPC
code, I think that's not a strict requirement. We do calculate all the
configs using pixels as units, so at the moment the stride has to be an
integer number of pixels. But the hardware actually takes the row-inc
and pix-inc as bytes.

That said, the HW supports features like rotation and whatnot, and it
was not clear with a quick study if there are corner cases where the
hardware also requires the stride to be an integer number of pixels.
Also, the HW documentation only talks about pixels in this context, even
if the final value written to the registers is in bytes. I don't know if
that's just to make the documentation simpler, or if there's some
reasoning to only use pixel units.

So I think for the time being I'll just fix this patch, and look at the
possibility of allowing any stride size in the future.

Thanks for the review!

 Tomi



--ktXkBgmDVlWSs6di3Ub5fl6mLHCpcIQCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9DJrAAoJEPo9qoy8lh71XhEP/RYV+JwNDErbKtJ61ML3Zb/e
0GkCmsoca2xPeava+NXTRZsSI6bvbMS6xjmylELRHMPQ64bcuJM5P/iloUSaqBeC
3K/bi9HVZi0MudIdsIs6PiNx791D+avSfGEQ1uvD0ojBnCsnx0PqGuwvHwoF4k4M
5fXbA8taBB5+4YW0Tdrc7uthcf6R9PvbhB/i4OIBSSTZbQtERXk9wOb2iOm5WWtF
j5t7ain13hLRr54lsaBBwUI5pKrYLctrTuuBPXu1dr/Vub4iuhrymTd/ygJjNQqk
+daU0A+oMaGIg+VElRQjf8l0g9Wp/s0+LX9DSAk04r68Au1U5ehu0AdcZo3/rHBA
YYx42i/vMQ6p1nLg8aT83VEM3k5Fq8vJUV4k2tpZY06BDAXcc1LHImMbfiGDQNI0
036GTtKFoBqXDYMvtyi3GqhZgj7/ObtoEHBglOte9VP6PVo0ARneNGzC8l69YKh9
+B6k8laCrb87rY1sKMDlV1FcPsfbq4z0R2w7WGy3kRFnH+tN/Z+Z8A6c7eYWpW7+
UYXsj5m3khTp2uQa7cFEZHuSj19xmNGeibmxkukrJXhZfGO0kh+0woRLHCVmfwof
ApXHDrdRs4sq5kmKVhmVMFGhvUOwiC1WLMtNJoTrNWhRJNYL21T5d1eMB/6KTuEO
fjdyQi3oG46Brok2R6xL
=9JPI
-----END PGP SIGNATURE-----

--ktXkBgmDVlWSs6di3Ub5fl6mLHCpcIQCv--
