From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/20] OMAPDSS: DSI: fix DSI channel source initialization
Date: Mon, 11 Mar 2013 10:25:38 +0200
Message-ID: <513D9502.1090402@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-20-git-send-email-tomi.valkeinen@ti.com> <513D754A.4000607@ti.com> <513D8198.7070702@ti.com> <513D92A5.5050509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7D4A55CCA59833C086E71766"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45676 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab3CKIZl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 04:25:41 -0400
In-Reply-To: <513D92A5.5050509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig7D4A55CCA59833C086E71766
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-11 10:15, Archit Taneja wrote:
> On Monday 11 March 2013 12:32 PM, Tomi Valkeinen wrote:
>> On 2013-03-11 08:10, Archit Taneja wrote:
>>> Hi,
>>>
>>> On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
>>>> During the initialization of the DSI protocol registers, we always s=
et
>>>> the sources of all DSI channels to L4. However, we don't update the
>>>> value in the dsi_data, so we may end up with a different value in th=
e
>>>> register and in the dsi_data, leading to DSI problems.
>>>>
>>>> This patch fixes the issue by initializing also the channel source i=
n
>>>> the dsi_data.
>>>
>>> We set in omap_dsihw_probe:
>>>
>>> static int __init omap_dsihw_probe(struct platform_device *dsidev)
>>> {
>>>      ...
>>>      ...
>>>          /* DSI VCs initialization */
>>>          for (i =3D 0; i < ARRAY_SIZE(dsi->vc); i++) {
>>>                  dsi->vc[i].source =3D DSI_VC_SOURCE_L4;
>>>                  dsi->vc[i].dssdev =3D NULL;
>>>                  dsi->vc[i].vc_id =3D 0;
>>>          }
>>>      ...
>>>      ...
>>> }
>>
>> Hmm... I did have a bug related to this when prototyping CDF. Ah.
>> Consider this:
>>
>> Panel powers up and uses DSI normally. A DSI VC is set to video mode.
>> Then the panel power down. Then it powers up again, and enables DSI. A=
t
>> this time, dsi_vc_initial_config() is called again, setting the source=

>> in the registers to L4. But the source in dsi_data is still VP.
>=20
> Oh ok.
>=20
>>
>> So perhaps the whole piece of code from omap_dsihw_probe should be mov=
ed
>> to somewhere else (dsi_vc_initial_config() sounds like a good place), =
so
>> that they are initialized each time the registers are initialized.
>=20
> VC source is something which seems fine to do in
> dsi_vc_initial_config(). I'm not sure about the dssdev and vc_id fields=

> though, we would need to call omap_dsi_request_vc() and
> omap_dsi_set_vc_id() again after a power off. Currently, we do it only
> once in taal_probe().

Oh, right. Well, neither dssdev nor vc_id is written to registers, so
they won't have similar issues in any case. So I guess this patch is
fine as it is, and we do not need to touch dssdev nor vc_id.

 Tomi



--------------enig7D4A55CCA59833C086E71766
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPZUDAAoJEPo9qoy8lh71WQsQAJ+Jxj7F7PE0SqoPO/dyp7yP
sRy4PXjF7KTCn95Pnpl3M6X3IOGX4yDkWvs+QdnuamN5sf4PVMOTOlQxsEGD7JXm
hfmkvhOeLNq1sqd4QljuI0z3nu52v79lV1XUdiPIvQeA58XltlbIJpgmmSnQvJN0
RB0dnSc45LAcvEe18tpJVOdUqmwhFFkrDGJL1DyUddJK4U3sQ5nJgAdiBQ6pHCvO
SLXfQ9zGMaNda4pyq/qygCg9U9KGRyWFz8qN8SNHMCzpwhJlrTuM0gPN8OwW2Y7w
mIDDnwBgKXR/XGsPH4wKBTqOkooJdkJcKxZpkf/HeAdH51+xpqW/fSWaVPFCSXRE
tIStWt6EmIrwc+dlJqZazqW7g8a+1KaP1YXyprfJY03DJ5kf93dlgAlUcxfS8X0j
ApTOfNnWcZPA4kjeGdRWXuzMqCbjjCK/jgvlnnhJ+SkVo882DvsH1o0R1LX24aL/
9nKdvmN4gt5+9JE6um6hqCc5sDVrNOSvkGpeP7hKthtR9a0rTA2aHAJwtMBg6HwD
m88hVI9MGLLrxO2wGAGdxbZnfx8ywW3NjrTnMNJcJWU5cftViQoInGqFzq/40uhE
CmUc0SrnMUaQMHaB7GS8EYit3TE6nRWTrK3ABi7hyXZkRAgjnpy/pcknDxUFEYld
xEER8avw/MEzOhuYanbp
=T9ZR
-----END PGP SIGNATURE-----

--------------enig7D4A55CCA59833C086E71766--
