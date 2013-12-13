From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 16/26] ARM: omap4-sdp.dts: add display information
Date: Fri, 13 Dec 2013 11:39:26 +0200
Message-ID: <52AAD5CE.3010609@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-17-git-send-email-tomi.valkeinen@ti.com> <52AAD2F1.2040208@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="doTAsPL9kHxipSoNBJtGPBr03K4so2Jtw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55262 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab3LMJja (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Dec 2013 04:39:30 -0500
In-Reply-To: <52AAD2F1.2040208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--doTAsPL9kHxipSoNBJtGPBr03K4so2Jtw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-13 11:27, Archit Taneja wrote:
> On Wednesday 04 December 2013 05:58 PM, Tomi Valkeinen wrote:
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   arch/arm/boot/dts/omap4-sdp.dts | 91
>> +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 91 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap4-sdp.dts
>> b/arch/arm/boot/dts/omap4-sdp.dts
>> index 5fc3f43c5a81..e3048f849612 100644
>> --- a/arch/arm/boot/dts/omap4-sdp.dts
>> +++ b/arch/arm/boot/dts/omap4-sdp.dts
>> @@ -550,3 +550,94 @@
>>       mode =3D <3>;
>>       power =3D <50>;
>>   };
>> +
>> +&dsi1 {
>> +    vdds_dsi-supply =3D <&vcxio>;
>> +
>> +    dsi1_out_ep: endpoint {
>> +        remote-endpoint =3D <&lcd0_in>;
>> +        lanes =3D <0 1 2 3 4 5>;
>=20
> In the previous revision omapdss DT patchset, the lanes node was a
> member of the panel DT node, and not the dsi DT node. Any reason to
> change this? Does it make more sense this way?

Well, the lane configuration is programmed into the DSI HW. So DSI needs
to know them. Thus the lanes can be considered a property of the DSI.

In some cases, the external encoder or panel also needs to know about
the lanes. In that case, both DSI and the encoder/panel would contain
the same data.

My reasoning where a property belongs to:

If a property is clearly internal to a device, it belongs there. For
example, in this case vdds_dsi-supply is clearly a property of the DSI.

If a property is about the link between two devices, like "lanes" here,
it belongs to both devices. If a device does not need that data for
anything, it can be omitted.

> I suppose it's more suitable for dsi to hold the property if 2 panels
> are connected on the same bus. Say, one with 4 data lanes, and other
> with 2. It would be tricky for the dsi driver to get lane params from 2=

> different places and merge them somehow.

It doesn't matter, both would work fine. If the lanes property is in the
DSI node, then the DSI driver finds out the lane config by finding out
which endpoint is used for the panel that's being enabled.

If the lanes property would be in the panel, the panel would pass the
lane config to the DSI when it's enabled.

But I think passing the lane config from panel to DSI (like we do
currently) is not so nice.

>> +    };
>> +
>> +    lcd0: display@0 {
>> +        compatible =3D "tpo,taal", "panel-dsi-cm";
>> +
>> +        gpios =3D <&gpio4 6 0>;    /* 102, reset */
>> +
>> +        lcd0_in: endpoint {
>> +            remote-endpoint =3D <&dsi1_out_ep>;
>> +        };
>> +    };
>=20
> Is there a reason why lcd0 and lcd1 are children nodes of dsi1 and dsi2=

> respectively? I don't see this for panels on other boards.

Yes. The panels are _controlled_ with DSI. We model the child-parent
relationships in DT data based on the control. So an i2c peripheral is
controlled via i2c master, and is thus a child of the i2c master. Same
here. The ports/endpoints are used to define the data path, which is
separate thing from the control path.

DPI panels which don't have any way to control them (except basic things
like gpios) are platform devices without any parent.

If the DPI panel would be controlled with i2c, it'd be a child of an i2c
master.

 Tomi



--doTAsPL9kHxipSoNBJtGPBr03K4so2Jtw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqtXOAAoJEPo9qoy8lh71AjYP/AvsXdbXOOCBgFGSSpQtMV0d
s/mHQ9y5p1JI/5I9qo5BVv8Ze5EiJ0E9jw4o4Ho0yLHaKmBMbzpOg+UJ3yWnScjG
ZhdlFTUJSn1DIKH0V2FMDSHxuU/Id2g8rfV6f5MI2igpFIAFupo/A43tOEbgP6gG
oDU+UdS6Y0eCGFxUXvsV4uLdYKVgfAAAJh9nOirlf6GB3UZscc/By9nLCmIm0Gs3
HRibTq10Ao7gSucPkxoILOnZN+LBeaHK4KDdV0LMb2s/wiTFuLJVMX9O2QwYt79o
tsrWKy/oULJ+06G2T0mY7+gIyISnDWizRtmzZAv4jKXspELL3zvRVdE2vfmqjXQK
EbSWm6esgvnMFc6oSfqikVqu1YEqwm30PDywVbq7cKuAJBXGDy7hlJ0FylnbdsQ3
TlEudPElaYcOvQGk1dXJKa0gTs5k69uhpotLEUdxsY/oTLIatTpnm0bYI/mE8drW
bLBBxe/UK49InQoLu79Gfz7rZtWo6VI5a/2vgku3fI2uBXYnEVaK8cQcvLwA2HRv
fC4g97e+mQi+i0HCYIS+qXE9EO7GjFlv/bCqLeZxTFCmW9f6j5DaHbx0Dj2CP6Kq
udWaFs34U3EoGWSHmYHjHqyK8smeXwLtw0ZjvwMruX6GdVUYG5LDA6AK9cT3yzzr
eL6lBnvqrNnjhdA72Pgx
=uS9S
-----END PGP SIGNATURE-----

--doTAsPL9kHxipSoNBJtGPBr03K4so2Jtw--
