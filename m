From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP: hwmod: Add possibility to count hwmod
 resources based on type
Date: Fri, 2 Nov 2012 08:22:12 +0100
Message-ID: <509374A4.8050806@ti.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com> <1351596296-13825-2-git-send-email-peter.ujfalusi@ti.com> <509106FD.2040804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33752 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609Ab2KBHWS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 03:22:18 -0400
In-Reply-To: <509106FD.2040804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Benoit,

On 10/31/2012 12:09 PM, Cousson, Benoit wrote:
> Hi Peter,
>=20
> That's great you've have done that fix.
>=20
> On 10/30/2012 12:24 PM, Peter Ujfalusi wrote:
>> Add flags parameter for omap_hwmod_count_resources() so users can te=
ll which
>> type of resources they are interested when counting them in hwmod da=
tabase.
>=20
> Mmm, does it worth doing that for every resources considering that th=
is is a
> temporary situation and than only the DMA resources are an issue so f=
ar?

I think it is better to have nice API - even for a short term - than in=
troduce
a new wrapper just to count the DMA resources.
Yes we only use this to either count all resources or to count the DMA
resources only, but the other options does not look better either:
1. omap_hwmod_count_dma_resources(struct omap_hwmod *oh)
2. omap_hwmod_count_resources(struct omap_hwmod *oh, bool dma_only)

--=20
P=E9ter

>=20
> Otherwise that looks fine to me and will allow a much smoother transi=
tion to
> full DT.
>=20
> Thanks,
> Benoit
>=20
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c             | 27 ++++++++++++++++=
-----------
>>   arch/arm/plat-omap/include/plat/omap_hwmod.h |  2 +-
>>   arch/arm/plat-omap/omap_device.c             | 11 ++++++++---
>>   3 files changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>> b/arch/arm/mach-omap2/omap_hwmod.c
>> index b969ab1..a79c941 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -3337,7 +3337,7 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
>>   /**
>>    * omap_hwmod_count_resources - count number of struct resources n=
eeded by
>> hwmod
>>    * @oh: struct omap_hwmod *
>> - * @res: pointer to the first element of an array of struct resourc=
e to fill
>> + * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
>>    *
>>    * Count the number of struct resource array elements necessary to
>>    * contain omap_hwmod @oh resources.  Intended to be called by cod=
e
>> @@ -3350,20 +3350,25 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
>>    * resource IDs.
>>    *
>>    */
>> -int omap_hwmod_count_resources(struct omap_hwmod *oh)
>> +int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long=
 flags)
>>   {
>> -    struct omap_hwmod_ocp_if *os;
>> -    struct list_head *p;
>> -    int ret;
>> -    int i =3D 0;
>> +    int ret =3D 0;
>>
>> -    ret =3D _count_mpu_irqs(oh) + _count_sdma_reqs(oh);
>> +    if (flags & IORESOURCE_IRQ)
>> +        ret +=3D _count_mpu_irqs(oh);
>>
>> -    p =3D oh->slave_ports.next;
>> +    if (flags & IORESOURCE_DMA)
>> +        ret +=3D _count_sdma_reqs(oh);
>>
>> -    while (i < oh->slaves_cnt) {
>> -        os =3D _fetch_next_ocp_if(&p, &i);
>> -        ret +=3D _count_ocp_if_addr_spaces(os);
>> +    if (flags & IORESOURCE_MEM) {
>> +        int i =3D 0;
>> +        struct omap_hwmod_ocp_if *os;
>> +        struct list_head *p =3D oh->slave_ports.next;
>> +
>> +        while (i < oh->slaves_cnt) {
>> +            os =3D _fetch_next_ocp_if(&p, &i);
>> +            ret +=3D _count_ocp_if_addr_spaces(os);
>> +        }
>>       }
>>
>>       return ret;
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> index b3349f7..48a6f5d 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -628,7 +628,7 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *=
oh, u16
>> reg_offs);
>>   u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
>>   int omap_hwmod_softreset(struct omap_hwmod *oh);
>>
>> -int omap_hwmod_count_resources(struct omap_hwmod *oh);
>> +int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long=
 flags);
>>   int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resour=
ce *res);
>>   int omap_hwmod_fill_dma_resources(struct omap_hwmod *oh, struct re=
source
>> *res);
>>   int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned=
 int type,
>> diff --git a/arch/arm/plat-omap/omap_device.c
>> b/arch/arm/plat-omap/omap_device.c
>> index 7a7d1f2..915cf68 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -442,19 +442,21 @@ int omap_device_get_context_loss_count(struct
>> platform_device *pdev)
>>   /**
>>    * omap_device_count_resources - count number of struct resource e=
ntries
>> needed
>>    * @od: struct omap_device *
>> + * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
>>    *
>>    * Count the number of struct resource entries needed for this
>>    * omap_device @od.  Used by omap_device_build_ss() to determine h=
ow
>>    * much memory to allocate before calling
>>    * omap_device_fill_resources().  Returns the count.
>>    */
>> -static int omap_device_count_resources(struct omap_device *od)
>> +static int omap_device_count_resources(struct omap_device *od,
>> +                       unsigned long flags)
>>   {
>>       int c =3D 0;
>>       int i;
>>
>>       for (i =3D 0; i < od->hwmods_cnt; i++)
>> -        c +=3D omap_hwmod_count_resources(od->hwmods[i]);
>> +        c +=3D omap_hwmod_count_resources(od->hwmods[i], flags);
>>
>>       pr_debug("omap_device: %s: counted %d total resources across %=
d
>> hwmods\n",
>>            od->pdev->name, c, od->hwmods_cnt);
>> @@ -558,7 +560,10 @@ struct omap_device *omap_device_alloc(struct
>> platform_device *pdev,
>>       od->hwmods =3D hwmods;
>>       od->pdev =3D pdev;
>>
>> -    res_count =3D omap_device_count_resources(od);
>> +    /* Count all resources for the device */
>> +    res_count =3D omap_device_count_resources(od, IORESOURCE_IRQ |
>> +                            IORESOURCE_DMA |
>> +                            IORESOURCE_MEM);
>>       /*
>>        * DT Boot:
>>        *   OF framework will construct the resource structure (curre=
ntly
>>
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
