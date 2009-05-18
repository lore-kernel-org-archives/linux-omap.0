From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 1/3] omap3-iommu: reorganize
Date: Mon, 18 May 2009 15:59:42 +0300
Message-ID: <94a0d4530905180559k4b3e13e9xd947ae8cb8849b66@mail.gmail.com>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
	 <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com>
	 <20090518120717.GA3067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:32710 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbZERM7n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 08:59:43 -0400
Received: by fg-out-1718.google.com with SMTP id d23so612946fga.17
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 05:59:43 -0700 (PDT)
In-Reply-To: <20090518120717.GA3067@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, Felipe Contreras <felipe.contreras@nokia.com>

On Mon, May 18, 2009 at 3:07 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, May 16, 2009 at 01:05:48PM +0300, Felipe Contreras wrote:
>> +struct iommu_device {
>> + =C2=A0 =C2=A0 resource_size_t base;
>> + =C2=A0 =C2=A0 resource_size_t irq;
>> + =C2=A0 =C2=A0 struct iommu_platform_data pdata;
>> + =C2=A0 =C2=A0 struct resource res[2];
>> =C2=A0};
>
> The data which is needed per device is:
>
> - base address
> - IRQ (no need for this to be resource_size_t - int will do)
> - platform data
>
> There's no need for that res[2] being there.

Right, I was using 'res' but not any more; I forgot to remove it.

So resource_size_t is ok for 'base'?

>> @@ -63,23 +51,35 @@ static int __init omap3_iommu_init(void)
>>
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < NR_IOMMU_DEVICES; i++) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct platform_dev=
ice *pdev;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct iommu_devic=
e *d =3D &devices[i];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct resource res[] =3D=
 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 { .flags =3D IORESOURCE_MEM },
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 { .flags =3D IORESOURCE_IRQ },
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };
>
> This initialization doesn't buy you anything, in fact quite the oppos=
ite.
> The compiler actually interprets this as:
>
> static struct resource __initial_res[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .flags =3D IORESOURCE_MEM },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .flags =3D IORESOURCE_IRQ },
> };
> ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct resourc=
e res[...];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(res, __=
initial_res, sizeof(__initial_res));
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res[0].start =3D d->base=
;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res[0].end =3D d->base +=
 MMU_REG_SIZE - 1;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res[1].start =3D d->irq;
>
> It would be far better to initialize the flags element here for both.
> And please also set res[1].end as I did in my patch.

I think I saw that res initialization somewhere and I found it much
easier to read.

Ok. Will do.

>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D platform_device_=
add_resources(pdev, res, ARRAY_SIZE(res));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err_out;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D platform_device_=
add_data(pdev, &omap3_iommu_pdata[i],
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sizeof(omap3_iommu_pdata[0]));
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D platform_device_=
add_data(pdev, &d->pdata, sizeof(d->pdata));
>
> This will fail checkpatch.

I'll make sure it passes.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
