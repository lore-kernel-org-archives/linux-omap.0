From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 15/15] drm/omap: Add infoframe & dvi/hdmi mode support
Date: Wed, 25 Jun 2014 14:29:21 +0300
Message-ID: <53AAB291.4000007@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com> <1403604240-16738-16-git-send-email-tomi.valkeinen@ti.com> <53AAAC95.3070409@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="jjSFIbvlMxRTGckRabHgJ7hFrHBeFgAeM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53114 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbaFYL3Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 07:29:24 -0400
In-Reply-To: <53AAAC95.3070409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Jyri Sarha <jsarha@ti.com>, Rob Clark <robdclark@gmail.com>

--jjSFIbvlMxRTGckRabHgJ7hFrHBeFgAeM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/14 14:03, Archit Taneja wrote:
> Hi,
>=20
> On Tuesday 24 June 2014 03:34 PM, Tomi Valkeinen wrote:
>> Make the omapdrm driver use the new HDMI ops when possible.
>>
>> omapdrm will call set_hdmi_mode (when available) to tell the encoder
>> driver whether the monitor is a DVI or HDMI monitor, and if it's an HD=
MI
>> monitor, omapdrm will call set_hdmi_infoframe to to set the AVI
>> infoframe.
>=20
> <snip>
>=20
>=20
>> @@ -89,6 +91,31 @@ static void omap_encoder_mode_set(struct
>> drm_encoder *encoder,
>>                   struct drm_display_mode *mode,
>>                   struct drm_display_mode *adjusted_mode)
>>   {
>> +    struct drm_device *dev =3D encoder->dev;
>> +    struct omap_encoder *omap_encoder =3D to_omap_encoder(encoder);
>> +    struct omap_dss_device *dssdev =3D omap_encoder->dssdev;
>> +    struct drm_connector *connector;
>> +    bool hdmi_mode;
>> +    int r;
>> +
>> +    hdmi_mode =3D false;
>> +    list_for_each_entry(connector, &dev->mode_config.connector_list,
>> head) {
>> +        if (connector->encoder =3D=3D encoder) {
>> +            hdmi_mode =3D omap_connector_get_hdmi_mode(connector);
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (dssdev->driver->set_hdmi_mode)
>> +        dssdev->driver->set_hdmi_mode(dssdev, hdmi_mode);
>=20
> When a HDMI monitor is replaced with a DVI one, we call the
> set_hdmi_mode() driver op to set the mode to DVI. But we don't call
> set_hdmi_infoframe() when the mode is set back to DVI. Do we need to se=
t
> avi infoframe registers back to a default value, or are those registers=

> just ignored in DVI mode?

If I'm not mistaken, infoframes are a HDMI thing. When in DVI mode, the
device driver should clear/disable/something the infoframe registers,
depending on the HW in question.

 Tomi



--jjSFIbvlMxRTGckRabHgJ7hFrHBeFgAeM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqrKRAAoJEPo9qoy8lh719UMP/jE+lZUgdEBzUWZtYeQrrmww
ZCN0n6OOznvDmhz/fUL6hgjZQKLGZ6X/tpnIAjLwxyAz+Va44Wi1IGT1tvaPBCO4
Vn5XDBX4z0XQobVP6vEyiF/iVmOuHv7Tctz24juArZ/83OlkbZhPc2Cq2Y0svmS0
dClirgbyTCzpsYbe/2JlEAteqckY5Hle60tfpUwuSEm9RIzpx4iTdMopH9RH/hnb
AKNPVEJ3rE98kwqfSLMC3fEPavbnzXAhtYp3fFEttXtYR80r1dQE03PSyyGF/PaA
ZT6W+aF8htuMeX5AqcJB5heP+muiJTtWW+XS+cLMhkzD1gKFQoBxN4/6nKfcB8z9
+6EUM7mpYIy87+MNGPuwBRNHTkWdTWzvHIiTcZD/Hy9A2CjqoJFbg5YhE89kCkhS
Ya6iRrAINGTRZqBHgXW4yChaZb7hV5LYTmG6e2V4SsyLjbbhtob6cebK2aTRjHaW
NJavIpnBOD1HpAF/9eVGFaQmeRBRoMoOKdgUFybUwM8uN+5zWKAq4LZsKl6+lRMK
4Bq22Moa50mfLoklDNecv2u6iMYsHJMSlJmu7zvy4DpBr9rdkZbo+VFUY/L3jw79
/5dVFjJoQtHYe6T8UZ00pLjqC8sYOgC/HL8jsMTWjVFYnDwQ4KDcykO/75uXgTDB
3AJNG0iMGjGErConEses
=97td
-----END PGP SIGNATURE-----

--jjSFIbvlMxRTGckRabHgJ7hFrHBeFgAeM--
