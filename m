From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 2/3] OMAP4: iommu: fix irq and clock name for dsp-iommu
Date: Sun, 6 May 2012 15:33:41 +0300
Message-ID: <CAK=Wgbb8irgoyt21_tgqg+gFvKxSqs3Ud9KnTUkw-zMuE1X-wQ@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com> <1334360392-1494-3-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47423 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2EFMeC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 May 2012 08:34:02 -0400
Received: by yenm10 with SMTP id m10so3165424yen.19
        for <linux-omap@vger.kernel.org>; Sun, 06 May 2012 05:34:02 -0700 (PDT)
In-Reply-To: <1334360392-1494-3-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juan Gutierrez <jgutierrez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Juan,

On Sat, Apr 14, 2012 at 2:39 AM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> Irq and clock names were wrong for dsp iommu configuration
> for omap4.

Looks good.

> Renamed tesla_ick to dsp_fck.

If you're resubmitting the series, please indicate here why this
change is needed (specifically let's mention commit 0e43327 "OMAP4:
clock: Fix clock names and align with hwmod names").

Thanks,
Ohad.
