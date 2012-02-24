From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/5] ARM: OMAP2+: wakeupgen: Fix wrong array size for irq_target_cpu
Date: Fri, 24 Feb 2012 11:51:57 +0530
Message-ID: <CAMQu2gwxViG6bSHG+tn5=GLqtPk+zTZd3MFnSEo=wO7oPUuyuw@mail.gmail.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com> <1330035801-14937-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58089 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754383Ab2BXGWU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 01:22:20 -0500
Received: by qadz32 with SMTP id z32so127352qad.14
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 22:22:18 -0800 (PST)
In-Reply-To: <1330035801-14937-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 24, 2012 at 3:53 AM, Benoit Cousson <b-cousson@ti.com> wrot=
e:
> The wakeupgen was wrongly allocating an array based on the
> NR_IRQS value (410 on OMAP4) whereas it is just capable of handling 1=
28
> entries.
> Moreover with SPARSE_IRQ, the NR_IRQS number might be 16, and thus
> cannot handle the proper number of entries. It will generate an oops =
as
> soon a driver will request an IRQ > 16.
>
> Allocate the array using the fixed MAX_IRQS value (128).
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap-wakeupgen.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
Right.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
