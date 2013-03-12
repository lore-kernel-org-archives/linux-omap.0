From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] omapdss: features: fixed supported outputs for OMAP4
Date: Tue, 12 Mar 2013 12:38:24 +0200
Message-ID: <513F05A0.6040204@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1362493070-17706-5-git-send-email-archit@ti.com> <513DCE08.20404@ti.com> <513EC63A.5060707@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig61DCBDF9ADB9176FA559F94D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41503 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3CLKib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 06:38:31 -0400
In-Reply-To: <513EC63A.5060707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enig61DCBDF9ADB9176FA559F94D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-12 08:07, Archit Taneja wrote:
> On Monday 11 March 2013 05:58 PM, Tomi Valkeinen wrote:
>> On 2013-03-05 16:17, Archit Taneja wrote:
>>> The support outputs struct for overlay managers is incorrect for
>>> OMAP4. Make
>>> these changes:
>>>
>>> - DPI isn't supported via the LCD1 overlay manager, remove DPI as a
>>> supported
>>>    output.
>>> - the TV manager can suppport DPI, but the omapdss driver doesn't
>>> support that
>>>    yet, we require some muxing at the DSS level, and we also need to
>>> configure
>>>    the hdmi pll in the DPI driver so that the TV manager has a pixel
>>> clock. We
>>>    don't support that yet.
>>>
>>> Signed-off-by: Archit Taneja <archit@ti.com>
>>> ---
>>>   drivers/video/omap2/dss/dss_features.c |    6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/video/omap2/dss/dss_features.c
>>> b/drivers/video/omap2/dss/dss_features.c
>>> index d7d66ef..7f791ae 100644
>>> --- a/drivers/video/omap2/dss/dss_features.c
>>> +++ b/drivers/video/omap2/dss/dss_features.c
>>> @@ -202,12 +202,10 @@ static const enum omap_dss_output_id
>>> omap3630_dss_supported_outputs[] =3D {
>>>
>>>   static const enum omap_dss_output_id omap4_dss_supported_outputs[] =
=3D {
>>>       /* OMAP_DSS_CHANNEL_LCD */
>>> -    OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
>>> -    OMAP_DSS_OUTPUT_DSI1,
>>> +    OMAP_DSS_OUTPUT_DBI | OMAP_DSS_OUTPUT_DSI1,
>>>
>>>       /* OMAP_DSS_CHANNEL_DIGIT */
>>> -    OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI |
>>> -    OMAP_DSS_OUTPUT_DPI,
>>> +    OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI,
>>>
>>>       /* OMAP_DSS_CHANNEL_LCD2 */
>>>       OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
>>>
>>
>> Thanks, I'll apply this to omapdss fixes branch.
>=20
> Hi, just one point here, this patch is a prerequisite for the patch 2/4=

> in this series. So we need to make sure that the 2/4 patch is not
> without this one in a kernel.
>=20
> Tomi,
>=20
> About patch '2/4', could you have a look at it too? It basically tries
> to do a dynamic assignment of channels to outputs. I worked on this
> before you posted the misc series with recommended_channel for outputs.=

> This patch tries to figure out managers with supported_outputs. It isn'=
t
> the most optimal way, as it can't back track and chose a better manager=
,
> but it still seems to do a reasonable job.
>=20
> We could also use the recommended channel way for omapdrm, I can't
> figure out what's the better approach at the moment.

Hmm, I think it'd be safer to use the recommended channel from omapdss
for now. The current omapdss code doesn't really let you use any other
channel than the recommended one (which was thus renamed to
dispc_channel in my later version).

Or does your patch do a better job at selecting the outputs (I'm mostly
thinking about OMAP5 here, which has a bit more conflicts with the mgrs
and outputs than earlier omaps).

But at some point I think we should fix those issues, and let omapdrm
decide how to connect the managers and outputs.

 Tomi



--------------enig61DCBDF9ADB9176FA559F94D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPwWjAAoJEPo9qoy8lh71KHUQAIKbWv8lIttyFk2XiNaYR3+U
ITziP9xAZs4sXOK9K8bM7M2Pkhxg3TgPsCxtG0zgCO6SM0ZM8vrVC3CL/huETUSD
5rg5oTZ2BN2Pa6cy4iGqGmRnsKirm/CdjUasGHAM1GYl+oL3ONVpqPwvT19OseaE
jdrsAmydlTOFDzbCD8HDiq/Ydprh6UeDSaWUEHtLVmCskmquuk92DQq5d3f/JbfK
W8838o+tLOL7z5ytvNYOue+saN+TuLuxMaIYwFCGdkiqY004oqGxyd1MUd0yCaX+
T1wXVS22MJLTaas7ZLNF4hgQFsVhikcF3HvoNRlw490r20XNg9qobuYOqzvFUq2w
8QvsOavygiJPRFy5XJeitsn0Bm7Mu90pJc54gHG25v16kMV+tJD6cJDpNZx63hAF
umo8/5+8HGUTy7zIBS4BaDLQjMvfTbHC5Vd+XTnoDuuj+V30pyIUICi0p+RguxNA
7YFLZvEV9CPcisbKtLmpjkg3A44QlrdWhVHmGwSI2+uihN+NwC0OWxMZ4FqrK6vh
39GkzUtMMwYFFIc3NSXRebEIzZdDlSo4j1A9gw0VHZ3e5T2v3ebZX6y50eWCx3kp
Ybkqe4f3i4i5MIyiAXSPy+yoPQostLcyY4bwtf5UdqlkDaJ5TRP8p+Toh5WMMwt6
UY8NlAyzkZn5JXsDxOVw
=n6n3
-----END PGP SIGNATURE-----

--------------enig61DCBDF9ADB9176FA559F94D--
