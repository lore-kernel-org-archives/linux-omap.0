From: David Cohen <dacohen@gmail.com>
Subject: Re: [RFC/PATCH 1/3] OMAP: IOMMU: Add generic IOMMU errors code
Date: Mon, 14 Feb 2011 13:28:19 +0200
Message-ID: <AANLkTi=gsX0306NydPbaLGTtvupGD47E0b70JC6EqmO3@mail.gmail.com>
References: <1297507373-1520-1-git-send-email-dacohen@gmail.com>
	<1297507373-1520-2-git-send-email-dacohen@gmail.com>
	<AANLkTimai_hGRAYFxAPaE+dd3EytswgLDNw28ghGA8YW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42093 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab1BNL2V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 06:28:21 -0500
Received: by wwa36 with SMTP id 36so4752794wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 03:28:19 -0800 (PST)
In-Reply-To: <AANLkTimai_hGRAYFxAPaE+dd3EytswgLDNw28ghGA8YW@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org

On Mon, Feb 14, 2011 at 12:33 AM, Varadarajan, Charulatha <charu@ti.com=
> wrote:
> On Sat, Feb 12, 2011 at 18:42, David Cohen <dacohen@gmail.com> wrote:
>> Generic IOMMU errors code are necessary to handle errors on generic
>> layer.
>>
>> Signed-off-by: David Cohen <dacohen@gmail.com>
>> ---
>> =C2=A0arch/arm/plat-omap/include/plat/iommu.h | =C2=A0 =C2=A07 +++++=
++
>> =C2=A01 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat=
-omap/include/plat/iommu.h
>> index 69230d6..71f369d 100644
>> --- a/arch/arm/plat-omap/include/plat/iommu.h
>> +++ b/arch/arm/plat-omap/include/plat/iommu.h
>> @@ -109,6 +109,13 @@ struct iommu_platform_data {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 da_end;
>> =C2=A0};
>>
>> +/* IOMMU errors */
>> +#define OMAP_IOMMU_ERR_TLB_MISS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(1 << 0)
>> +#define OMAP_IOMMU_ERR_TRANS_FAULT =C2=A0 =C2=A0 (1 << 1)
>> +#define OMAP_IOMMU_ERR_EMU_MISS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(1 << 2)
>> +#define OMAP_IOMMU_ERR_TBLWALK_FAULT =C2=A0 (1 << 3)
>> +#define OMAP_IOMMU_ERR_MULTIHIT_FAULT =C2=A0(1 << 4)
>
> Define these macros in the patch where they are used.

That's fine for me. I can merge patches 1 and 3.

Regards,

David

>
>> +
>> =C2=A0#if defined(CONFIG_ARCH_OMAP1)
>> =C2=A0#error "iommu for this processor not implemented yet"
>> =C2=A0#else
>> --
>> 1.7.1
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
