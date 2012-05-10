From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 2/2] omap4: iommu: fix irq and clock name for dsp-iommu
Date: Thu, 10 May 2012 08:20:00 +0300
Message-ID: <CAK=WgbZsM6HvFKTsnjK_LD=6wi75i2Ec_H2LvF782K5iZbT5xQ@mail.gmail.com>
References: <1336616370-28268-1-git-send-email-jgutierrez@ti.com> <1336616370-28268-3-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49660 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab2EJFUW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 01:20:22 -0400
Received: by yenm10 with SMTP id m10so1095927yen.19
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 22:20:21 -0700 (PDT)
In-Reply-To: <1336616370-28268-3-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juan Gutierrez <jgutierrez@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, May 10, 2012 at 5:19 AM, Juan Gutierrez <jgutierrez@ti.com> wro=
te:
> Irq and clock names were wrong for dsp iommu configuration
> for omap4.
>
> - Renamed tesla_ick to dsp_fck:
> =A0 This is required because the new naming convention introduced
> =A0 by: commit 0e43327 "OMAP4 clock: Fix clock names and align
> =A0 with hwmod names"
>
> - Renamed INT_44XX_DSP_MMU to OMAP44XX_IRQ_TESLA_MMU.
> =A0 Naming convention adopted since: commit e927f8d "omap4: Add
> =A0 auto-generated irq and dma headers"
>
> - dsp-iommu is enabled by default.
>
> Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
