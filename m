From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/14] OMAPDSS: DSS: add new clock calculation code
Date: Wed, 20 Mar 2013 17:28:39 +0200
Message-ID: <5149D5A7.204@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com> <1362743569-10289-9-git-send-email-tomi.valkeinen@ti.com> <5149D30F.2010801@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8D2C8AA64E69F6487637CDFD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53124 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744Ab3CTP2l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 11:28:41 -0400
In-Reply-To: <5149D30F.2010801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig8D2C8AA64E69F6487637CDFD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-20 17:17, Archit Taneja wrote:
> On Friday 08 March 2013 05:22 PM, Tomi Valkeinen wrote:
>> Add new way to iterate over DSS clock divisors. dss_div_calc() provide=
s
>> a generic way to go over all the divisors, within given clock range.
>> dss_div_calc() will call a callback function for each divider set,
>> making the function reusable for all use cases.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/dss/dss.c |   36
>> ++++++++++++++++++++++++++++++++++++
>>   drivers/video/omap2/dss/dss.h |    3 +++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c
>> b/drivers/video/omap2/dss/dss.c
>> index 054c2a2..21a3dc8 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -473,6 +473,42 @@ int dss_calc_clock_rates(struct dss_clock_info
>> *cinfo)
>>       return 0;
>>   }
>>
>> +bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void=

>> *data)
>> +{
>> +    int fckd, fckd_start, fckd_stop;
>> +    unsigned long fck;
>> +    unsigned long fck_hw_max;
>> +    unsigned long fckd_hw_max;
>> +    unsigned long prate;
>> +
>> +    if (dss.dpll4_m4_ck =3D=3D NULL) {
>> +        /* XXX can we change the clock on omap2? */
>=20
> We can change dss_fclk1 on omap2, and the cclock2420_data.c and
> cclock2430_data.c have clksel structs which allow a set of dividers. Th=
e
> dividers are not continuous though, 1 to 12 and 16 are allowed. So we
> might need to change the code here a bit, if we want to change the cloc=
k
> in the first place.

Ok, good to know. Note that the comment is copied from the old code. I
think I tried changing the clock on N800 with clk_set_rate long ago, but
I didn't get it to work. Things might have changed, but, well, I don't
think we should spend time on omap2 code. I'm sure we'll get a patch if
somebody needs it =3D).

 Tomi



--------------enig8D2C8AA64E69F6487637CDFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRSdWnAAoJEPo9qoy8lh71ubwP+gPcyBBbnSbRmkA4YfVRntT4
uW6ZtKEwnaiHvg6qEA2Wi6qLJLPSdgkW2259bcDc9KCIVkSkOYa7n9mt4j0Upr1h
du4Raq/wYPxFLka2su7fBxPsRVb3jlg5jk5o8DP6J9x5nJx+3eDdG6xdQv7ajpmz
l0n9AdLuFephT4dDYeEqe26SgI9Hjozjvt+k/ERlbtdcY/XA6EsaiPhgT2vgxzNT
vC16HjNj9FIcH6SuNr/3R96uJ4+8v6JRT+1Uw9RsCVARDYQDhcHivdxn7ySem++5
tfQ/Fhri58kdk47Uf+YuJByUD9TSRRNkUjzLfrGSFS7JKT+SvtPSC7V+O+ynooy2
BFSvNsZcOwY5Iw9sfVpUktl18fAGkvP78dp0k0LIqykYhTjZKKVpGcod/FxW/E3Z
HxyYLf7XTEkcKit0e/zLkuTyTpJi4mOGbTxc+f0K/D4o6q89jSXykaz9jVXhULx+
n0Bos6W31tOn4mI0ORg2AvaP7UkeKFxMdRcDK34i2iKHl5dGnjkQsR7TKDO9hNWD
+o75B4yusKNvX/Riths5xCXU1O+TMnroG89KbUoXbiW2Tz6jjd5l2z+F3/vz9t+3
MKAUK+DoG6WEB787iC/GKxulaEm9Rp0yQ3etfSX31r+o693yqP0oEHXnqlsh88o7
t2L4p9BRdzY2gnyo+Uqk
=ZYyw
-----END PGP SIGNATURE-----

--------------enig8D2C8AA64E69F6487637CDFD--
