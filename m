From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 5/6] usb: dwc3: core: don't access DMA bits directly
Date: Tue, 05 Apr 2016 08:52:43 +0300
Message-ID: <87vb3w4n6c.fsf@intel.com>
References: <1459585739-21204-1-git-send-email-felipe.balbi@linux.intel.com> <1459585739-21204-6-git-send-email-felipe.balbi@linux.intel.com> <570271C3.9030707@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570271C3.9030707-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Ivan T . Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:

> On 04/02/2016 11:28 AM, Felipe Balbi wrote:
>> instead of manually copying DMA bits from parent
>> device, we should let DMA API do its job.
>>=20
>> Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>   drivers/usb/dwc3/core.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 17fd81447c9f..d601de20e1cd 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -981,11 +981,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>=20=20=20
>>   	spin_lock_init(&dwc->lock);
>>=20=20=20
>> -	if (!dev->dma_mask) {
>> -		dev->dma_mask =3D dev->parent->dma_mask;
>> -		dev->dma_parms =3D dev->parent->dma_parms;
>
> Here, and in most of other patches you've dropped dma_parms copying -
> Is it expected?

I mentioned in cover letter that I don't know exactly what's the proper
way of dealing with dma_parms.

>> -		dma_set_coherent_mask(dev, dev->parent->coherent_dma_mask);
>> -	}
>> +	dma_coerce_mask_and_coherent(dev, dma_get_mask(dev->parent));
>
>
> No. Above if case should stay, otherwise, already valid, DMA configuratio=
n=20
> might be overwritten:

okay.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXA1KrAAoJEIaOsuA1yqREwIcP/igqbRGPV1ysVqWO+/RTSuw1
mXzHHGR2eAwNd5vVOiu6q5juvWJTpk7rBVLBkNyP8664hjabqKFos9FzFA7XrH0a
GJOXhOJvQ79qnzJC8kHaWJQi2PEP1bEQIggpa1D8N7M05z3gxvw9JDqIruZ2Y41A
c6WJ601xNrBPg5VkjaZZLoz++vnLS9YVxlaI09fBkZrSV5op/1k1vj/tb4+EPNI7
6TVoRzb83T8cyG2O3YrutvTyWj0Drlqlh7G1cHSbiIqRn/03N+5yOYPBYDqKhFct
oDVjxnUCY/Hpk8ACy/GBgs8WLFn7jjEq8mS2xQtkYNDT/ztPyJii5HzRI3gSGC9y
ceJVZyi/F5+obQ43CyPH5PghV+qlIsHqrk7YWsKOu4+wBvao1g4R/+tacXvY4t8x
42oyse7lz0j3k1nbeQ6FEKVC44EAesJlo581LMLlsoAELUyWwJOmF1WT2F4ONaSa
AV4fydFaYacaP5tixEd2vfpnTw4qebAE4I2vI8ezqWHJL1M06dVcD/DlAYJv4jG2
kMxQSsYMhXSX81+6mdelDRSc+8dZPv8wE1O4YRYa5FGCww9GchAGOVPT2Pz3ZtQt
q5QsgGIi5KyJczF+T/9YYQ5lyPxEygQ21x8mE3A/3Oqk+xBni/0CNzmVujDNqL6l
vC4t2bq3aLVf1kkK+OS4
=uDKY
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
