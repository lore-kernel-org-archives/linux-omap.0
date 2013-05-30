From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 03/32] OMAPDSS: add omap_dss_find_output()
Date: Thu, 30 May 2013 19:54:39 +0300
Message-ID: <51A7844F.10406@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-4-git-send-email-tomi.valkeinen@ti.com> <20130530110707.GH19468@game.jcrosoft.org> <51A73A9A.8010801@ti.com> <20130530154055.GL19468@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2FPWPRNKQKIPVDVRBVRVK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60822 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab3E3Qym (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 12:54:42 -0400
In-Reply-To: <20130530154055.GL19468@game.jcrosoft.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

------enig2FPWPRNKQKIPVDVRBVRVK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/05/13 18:40, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:40 Thu 30 May     , Tomi Valkeinen wrote:
>> On 30/05/13 14:07, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
>>>> Add a support function to find a DSS output by given name. This is u=
sed
>>>> in later patches to link the panels to DSS outputs.
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>> ---
>>>>  drivers/video/omap2/dss/output.c | 13 +++++++++++++
>>>>  include/video/omapdss.h          |  1 +
>>>>  2 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/=
dss/output.c
>>>> index 5214df6..3274628 100644
>>>> --- a/drivers/video/omap2/dss/output.c
>>>> +++ b/drivers/video/omap2/dss/output.c
>>>> @@ -115,6 +115,19 @@ struct omap_dss_output *omap_dss_get_output(enu=
m omap_dss_output_id id)
>>>>  }
>>>>  EXPORT_SYMBOL(omap_dss_get_output);
>>> GPL please
>>
>> The omapdss driver uses EXPORT_SYMBOL. I don't want to start mixing bo=
th
>> EXPORT_SYMBOLs and EXPORT_SYMBOL_GPLs.
>=20
> I do not like EXPORT_SYMBOL at all
> I stringly prefer to switch all of them to _GPL
>=20
> but will not refuse the patch for this in this case

I have nothing against changing omapdss to use _GPL only. I've never
heard anyone using non-GPL panel drivers with omap.

Following these patch sets I can remove lots of the old code, which
contains the majority of the EXPORT_SYMBOLs in omapdss. I'll change
omapdss to use _GPL after that removal.

>>>> +struct omap_dss_output *omap_dss_find_output(const char *name)
>>>> +{
>>>> +	struct omap_dss_output *out;
>>>> +
>>>> +	list_for_each_entry(out, &output_list, list) {
>>>> +		if (strcmp(out->name, name) =3D=3D 0)
>>>> +			return out;
>>>> +	}
>>>> +
>>>> +	return NULL;
>>>> +}
>>> I this in so many drivers could we have a macro to generate such func=
tion?
>>
>> What would that help? Wouldn't it just increase the code size of the k=
ernel?
>=20
> increase no as it's not an inline function but a macro to generate the
> function
> after help yes but people may not like so as you wish

I don't think I understand what you mean then. What kind of macro are
you talking about?

 Tomi



------enig2FPWPRNKQKIPVDVRBVRVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRp4RPAAoJEPo9qoy8lh71AuIP/2Mo7I3LRt6MF2xUKGUvISER
Zu3+gcl9n72kzOdsAGBdHjHTuZqESjqrcbBuzS4KHH9k+CmnRtWQVBHbsKWtWf/d
8fILyb8ary5kXiOvA+T1Ae0rmaBfFKdSWDxw/NBrmDDo4m4xkbsUIEPWJFM9wdKl
uGTpfiBn0Qm7WeFsXXP/X4a8iuflCrYTR0obgw5Z8r1hV92aarhKYkWGSZoHuQwV
XWLHHzo5hopKZU+zNs9l2NlfKzcqXaHWG1qQa+0H5bIYTMg+b02IMEgtXbidxlDQ
j/ZneI4jVkg71L6Py8km+hILZttUJoUcDetLUMZ0BQZNF9o88LNimcU14Unhynk9
zGKBfpeEh20kstV13F2Sf0z/5/XfeqAwItcoJXICPTJlmRlEI8AnqZ9c39dhmKD2
OpgnNQv6sx8XV4W/BvdJws0xFy0xL+V4tVgSkPkecGmHu5YKPgOzJzvIGU3WdNy6
CH0hmVFoH69g65Vy04nr0O9m4kYh0QpucOrMN6/IAQAETydROH0mwDMnIM2+wyX/
2a0PoJfx+kfsHvVeV0ABADkpN1mq+rHmP97NCxDq+GD1peARsKgTe7NGAWOgd8Bj
aKzXVDrOTpeEusQayPYkGGjhNKJTX/rdu0PQFVWgC2rvrhPAHIvAzL5zYpfRoMdL
MaUY0N/J/Sbym88Okp/1
=3xoT
-----END PGP SIGNATURE-----

------enig2FPWPRNKQKIPVDVRBVRVK--
