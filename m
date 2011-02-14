From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH] OMAP: IOMMU: add missing function declaration
Date: Mon, 14 Feb 2011 13:26:08 +0200
Message-ID: <AANLkTinQOCG9dEwky53LRwEYO95ptchu6tsRF1iXmfLn@mail.gmail.com>
References: <1297508987-9193-1-git-send-email-dacohen@gmail.com>
	<AANLkTikUMURq-=okRju5YJroMEShHH6_eEMSvrg11UxC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56479 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab1BNL0K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 06:26:10 -0500
Received: by wwa36 with SMTP id 36so4750777wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 03:26:08 -0800 (PST)
In-Reply-To: <AANLkTikUMURq-=okRju5YJroMEShHH6_eEMSvrg11UxC@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Mon, Feb 14, 2011 at 12:36 AM, Varadarajan, Charulatha <charu@ti.com=
> wrote:
> On Sat, Feb 12, 2011 at 19:09, David Cohen <dacohen@gmail.com> wrote:
>> Function declaration 'iopgtable_lookup_entry' is missing from header
>> file.
>
> Is this done because of any error?
> You may add a comment on why this is required.

The function is exported by iommu module, but no other driver is using
it so far. So, it's wrong but currently we have only a sparse warning.
I can add this information to the patch description.

Br,

David

>
>>
>> Signed-off-by: David Cohen <dacohen@gmail.com>
>> ---
>> =C2=A0arch/arm/plat-omap/include/plat/iommu.h | =C2=A0 =C2=A02 ++
>> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat=
-omap/include/plat/iommu.h
>> index 9e8c104..5a2475f 100644
>> --- a/arch/arm/plat-omap/include/plat/iommu.h
>> +++ b/arch/arm/plat-omap/include/plat/iommu.h
>> @@ -163,6 +163,8 @@ extern void flush_iotlb_range(struct iommu *obj,=
 u32 start, u32 end);
>> =C2=A0extern void flush_iotlb_all(struct iommu *obj);
>>
>> =C2=A0extern int iopgtable_store_entry(struct iommu *obj, struct iot=
lb_entry *e);
>> +extern void iopgtable_lookup_entry(struct iommu *obj, u32 da, u32 *=
*ppgd,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 **ppte);
>> =C2=A0extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iov=
a);
>>
>> =C2=A0extern int iommu_set_da_range(struct iommu *obj, u32 start, u3=
2 end);
>> --
>> 1.7.1
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
