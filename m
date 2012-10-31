From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/12] OMAPDSS: setup default dss fck
Date: Wed, 31 Oct 2012 09:32:35 +0200
Message-ID: <5090D413.7080800@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-9-git-send-email-tomi.valkeinen@ti.com> <5090C5B3.6020502@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16B174DEA18D97EADB8A6372"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab2JaHch (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 03:32:37 -0400
In-Reply-To: <5090C5B3.6020502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

--------------enig16B174DEA18D97EADB8A6372
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-31 08:31, Archit Taneja wrote:
> On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:
>> We don't currently set the dss fck when starting up. This is not a
>> problem, as we setup the fck later when configuring the pixel clocks. =
Or
>> this is how it was for omap2, for the rest of the omaps this may not b=
e
>> so.
>>
>> For DSI, HDMI and also for DPI when using DSI PLL, we don't need to
>> change the dss fck, and thus it may be left unconfigured. Usually the
>> dss fck is already setup fine by default, but we can't trust this.
>>
>> This patch sets the dss fck to maximum at probe time.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/dss/dss.c |   36
>> ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c
>> b/drivers/video/omap2/dss/dss.c
>> index 5affa86..034cc1a 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -485,6 +485,36 @@ unsigned long dss_get_dpll4_rate(void)
>>           return 0;
>>   }
>>
>> +static int dss_setup_default_clock(void)
>> +{
>> +    unsigned long max_dss_fck, prate;
>> +    unsigned fck_div;
>> +    struct dss_clock_info dss_cinfo =3D { 0 };
>> +    int r;
>> +
>> +    if (dss.dpll4_m4_ck =3D=3D NULL)
>> +        return 0;
>> +
>> +    max_dss_fck =3D dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
>> +
>> +    prate =3D dss_get_dpll4_rate();
>=20
> Not related to this patch, but maybe we could change the
> dss_get_dpll4_rate() name and dss.dpll4_m4_clk to something better.
> Maybe something like dss_fck_parent?

I agree. Or, even better, we should fix the omap clk data/code so that
we could set the dss fck, without this trickery. But I have no idea if
that's easy or difficult.

>> +
>> +    fck_div =3D DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
>> +            max_dss_fck);
>> +
>> +    dss_cinfo.fck_div =3D fck_div;
>> +
>> +    r =3D dss_calc_clock_rates(&dss_cinfo);
>> +    if (r)
>> +        return r;
>> +
>> +    r =3D dss_set_clock_div(&dss_cinfo);
>> +    if (r)
>> +        return r;
>> +
>> +    return 0;
>> +}
>> +
>>   int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info
>> *dss_cinfo,
>>           struct dispc_clock_info *dispc_cinfo)
>>   {
>> @@ -913,6 +943,10 @@ static int __init omap_dsshw_probe(struct
>> platform_device *pdev)
>>       dss.lcd_clk_source[0] =3D OMAP_DSS_CLK_SRC_FCK;
>>       dss.lcd_clk_source[1] =3D OMAP_DSS_CLK_SRC_FCK;
>>
>> +    r =3D dss_setup_default_clock();
>> +    if (r)
>> +        goto err_setup_clocks;
>=20
> Maybe it's safer to call this before we do a dss_runtime_get(). On
> OMAP4, DSS_FCLK is needed to access registers also. Changing it's rate
> might not be liked by the DSS HW. Also, it seems more logical to call i=
t
> after dss_get_clocks() in omap_dsshw_probe(), then we sort of group the=

> clock related stuff together.

Yes, good point. I don't think DSS has any problems with the clock
changing, as long as it's not outputting an image (but I'm not sure). In
any case, it makes sense to setup the clocks dss_get_clocks as you said.

 Tomi



--------------enig16B174DEA18D97EADB8A6372
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQkNQTAAoJEPo9qoy8lh718M4P/R5SmWfu4t7zVQB2fexEPi1h
7ce+pqD39u7LmaDXbp37mzt8MR9TkiEhej0Px+kY1cv6Qxi08DIYEunclkRMShoe
ZwkXSSGOsRQim62bSCu943qEWaQXATQMDiqG3VhN3HLWZQ6el4zBbksPJyfMSs8k
hDizzQRw9XuEl8BCM3apEZo5psb+XsybgeGPiSp/KK5ykCuEOoXBRQOp+r4IP8aI
si6pVaAqF9vRWZ33JDzyBbSrXwLhn4F5Dq52uHUr18mDLQbu+BzB+UO9ZBCcfu4C
u9HzGFwnIJR6dtjvpdJADduCM4kx8mT4DY3EH5ZiEhA1uMgXwQ6FGJN3sSm2luNt
/ft9FAM0dRxS7cTPjMViE2XOjFgu8vU+K7fTU1jQHHBtJazvrakGsR4kt1h3dPuy
e7sRsn6+EWLC8iHtYN3O4vogVsGxY28e6iett9z1aixFFXmPsTy8ocW577laPVmH
7bNqnQ/NSjO4Qk+T/WmEQzyx4oSmWpua+tEr9XRWrFzHNkm2ddtIYwFSZY/MCxck
d2v4E7rtsLPCbkwQENpBZmpbOe1Wg+FSXl0RXoxDvnTNYHOhAe6zn1sZ6yMcWQye
hUmi5T7EqZKOz8AWdADfohtWZUWnCPCW5IxfOi277MQoCCM67t3OAuaBcT4N/cbb
obsukrWqJpkyi4p/QPpS
=7NC5
-----END PGP SIGNATURE-----

--------------enig16B174DEA18D97EADB8A6372--
