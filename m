From: "Gutierrez, Juan" <jgutierrez@ti.com>
Subject: Re: [PATCH v2 2/3] OMAP4: iommu: fix irq and clock name for dsp-iommu
Date: Mon, 7 May 2012 10:58:06 -0500
Message-ID: <CADVn9REbqna7YHD2bDFyMCEmhfpbzWZ222fuOC2GxWUE705Lbg@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-3-git-send-email-jgutierrez@ti.com> <CAK=Wgbb8irgoyt21_tgqg+gFvKxSqs3Ud9KnTUkw-zMuE1X-wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:33460 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756382Ab2EGP62 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 11:58:28 -0400
Received: by yhoo21 with SMTP id o21so1326270yho.18
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 08:58:27 -0700 (PDT)
In-Reply-To: <CAK=Wgbb8irgoyt21_tgqg+gFvKxSqs3Ud9KnTUkw-zMuE1X-wQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ohad

On Sun, May 6, 2012 at 7:33 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Juan,
>
> On Sat, Apr 14, 2012 at 2:39 AM, Juan Gutierrez <jgutierrez@ti.com> wrote:
>> Irq and clock names were wrong for dsp iommu configuration
>> for omap4.
>
> Looks good.
>
>> Renamed tesla_ick to dsp_fck.
>
> If you're resubmitting the series, please indicate here why this
> change is needed (specifically let's mention commit 0e43327 "OMAP4:
> clock: Fix clock names and align with hwmod names").
>
Ok, I will mention the reason of this change in next series.

> Thanks,
> Ohad.



-- 
Thanks

juan gutierrez
