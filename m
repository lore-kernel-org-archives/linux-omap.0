From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/21] drm/omap: check CRTC color format earlier
Date: Mon, 2 Mar 2015 11:55:48 +0200
Message-ID: <54F433A4.5050303@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com> <1424956829-22892-7-git-send-email-tomi.valkeinen@ti.com> <20150227120757.GW24485@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9JtxkW8tAClAhetMPc10edTo5N1pv8csR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35868 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbbCBJzy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2015 04:55:54 -0500
In-Reply-To: <20150227120757.GW24485@phenom.ffwll.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

--9JtxkW8tAClAhetMPc10edTo5N1pv8csR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/02/15 14:07, Daniel Vetter wrote:
> On Thu, Feb 26, 2015 at 03:20:14PM +0200, Tomi Valkeinen wrote:
>> When setting a color format to a DRM plane, the DRM core checks whethe=
r
>> the format is supported by the HW. However, it seems that when setting=

>> the color format of a CRTC (i.e. a root plane), there's no checking
>> done. This causes omapdrm to configure omapdss with the bad color
>> format, which omapdss then rejects.
>>
>> While the above is ok, the error message is a bit confusing, and the
>> configuring of omapdss happens asynchronously from the ioctl that does=

>> the color format change.
>>
>> This patch adds a color format check to omap_plane_mode_set() which
>> causes the ioctl to return an error for invalid color format. This mea=
ns
>> that the userspace will get to know of the wrong setting, instead of t=
he
>> current behavior where the error is not seen by the userspace.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  drivers/gpu/drm/omapdrm/omap_plane.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/om=
apdrm/omap_plane.c
>> index 1f4f2b866379..bedd6f7af0f1 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_plane.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_plane.c
>> @@ -207,6 +207,24 @@ int omap_plane_mode_set(struct drm_plane *plane,
>>  {
>>  	struct omap_plane *omap_plane =3D to_omap_plane(plane);
>>  	struct omap_drm_window *win =3D &omap_plane->win;
>> +	int i;
>> +
>> +	/*
>> +	 * Check whether this plane supports the fb pixel format.
>> +	 * I don't think this should really be needed, but it looks like the=

>> +	 * drm core only checks the format for planes, not for the crtc. So
>> +	 * when setting the format for crtc, without this check we would
>> +	 * get an error later when trying to program the color format into t=
he
>> +	 * HW.
>> +	 */
>=20
> I think we should add a format check to the setcrtc ioctl if crtc->prim=
ary
> is set. Atm the code is in __setplane_internal but could easily be shar=
ed
> - there's already a copy in drm_atomi.c.
>=20
> Omapdrm wouldn't benefit from this yet since it doesn't support univers=
al
> planes. But adding universal planes should be on your todo anyway ;-)

Laurent is working on universal planes and atomic modesetting for
omapdrm. In fact, I think universal planes is already done in his WIP
branch.

So, if this check is already done with universal planes (if I understood
correctly), I'm fine with dropping this patch.

 Tomi



--9JtxkW8tAClAhetMPc10edTo5N1pv8csR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9DOkAAoJEPo9qoy8lh71cyEP/jamkp7m43eWM10Q/DG9sDnZ
r1L9UvW/aReLWvZLcX8lY+Vtsulsqh7X1iTNGVi5lCkgg2xTL9mfIG+tI6jNCWDH
HawPCV23/x/gdEMcV96LwkO2eRlNZXf4pHtHY0X8oaJzk2jmBEgOQXLmtFrieWgG
EA8NwEZmxeD6NkfaolLr8PcjIkX9tjhh3+MmdnthyiHto+6wM/YkAKNTZoiBFIpJ
wMWClRmZb8n9V8yMLrphypdHgxXoinuTTQQMIZZyty8MNdwj1OMHGK+RAYUU6gwY
gKS1aXJFvzpJMf2voa8YDtqa+a8ggHokeZF1BWO3aDCCBF7EteYzZPDMQXcAU9OJ
jVvl+hq7uWIctVyJXK4ubX/tNmOb1SOsuVO77PvP96dsAJ6eSgeI4q6NvvIhx6AK
FKisnm/FhAo74j6DbefBOYWOrC6hZPtaYFtzhmvtANyfBiw+9AVw1/7DfMHiY1OQ
jSVlel2VIPMWM4tfPMI4oyentSO21u64WyMcMlTGt145W13cTGE8Z15X8p6vHX1v
qr0Icy2dfBy+DU4M+MabTdpMEV49zcd2pSk7lMwA3DxcoJ6J06NahmNMmyzCXghI
5uVVlJjU913tLkFeiAl8ZuSgMkj4yz8rWQVe+PSm3Heo7N7io2e1DoP2KBmcx0y0
E7HxZQ8tl8vQUmXSYtnQ
=ndst
-----END PGP SIGNATURE-----

--9JtxkW8tAClAhetMPc10edTo5N1pv8csR--
