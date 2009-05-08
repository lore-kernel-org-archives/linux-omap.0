From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Sat, 9 May 2009 01:27:34 +0300
Message-ID: <94a0d4530905081527t16e320d6o9715ad17952c8901@mail.gmail.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	 <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
	 <94a0d4530905071305i3f604b4am39f4c467e4df65a9@mail.gmail.com>
	 <20090508.071021.123989594.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905080032xd0f7bb0ld760a65bf54429f2@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89443DD434A7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:12960 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbZEHW1g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 18:27:36 -0400
Received: by fg-out-1718.google.com with SMTP id 16so569425fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2009 15:27:34 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE89443DD434A7@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "sakari.ailus@maxwell.research.nokia.com" <sakari.ailus@maxwell.research.nokia.com>, "tony@atomide.com" <tony@atomide.com>

On Fri, May 8, 2009 at 8:21 PM, Aguirre Rodriguez, Sergio Alberto
<saaguirre@ti.com> wrote:
> Hi,
>
> Just one comment below:
>
>> > Does the following make sense?
>> >
>> > +#define NR_IOMMU_RES 2
>> >
>> > ....
>> >
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D platfor=
m_device_add_resources(pdev,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3_iommu_res + =
=C2=A0i * NR_IOMMU_RES,
>> NR_IOMMU_RES);
>>
>> Yeap, also:
>>
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D platfor=
m_device_add_resources(pdev,
>> omap3_iommu_res + =C2=A0i * 2, 2);
>
> IMHO, I don't think it's a good idea to add magical numbers to any co=
de in the kernel. Why is it better to NOT use a define?

I agree, but even a define is not good enough. For example you can
update the array without updating the define.

A better solution is to do what I did on my follow up patch series:

+               struct resource res[] =3D {
+                       { .flags =3D IORESOURCE_MEM },
+                       { .flags =3D IORESOURCE_IRQ },
+               };

+               err =3D platform_device_add_resources(pdev, res, ARRAY_=
SIZE(res));

No need for a define, and as soon as the array is updated so will the
second argument sent to platform_device_add_resources.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
