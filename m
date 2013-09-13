From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 12:48:17 +0300
Message-ID: <5232DF61.6000109@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-2-git-send-email-archit@ti.com> <5232D9C8.9020809@ti.com> <5232DCFE.5050700@ti.com> <5232DD53.3010706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ax8GtdpIQAcNC40aa4FBiswRNAECw5Nub"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5232DD53.3010706-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--ax8GtdpIQAcNC40aa4FBiswRNAECw5Nub
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/09/13 12:39, Archit Taneja wrote:
> On Friday 13 September 2013 03:08 PM, Archit Taneja wrote:
>> On Friday 13 September 2013 02:54 PM, Tomi Valkeinen wrote:
>>> On 13/09/13 12:14, Archit Taneja wrote:
>>>> Move omapdrm device creation inside the omap_display_init so that we=

>>>> can
>>>> correctly create the device based on the presence of omapdss.
>>>>
>>>> Originally worked on by Andy Gross.
>>>
>>> If the dmm device is present in the DT data, there is no need to crea=
te
>>> the dmm device. It's created automatically.
>>
>> Yes, that is done in a later patch.
>>
>>>
>>> Also, omapfb device is currently created the same way as omapdrm,
>>> independently of omapdss. Why is it a problem to have them like that?=

>>
>> In a multiplatform config, we might have CONFIG_DRM_OMAP and
>> CONFIG_DRM_OMAP_MODULE selected.
>=20
> I meant these configs might be selected even if the image is booted on
> am3xx platform.

Ah, I see. And the same omap_arch_initcall() is used for am3xxx also,
even if the DSS (and thus DRM) doesn't exist in the HW.

We have the same problem with omapfb, so it'd be good to include that in
the same series.

Hmm. If omap_generic_init() is called on am3xxx, it means we try to
create the dss stuff there also. It should fail to the DSS version
check, printing an error (at least I hope), but we really shouldn't even
call the dss init code on am3xxx.

I wonder how this should be fixed...

 Tomi



--ax8GtdpIQAcNC40aa4FBiswRNAECw5Nub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSMt9hAAoJEPo9qoy8lh71gNIQAKPmT3D+/ymLAK/lZ5RIHUjT
eILN7WkkDNmtc/dOAfYWHbtpJl9tBvrV/9YhyyRLe52QTF2umza6oLYtT/dfz+0v
oXS8PXnfnvQzw5+nkTr2jqJvac6cEVi09rcfiSV9nEZ21IDbRxUIAnzz5GKvdh7L
2bWutgvLCp9miqjTToL0Xd5nQLSyqQYL4skMlrqohYz79HmVucaQqYTe9GYvYltl
9D0goeUw8yBm9q8LdlSzjpsgY8KtS5D4x2Vm4Fg3exdXZJYaXrU/V9waiRkaEDYB
lwq2i96040BY8wDenLMiNeFMWy7MCqa7b0Zf9vMPMM8rSm0Bp1VXG+0IHXYU0zXU
5S3reAV1YDAA49WnEnlNQsAEL8Jzpn/TD6H74ZItdZPtXdy4f8azd/lduhrUGLcP
OFRk64enNyLdr4WUNJBrOgWZZJIjonV6z2bms4ojxFNq1EABoKFkocUpF4K2mL75
9wuHUQDm4ZIBNraOw435XkXPUSb7dQwpqquzJxH+BSXrt3g+0qjUsbrgK7qFKvq4
aWqRGPk1qwvymBcDwfBOItGZBh6yV3xuHEYuk02E8yhk55mXGm3ZHJ8Xijk+lA6v
UKNd5FS7xEIBSrwZVB031ZrtvyUAtl+aZhl37PcHubbvuXsgUklTgFMoEhL08lpI
qhkTQOTozJ9qVjh9xweV
=Yuxb
-----END PGP SIGNATURE-----

--ax8GtdpIQAcNC40aa4FBiswRNAECw5Nub--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
