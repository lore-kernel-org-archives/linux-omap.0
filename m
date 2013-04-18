From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: DPI: add dependency to DSI
Date: Thu, 18 Apr 2013 12:09:25 +0300
Message-ID: <516FB845.3070505@ti.com>
References: <516BDD35.4000807@ti.com> <1366274225.4085.44.camel@mars>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA531C6DE2CC8AD362DEE551E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54480 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755722Ab3DRJJa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Apr 2013 05:09:30 -0400
In-Reply-To: <1366274225.4085.44.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

--------------enigA531C6DE2CC8AD362DEE551E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-04-18 11:37, Christoph Fritz wrote:
> Hi Tomi
>=20
> On Mon, 2013-04-15 at 13:57 +0300, Tomi Valkeinen wrote:
>> Tomi Valkeinen (38):
>>       OMAPDSS: add fields to panels' platform data
>>       OMAPDSS: DSI: remove DSI & DISPC clk divisors from dssdev
>>       OMAPDSS: HDMI: remove HDMI clk divisors from dssdev
>>       OMAPDSS: DPI: remove omap_dss_device uses
>>       OMAPDSS: DSI: remove omap_dss_device uses
>>       OMAPDSS: Taal: remove multi-panel support
>>       OMAPDSS: APPLY: remove dssdev from dss_mgr_wait_for_vsync
>>       OMAPDSS: add missing export for omap_dss_get_output()
>>       OMAPDSS: HDMI: init output earlier
>>       OMAPDSS: add output->name
>>       OMAPDSS: add output->dispc_channel
>>       OMAPDSS: DSI: delay dispc initialization
>>       OMAPDSS: DSI: fix DSI channel source initialization
>>       OMAPDSS: Taal: remove rotate & mirror support
>>       OMAPDSS: DPI: fix dpi_get_dsidev() for omap5
>>       OMAPDSS: DISPC: store core clk rate
>>       OMAPDSS: DSI: fix wrong unsigned long long use
>>       OMAPDSS: DSI: simplify dsi configuration
>>       OMAPDSS: DSI: get line buffer size at probe
>>       OMAPDSS: DSI: add enum omap_dss_dsi_trans_mode
>>       OMAPDSS: DSI remove unneeded clk source setup code
>>       OMAPDSS: DISPC: add new clock calculation code
>>       OMAPDSS: DSS: add new clock calculation code
>>       OMAPDSS: DSI: add new clock calculation code
>>       OMAPDSS: SDI: use new clock calculation code
>>       OMAPDSS: DPI: use new clock calculation code
>=20
> With linux-next this patch breaks compiling here because DPI now depend=
s
> on DSI - but my omap3 board here doesn't use DSI at all:
>=20
> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_calc_pll_cb=E2=80=
=99:
> drivers/video/omap2/dss/dpi.c:181: error: implicit declaration of funct=
ion =E2=80=98dsi_hsdiv_calc=E2=80=99
> drivers/video/omap2/dss/dpi.c: In function =E2=80=98dpi_dsi_clk_calc=E2=
=80=99:
> drivers/video/omap2/dss/dpi.c:201: error: implicit declaration of funct=
ion =E2=80=98dsi_get_pll_clkin=E2=80=99
> drivers/video/omap2/dss/dpi.c:212: error: implicit declaration of funct=
ion =E2=80=98dsi_pll_calc=E2=80=99
>=20
> Enabling OMAP2_DSS_DSI fixes this. This is my proposed patch. You may b=
e want to merge it?

Thanks for reporting this. We shouldn't make DPI depend on DSI. We
should make dummy functions for the above when DSI is not enabled so
that DPI compiles. I'll make a fix.

 Tomi



--------------enigA531C6DE2CC8AD362DEE551E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRb7hFAAoJEPo9qoy8lh71GRsP+gM0V2oprOv/JfMifD3tlSzq
rXBL8stAxe4OMBe70NykUXcbhexAmS2ol5ZuQ4mLsLIO4kMzWx30+rG0gfcbx3tx
A/WclcyikyR8J1dXjJeNrUKHOkc5ro4j2IGAVEBvxh0sc5hIjsO6fEUu9Y57CCCq
qL45sNiM9391YSaR4BSs9acgtG3rE+UMiBXn+YLIURXEog1ifFBKRSt2/SlV3l+G
S44yJABvDUG7YeyfN2wYm7RiX4g/avILu7hPxQG7nbCCaUtxLCSodYTcwYyAZU+J
WsdvDt1q9nidIgD+pqzhzRszNkK19tuosoagRIz4dCxFanLhc0/joulhZQTA3RxS
N0q2XJJ7aGdK69TOSPnWo00U8VkKsy1nUa3F9ifQmtyjmf28eT8wgg9XHTGlsEwH
cVeOfWBp/l41jUuwAIvDPpwusT+KP3qqrpF+XhEc81gTOt8t4LQVdeH+LLlxvUhr
RkVAhUMd7tgB+0qS1ZfsodPbS6NeQH5H0x9B6tBj0QkmwkAByCe3iIU5NZta+TLb
/3A+84me8of596HC5vqm6IOi8cDMnCyM4KeIELVEzTwbmFRyWxhQd4iatF8e8Ij8
Tm6XZyIQlz+poX2ul1wlw1W8/6MFKuGI4flHQawlEFU7+GAGG3dnz1RFVPTXTVvn
e1nODFEuX0wtA/WloA/e
=TrxP
-----END PGP SIGNATURE-----

--------------enigA531C6DE2CC8AD362DEE551E--
