From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] OMAP: IOMMU: add missing function declaration
Date: Mon, 14 Feb 2011 06:36:16 +0800
Message-ID: <AANLkTikUMURq-=okRju5YJroMEShHH6_eEMSvrg11UxC@mail.gmail.com>
References: <1297508987-9193-1-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:45714 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754474Ab1BMWg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Feb 2011 17:36:57 -0500
Received: by mail-yx0-f179.google.com with SMTP id 7so1787786yxs.10
        for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 14:36:56 -0800 (PST)
In-Reply-To: <1297508987-9193-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Sat, Feb 12, 2011 at 19:09, David Cohen <dacohen@gmail.com> wrote:
> Function declaration 'iopgtable_lookup_entry' is missing from header
> file.

Is this done because of any error?
You may add a comment on why this is required.

>
> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
> =A0arch/arm/plat-omap/include/plat/iommu.h | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-=
omap/include/plat/iommu.h
> index 9e8c104..5a2475f 100644
> --- a/arch/arm/plat-omap/include/plat/iommu.h
> +++ b/arch/arm/plat-omap/include/plat/iommu.h
> @@ -163,6 +163,8 @@ extern void flush_iotlb_range(struct iommu *obj, =
u32 start, u32 end);
> =A0extern void flush_iotlb_all(struct iommu *obj);
>
> =A0extern int iopgtable_store_entry(struct iommu *obj, struct iotlb_e=
ntry *e);
> +extern void iopgtable_lookup_entry(struct iommu *obj, u32 da, u32 **=
ppgd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u32 **ppte);
> =A0extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iova);
>
> =A0extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 en=
d);
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
