From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Tue, 22 Feb 2011 19:17:26 -0600
Message-ID: <AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46898 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467Ab1BWBR2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 20:17:28 -0500
Received: by mail-vx0-f170.google.com with SMTP id 39so2431735vxb.29
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 17:17:27 -0800 (PST)
In-Reply-To: <1297884951-3019-3-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com> wrote:
> Add support to register an isr for IOMMU fault situations and adapt i=
t
> to allow such (*isr)() to be used as fault callback. Drivers using IO=
MMU
> module might want to be informed when errors happen in order to debug=
 it
> or react.
>
> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
> =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 17 +++++=
++++-
> =A0arch/arm/plat-omap/include/plat/iommu.h | =A0 14 ++++++++-
> =A0arch/arm/plat-omap/iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 52 +++=
+++++++++++++++++++---------
> =A03 files changed, 65 insertions(+), 18 deletions(-)
>
=2E...

> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
> =A0}
> =A0EXPORT_SYMBOL_GPL(iommu_put);
>
> +int iommu_set_isr(const char *name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*isr)(struct iommu *obj, u32 d=
a, u32 iommu_errs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *priv),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *isr_priv)
> +{
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct iommu *obj;
> +

if the driver support multiple user for the same iommu why can only
one callback be registered? should it support register multiple
callback function (one per user)?

Regards,
=46ernando.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
