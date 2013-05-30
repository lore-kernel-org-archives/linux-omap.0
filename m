From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 03/32] OMAPDSS: add omap_dss_find_output()
Date: Thu, 30 May 2013 14:40:10 +0300
Message-ID: <51A73A9A.8010801@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-4-git-send-email-tomi.valkeinen@ti.com> <20130530110707.GH19468@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2GEQIIJPMEHWFVPGLCDUB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46023 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab3E3LkN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 07:40:13 -0400
In-Reply-To: <20130530110707.GH19468@game.jcrosoft.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

------enig2GEQIIJPMEHWFVPGLCDUB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/05/13 14:07, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
>> Add a support function to find a DSS output by given name. This is use=
d
>> in later patches to link the panels to DSS outputs.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  drivers/video/omap2/dss/output.c | 13 +++++++++++++
>>  include/video/omapdss.h          |  1 +
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/ds=
s/output.c
>> index 5214df6..3274628 100644
>> --- a/drivers/video/omap2/dss/output.c
>> +++ b/drivers/video/omap2/dss/output.c
>> @@ -115,6 +115,19 @@ struct omap_dss_output *omap_dss_get_output(enum =
omap_dss_output_id id)
>>  }
>>  EXPORT_SYMBOL(omap_dss_get_output);
> GPL please

The omapdss driver uses EXPORT_SYMBOL. I don't want to start mixing both
EXPORT_SYMBOLs and EXPORT_SYMBOL_GPLs.

>> +struct omap_dss_output *omap_dss_find_output(const char *name)
>> +{
>> +	struct omap_dss_output *out;
>> +
>> +	list_for_each_entry(out, &output_list, list) {
>> +		if (strcmp(out->name, name) =3D=3D 0)
>> +			return out;
>> +	}
>> +
>> +	return NULL;
>> +}
> I this in so many drivers could we have a macro to generate such functi=
on?

What would that help? Wouldn't it just increase the code size of the kern=
el?

 Tomi



------enig2GEQIIJPMEHWFVPGLCDUB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRpzqaAAoJEPo9qoy8lh71dF8P/AzhvXY/SzDGt66OlVRRnTmh
6BicGTRMeD2uubRclOmG9+NkkkDWARomLYglUmDAP4iMq+UiHaDG5m8cgNrGsKIZ
9RRjt/i3iEHv63UYdhKyrDkypo/bbDpe/cj+ZaLJhy2L/tOSIlF6xvw8Ca//0E+X
uEOO9asT9kquio1YjA3RBLMB4h4ZVP/d266zRlfLMg/UENjvpPjktHaq9D8nUcYc
+tyJSXnBipKCJCqd8xD0Aow6YRPBhfuzyMcWSfTMcelaCkvV+IxXxWpERcGsbbla
Rm39fc8A3Eijih2mhzLLU5BgPKL18leTU6Gx1HJc1SZqZA9VDTxDg4W7vZkrLdB6
Lnw2Xtg17hcxnM0tjFBdTzx2TOa5LvTx/O6F+FxsRCwRQ0FhJJvRsuVq8DYExpb8
FGg5xTFXXuw8JeC/JkC0JS5dNelsUqmWN9fUnjWfvEVWS+VK1t7br+oAlQvIJY0p
nbDDrh7LmTs8pprSX1q4U1mHdQrT+WdinE+qV/FE7vfr24SY08Y9Atgr1v6uv64B
eeTrdppSFQIjPh9WDl40T9psx9Q4oZdHdjCeGSBKFBLcYt2/eXpCnhMD2qpVXXc2
hJus+y2NjbQUmZbDMosqckP7ULAq6VG2xIytmWmV9L+SONs++kNlkbvDHvVYEMQp
0mvPgnqv+9kxxOTHNj3o
=Qk5x
-----END PGP SIGNATURE-----

------enig2GEQIIJPMEHWFVPGLCDUB--
