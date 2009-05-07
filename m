From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 1/3] omap3-iommu: reorganize
Date: Fri, 8 May 2009 01:16:00 +0300
Message-ID: <94a0d4530905071516qe7174a4g99586d76bcb96ed5@mail.gmail.com>
References: <94a0d4530905071302g3510fdabne659a42bd9009909@mail.gmail.com>
	 <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
	 <1241727069-15168-2-git-send-email-felipe.contreras@gmail.com>
	 <20090507211447.GA30906@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:45157 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760809AbZEGWQA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 18:16:00 -0400
Received: by fg-out-1718.google.com with SMTP id d23so14468fga.17
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2009 15:16:00 -0700 (PDT)
In-Reply-To: <20090507211447.GA30906@scadufax.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, Tony Lindgren <tony@atomide.com>

On Fri, May 8, 2009 at 12:14 AM, Felipe Balbi <felipe.balbi@nokia.com> =
wrote:
> On Thu, May 07, 2009 at 10:11:07PM +0200, ext Felipe Contreras wrote:
>> -static struct resource omap3_iommu_res[] =3D {
>> - =C2=A0 =C2=A0 { /* Camera ISP MMU */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D OMAP3_MMU1_BASE,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU1_BASE + MMU_REG_SIZE - 1,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D IORESOURCE_MEM,
>> - =C2=A0 =C2=A0 },
>> - =C2=A0 =C2=A0 {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D OMAP3_MMU1_IRQ,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D IORESOURCE_IRQ,
>> - =C2=A0 =C2=A0 },
>> - =C2=A0 =C2=A0 { /* IVA2.2 MMU */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D OMAP3_MMU2_BASE,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU2_BASE + MMU_REG_SIZE - 1,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D IORESOURCE_MEM,
>> - =C2=A0 =C2=A0 },
>> - =C2=A0 =C2=A0 {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D OMAP3_MMU2_IRQ,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D IORESOURCE_IRQ,
>> - =C2=A0 =C2=A0 },
>
> i find this one much more readable :-s

You find an array of 'struct resource' more readable than this?

+               .base =3D 0x480bd400,
+               .irq =3D 24,

+               .base =3D 0x5d000000,
+               .irq =3D 28,

+               res[0].start =3D d->base;
+               res[0].end =3D d->base + MMU_REG_SIZE - 1;
+
+               res[1].start =3D d->irq;

How would you calculate the number of resources per iommu device?

How about these?

-               err =3D platform_device_add_resources(pdev,
-                                   &omap3_iommu_res[2 * i], NR_IOMMU_R=
ES);
+               err =3D platform_device_add_resources(pdev, res, ARRAY_=
SIZE(res));
               if (err)
                       goto err_out;
-               err =3D platform_device_add_data(pdev, &omap3_iommu_pda=
ta[i],
-                                              sizeof(omap3_iommu_pdata=
[0]));
+               err =3D platform_device_add_data(pdev, &d->pdata,
sizeof(d->pdata));
               if (err)
                       goto err_out;

Do you find the original version easier to read?

>> +struct iommu_device {
>> + =C2=A0 =C2=A0 resource_size_t base;
>> + =C2=A0 =C2=A0 resource_size_t irq;
>> + =C2=A0 =C2=A0 struct iommu_platform_data pdata;
>
> generally, platform_data is a void *. Don't know if it matters here.

Yes but we need to set the actual contents for platform_device_add_data=
=2E

>> + =C2=A0 =C2=A0 struct resource res[2];
>> =C2=A0};
>> -#define NR_IOMMU_RES (ARRAY_SIZE(omap3_iommu_res) / 2)
>>
>> -static const struct iommu_platform_data omap3_iommu_pdata[] __initc=
onst =3D {
>> +static struct iommu_device devices[] =3D {
>> =C2=A0 =C2=A0 =C2=A0 {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "isp",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .nr_tlb_entries =3D 8,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .clk_name =3D "cam_ick",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .base =3D 0x480bd400,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq =3D 24,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pdata =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .name =3D "isp",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .nr_tlb_entries =3D 8,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .clk_name =3D "cam_ick",
>
> still passing clk names ? what about clkdev ?

That's for iommu to fix. I'm simply interested on decoupling iommu and
a hypothetical tidspbridge that doesn't exists yet.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
