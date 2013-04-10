From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: use devm_clk_get()
Date: Wed, 10 Apr 2013 12:19:32 +0300
Message-ID: <51652EA4.9010606@ti.com>
References: <1365411346-30611-1-git-send-email-archit@ti.com> <51651F25.3020302@ti.com> <516524B8.60205@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE890E45D627680FC620A8D82"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57804 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab3DJJTe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 05:19:34 -0400
In-Reply-To: <516524B8.60205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigE890E45D627680FC620A8D82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-10 11:37, Archit Taneja wrote:
> On Wednesday 10 April 2013 01:43 PM, Tomi Valkeinen wrote:
>> On 2013-04-08 11:55, Archit Taneja wrote:
>>> Use devm_clk_get() instead of clk_get() for dss, and for outputs hdmi=

>>> and venc.
>>> This reduces reduces code and simplifies error handling.
>>>
>>> Signed-off-by: Archit Taneja <archit@ti.com>
>>> ---
>>>   drivers/video/omap2/dss/dss.c  |   18 +++---------------
>>>   drivers/video/omap2/dss/hdmi.c |   16 ++--------------
>>>   drivers/video/omap2/dss/venc.c |   10 +---------
>>>   3 files changed, 6 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/drivers/video/omap2/dss/dss.c
>>> b/drivers/video/omap2/dss/dss.c
>>> index 054c2a2..645b3bc 100644
>>> --- a/drivers/video/omap2/dss/dss.c
>>> +++ b/drivers/video/omap2/dss/dss.c
>>> @@ -767,13 +767,11 @@ int dss_dpi_select_source(enum omap_channel
>>> channel)
>>>   static int dss_get_clocks(void)
>>>   {
>>>       struct clk *clk;
>>> -    int r;
>>>
>>> -    clk =3D clk_get(&dss.pdev->dev, "fck");
>>> +    clk =3D devm_clk_get(&dss.pdev->dev, "fck");
>>>       if (IS_ERR(clk)) {
>>>           DSSERR("can't get clock fck\n");
>>> -        r =3D PTR_ERR(clk);
>>> -        goto err;
>>> +        return PTR_ERR(clk);
>>>       }
>>>
>>>       dss.dss_clk =3D clk;
>>> @@ -782,8 +780,7 @@ static int dss_get_clocks(void)
>>>           clk =3D clk_get(NULL, dss.feat->clk_name);
>>>           if (IS_ERR(clk)) {
>>>               DSSERR("Failed to get %s\n", dss.feat->clk_name);
>>> -            r =3D PTR_ERR(clk);
>>> -            goto err;
>>> +            return PTR_ERR(clk);
>>>           }
>>>       } else {
>>>           clk =3D NULL;
>>> @@ -792,21 +789,12 @@ static int dss_get_clocks(void)
>>>       dss.dpll4_m4_ck =3D clk;
>>>
>>>       return 0;
>>> -
>>> -err:
>>> -    if (dss.dss_clk)
>>> -        clk_put(dss.dss_clk);
>>> -    if (dss.dpll4_m4_ck)
>>> -        clk_put(dss.dpll4_m4_ck);
>>> -
>>> -    return r;
>>>   }
>>
>> Why didn't you use devm_clk_get for the dpll4_m4_ck clock also?
>=20
> clk_get of dpll4_m4_ck isn't tied to a device:
>=20
>     clk =3D clk_get(NULL, dss.feat->clk_name);
>=20
> We can't use devm_clk_get() if we don't tie it to a device, right?

Ah, true.

> I think the dss.dss_clk clock above is same as the dpll4_m4_ck for all
> OMAPs. We could probably remove the dpll4_m4_clk all together, and use
> dss_clk to get the rate of DSS_FCK coming from PRCM.

Hmm, no, if I recall right, dpll4_m4_clk is the parent of dss clock (or
parent of the parent of...), and the dss_fck_multiplier affects the
resulting dss fck. Or something like that. It's a bit messy, especially
as we can't just use the dss fck to change the rate, we need to change
the rate at the parent for some reason.

 Tomi



--------------enigE890E45D627680FC620A8D82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRZS6kAAoJEPo9qoy8lh71O7UP/RE2pkENSBENhLLihXmrztFf
ZtuypTbpJH98CkbbyKRN6ngReFN7qEKM7+1oKvYz6kMxujnIH6jhqg9yUsaicX9d
yfY3dOQNDZyJmU2RZp/g81TbVHux9Lz2wq1QmcEO6q2vi0Xwah7B+WqSHFqN6bl6
nSU8zX/Is8bTiPtW2A1P2XqLD02AxwqS/9b3K7dlPeDwP0pHbrFG71E3fxnhUd9E
ccIS1A6I7Dzo6GbJTb1jSO/1gy4lXnlt+25AEn5uQOkeq6UyswIh2JTXcqg3rzB6
FRgXBePas1CgDZxfpGNfcKE9Z5wpOLqkTFf5e5uJ1Crya4gaegV+3sSS8GuC7gnT
j00+N3OcyiCJ+cTCzI881Utl4grvCD63YzyegRG5TgUXYBe4hgiIsmRQPRPuQa6v
jyTdTCvoknGXPCVCIvNJCwDFnBehYp3gmcVaVC6ZUTP+zYXQMZC9nfcDWXK05f8T
mh6HrfYJkmIZdOS7UQt3+UvsmKJtZqmMNJBU3I8jWtxZnNCEv+HejLDIQUTo6bKn
IM307aXPkzqSzI7i12s+4JqGE7Z3V8ljhyKGV157jmWr7tb7wSgPGyvl29BLG+QG
aNb7SVaqDUvj0U7FDUZrXmZ1OGs1ERat3qT+v7weIUEhtLewzgwuu5LYyDk/8zAj
7wgIpkuIqyqQw4Y12eZC
=/vUF
-----END PGP SIGNATURE-----

--------------enigE890E45D627680FC620A8D82--
