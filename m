From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Sat, 16 May 2009 12:56:31 +0300
Message-ID: <94a0d4530905160256j1bcf1955mf9a62fd04f715cfa@mail.gmail.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	 <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
	 <20090516092036.GD15328@n2100.arm.linux.org.uk>
	 <94a0d4530905160238g21db0519u2e0ad7a46c6e07b9@mail.gmail.com>
	 <20090516095417.GI15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:44520 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998AbZEPJ4b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:56:31 -0400
Received: by fg-out-1718.google.com with SMTP id 16so831876fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2009 02:56:31 -0700 (PDT)
In-Reply-To: <20090516095417.GI15328@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Sat, May 16, 2009 at 12:54 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, May 16, 2009 at 12:38:23PM +0300, Felipe Contreras wrote:
>> On Sat, May 16, 2009 at 12:20 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, May 05, 2009 at 03:47:00PM +0300, Hiroshi DOYU wrote:
>> >> +static struct resource omap3_iommu_res[] =3D {
>> >> + =C2=A0 =C2=A0 { /* Camera ISP MMU */
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU1_BASE,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU1_BASE + MMU_REG_SIZE - 1,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D IORESOURCE_MEM,
>> >> + =C2=A0 =C2=A0 },
>> >> + =C2=A0 =C2=A0 {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU1_IRQ,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D IORESOURCE_IRQ,
>> >> + =C2=A0 =C2=A0 },
>> >> + =C2=A0 =C2=A0 { /* IVA2.2 MMU */
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU2_BASE,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU2_BASE + MMU_REG_SIZE - 1,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D IORESOURCE_MEM,
>> >> + =C2=A0 =C2=A0 },
>> >> + =C2=A0 =C2=A0 {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D OMAP3_MMU2_IRQ,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D IORESOURCE_IRQ,
>> >> + =C2=A0 =C2=A0 },
>> >> +};
>> >> +#define NR_IOMMU_RES (ARRAY_SIZE(omap3_iommu_res) / 2)
>> >
>> > This looks all very convoluted. =C2=A0Why not do something like:
>> >
>> > static unsigned long iommu_base[] =3D {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP3_MMU1_BASE,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP3_MMU2_BASE,
>> > };
>> >
>> > static int iommu_irq[] =3D {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP3_MMU1_IRQ,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP3_MMU2_IRQ,
>> > };
>>
>> All your comments are pretty similar to my reorganize patch:
>> http://marc.info/?l=3Dlinux-omap&m=3D124172711303076&w=3D2
>
> ... which hasn't been posted to linux-arm-kernel, and so I won't see =
it.

You are not subscribed to linux-omap? I wasn't subscribed to
linux-arm-kernel at that point, I'll resend to there.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
