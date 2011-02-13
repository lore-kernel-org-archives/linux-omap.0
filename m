From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC/PATCH 1/3] OMAP: IOMMU: Add generic IOMMU errors code
Date: Mon, 14 Feb 2011 06:33:35 +0800
Message-ID: <AANLkTimai_hGRAYFxAPaE+dd3EytswgLDNw28ghGA8YW@mail.gmail.com>
References: <1297507373-1520-1-git-send-email-dacohen@gmail.com> <1297507373-1520-2-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:56136 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab1BMWeR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Feb 2011 17:34:17 -0500
Received: by mail-yw0-f51.google.com with SMTP id 5so2132714ywl.24
        for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 14:34:16 -0800 (PST)
In-Reply-To: <1297507373-1520-2-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org

On Sat, Feb 12, 2011 at 18:42, David Cohen <dacohen@gmail.com> wrote:
> Generic IOMMU errors code are necessary to handle errors on generic
> layer.
>
> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
> =A0arch/arm/plat-omap/include/plat/iommu.h | =A0 =A07 +++++++
> =A01 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-=
omap/include/plat/iommu.h
> index 69230d6..71f369d 100644
> --- a/arch/arm/plat-omap/include/plat/iommu.h
> +++ b/arch/arm/plat-omap/include/plat/iommu.h
> @@ -109,6 +109,13 @@ struct iommu_platform_data {
> =A0 =A0 =A0 =A0u32 da_end;
> =A0};
>
> +/* IOMMU errors */
> +#define OMAP_IOMMU_ERR_TLB_MISS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <<=
 0)
> +#define OMAP_IOMMU_ERR_TRANS_FAULT =A0 =A0 (1 << 1)
> +#define OMAP_IOMMU_ERR_EMU_MISS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <<=
 2)
> +#define OMAP_IOMMU_ERR_TBLWALK_FAULT =A0 (1 << 3)
> +#define OMAP_IOMMU_ERR_MULTIHIT_FAULT =A0(1 << 4)

Define these macros in the patch where they are used.

> +
> =A0#if defined(CONFIG_ARCH_OMAP1)
> =A0#error "iommu for this processor not implemented yet"
> =A0#else
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
