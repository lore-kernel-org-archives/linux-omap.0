From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 10/14] dt: Add pd_size to AUXDATA structure
Date: Wed, 10 Aug 2011 07:16:30 -0600
Message-ID: <CACxGe6tq43M6x-pQS4CHTsjiNORLgMzWXL7Hn0GzTFMNCrRzAA@mail.gmail.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
 <1312897232-4792-11-git-send-email-manjugk@ti.com> <4E42723D.1010501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50314 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab1HJNQv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 09:16:51 -0400
Received: by vxi9 with SMTP id 9so797012vxi.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 06:16:50 -0700 (PDT)
In-Reply-To: <4E42723D.1010501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 10, 2011 at 5:57 AM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
>>
>> Add pd_size in the AUXDATA structure so that device drivers which re=
quire
>> platform_data size can pass along with AUXDATA.
>
> It is really needed by device driver? Or is it because omap_device_bu=
ild is
> using platform_device_add_data that is doing a copy of the pdata and =
thus
> require the size?

Yes, I have the same question.  What is the reason for needing the
platform data size?

g.

>
>> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
>> ---
>> =A0drivers/of/platform.c =A0 =A0 =A0 | =A0 =A02 ++
>> =A0include/linux/of_platform.h | =A0 =A05 +++++
>> =A02 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index ebbbf42..4b27286 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -565,6 +565,7 @@ static int of_platform_bus_create(struct device_=
node
>> *bus,
>> =A0 =A0 =A0 =A0struct platform_device *dev;
>> =A0 =A0 =A0 =A0const char *bus_id =3D NULL;
>> =A0 =A0 =A0 =A0void *platform_data =3D NULL;
>> + =A0 =A0 =A0 int pd_size;
>
> Maybe platform_data_size will be a little bit more consistent?
>
> Regards,
> Benoit
>
>> =A0 =A0 =A0 =A0int id =3D -1;
>> =A0 =A0 =A0 =A0int rc =3D 0;
>>
>> @@ -588,6 +589,7 @@ static int of_platform_bus_create(struct device_=
node
>> *bus,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus_id =3D auxdata->name;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0id =3D auxdata->id;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0platform_data =3D auxdata->platform_d=
ata;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd_size =3D auxdata->pd_size;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (of_device_is_compatible(bus, "arm,primecell")) {
>> diff --git a/include/linux/of_platform.h b/include/linux/of_platform=
=2Eh
>> index 252246c..a3be980 100644
>> --- a/include/linux/of_platform.h
>> +++ b/include/linux/of_platform.h
>> @@ -47,6 +47,7 @@ struct of_dev_auxdata {
>> =A0 =A0 =A0 =A0char *name;
>> =A0 =A0 =A0 =A0int id;
>> =A0 =A0 =A0 =A0void *platform_data;
>> + =A0 =A0 =A0 int pd_size;
>> =A0};
>>
>> =A0/* Macro to simplify populating a lookup table */
>> @@ -58,6 +59,10 @@ struct of_dev_auxdata {
>> =A0 =A0 =A0 =A0{ .compatible =3D _compat, .phys_addr =3D _phys, .nam=
e =3D _name, \
>> =A0 =A0 =A0 =A0 =A0.id =3D _id, .platform_data =3D _pdata }
>>
>> +#define OF_DEV_AUXDATA_ID_PDSIZE(_compat,_phys,_name,_id,_pdata,_pd=
_size)
>> \
>> + =A0 =A0 =A0 { .compatible =3D _compat, .phys_addr =3D _phys, .name=
 =3D _name, \
>> + =A0 =A0 =A0 =A0 .id =3D _id, .platform_data =3D _pdata, .pd_size =3D=
 _pd_size }
>> +
>> =A0/**
>> =A0 * of_platform_driver - Legacy of-aware driver for platform devic=
es.
>> =A0 *
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
