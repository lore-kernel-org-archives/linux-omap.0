From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/20] OMAPDSS: Resolve channels for outputs
Date: Mon, 11 Mar 2013 13:54:21 +0200
Message-ID: <513DC5ED.30208@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-11-git-send-email-tomi.valkeinen@ti.com> <513D716C.2050807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD1C4E12EF9B888A0FBB4D34B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38914 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886Ab3CKLyY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 07:54:24 -0400
In-Reply-To: <513D716C.2050807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigD1C4E12EF9B888A0FBB4D34B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-11 07:53, Archit Taneja wrote:
> On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
>> The DISPC channel used for each output is currently passed in panel
>> platform data from the board files.
>>
>> To simplify this, and to make the panel drivers less dependent on OMAP=
,
>> this patch changes omapdss to resolve the channel independently. The
>> channel is resolved based on the OMAP version and, in case of DSI, the=

>> DSI module id.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/dss/dpi.c  |   37 ++++++++++++++++++++++++++----=
-
>>   drivers/video/omap2/dss/dsi.c  |   48
>> ++++++++++++++++++++++++++++++++++++++++
>>   drivers/video/omap2/dss/rfbi.c |    2 ++
>>   drivers/video/omap2/dss/sdi.c  |    2 ++
>>   4 files changed, 84 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dpi.c
>> b/drivers/video/omap2/dss/dpi.c
>> index e282456..3261644 100644
>> --- a/drivers/video/omap2/dss/dpi.c
>> +++ b/drivers/video/omap2/dss/dpi.c
>> @@ -396,12 +396,44 @@ static int __init dpi_verify_dsi_pll(struct
>> platform_device *dsidev)
>>       return 0;
>>   }
>>
>> +/*
>> + * Return a hardcoded channel for the DPI output. This should work fo=
r
>> + * current use cases, but this can be later expanded to either resolv=
e
>> + * the channel in some more dynamic manner, or get the channel as a u=
ser
>> + * parameter.
>> + */
>> +static enum omap_channel dpi_get_channel(void)
>> +{
>> +    switch (omapdss_get_version()) {
>> +    case OMAPDSS_VER_OMAP24xx:
>> +    case OMAPDSS_VER_OMAP34xx_ES1:
>> +    case OMAPDSS_VER_OMAP34xx_ES3:
>> +    case OMAPDSS_VER_OMAP3630:
>> +    case OMAPDSS_VER_AM35xx:
>> +        return OMAP_DSS_CHANNEL_LCD;
>> +
>> +    case OMAPDSS_VER_OMAP4430_ES1:
>> +    case OMAPDSS_VER_OMAP4430_ES2:
>> +    case OMAPDSS_VER_OMAP4:
>> +        return OMAP_DSS_CHANNEL_LCD2;
>> +
>> +    case OMAPDSS_VER_OMAP5:
>> +        return OMAP_DSS_CHANNEL_LCD2;
>> +
>> +    default:
>> +        DSSWARN("unsupported DSS version\n");
>> +        return OMAP_DSS_CHANNEL_LCD;
>> +    }
>> +}
>=20
> I had another comment for this patch. On OMAP5, it makes sense for us t=
o
> not use LCD2 as the recommended channel. LCD2_CLK's only source is
> DSS_CLK from PRCM. So it's not a very flexible channel to use. We could=

> use LCD3 (at the cost of not using DSI2).

Ok. Yes, this looks to be the case. I'll use LCD3 for DPI for now. In
the worst case we may need to pass some channel setup parameters via
omapdss DT data or platform data, but I'd really much like the driver to
be able to resolve the dispc channels by itself...

> We also need to fix dpi_get_dsidev() for OMAP5. Currently, it assumes
> that LCD2_CLK can be sourced from DSI2 PLL, we need to ensure DPI has a=

> dsidev only if it's LCD1 or LCD3.

Right. I'll add if (OMAP5) there, and return DSI2 PLL for LCD3, and NULL
for LCD2.

 Tomi



--------------enigD1C4E12EF9B888A0FBB4D34B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPcXtAAoJEPo9qoy8lh714NMQAJl5MyDmPuWxvB0cLwCgOi0t
24XxhDjAILKuTGCBp9/OIkbgYa5tjBdyPvz32Gl5P6Pd0URQxXLkvlo3556B7Cb/
8uI8t+X7DH/b7MqCytz82LDtqrnpy7uxOnmdgaKNDYZWPPziqHVn5ceaQSY5tYgh
k6Jvg08nzHKvQ+flH6DIrNg7z78QKLuSp/Ojwbk5VYkuQwRL/tazO0Ie6NvjqEpz
HQG8hp0Ijl+P+Qj46/iDjohhw8ysrPsB3umGJRZCrf52HuOy6sKuOzUKbIsoQbGX
wDs2MJvJW/1sga7MwYKBzuWv2d0OM27C3UgxZddmK/XIWWjTQe6YXOo/QCfmgTAt
zQw18cnf2Ui97EOGJqTp2HDRmkEPQB0ukpf+DaYleG9G1B0zwL8i0T2iIm7Ldknh
/Z8pl3z1ZDvLc5gxLUi/5Xl9CaSIDUlDZFBN6wN+PHfXNPT58zDPXjhXTn7ICbbh
xK5THJ5EH4a/TlMP3UPnhXZzDmGUMjmbjrPXlNCNXeQNUL4v8eanSWxBa+BwFMHq
OJWakRC+h1GZVh7MlbFUkOhkOA/K3UstAI2hAZCtb9/G9ELznsvaPNnEXnCjqVdJ
NZE80rISmEzm5cqlmxgW0O/MB0U8+wdLyHhIgWpeF+UXOZoaZ7JCaL5etjJUtuxu
DNQhJF4ZB6GxD9w6Jh0L
=pvJj
-----END PGP SIGNATURE-----

--------------enigD1C4E12EF9B888A0FBB4D34B--
