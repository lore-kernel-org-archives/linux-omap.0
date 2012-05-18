From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix gpmc request_irq
Date: Fri, 18 May 2012 12:33:16 +0530
Message-ID: <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45845 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754346Ab2ERHDi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 03:03:38 -0400
Received: by qafl39 with SMTP id l39so2615729qaf.2
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 00:03:36 -0700 (PDT)
In-Reply-To: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>

+ Afzal who has been doing quite a bit of GMPC work recently.

On Fri, May 18, 2012 at 10:13 AM, Ming Lei <ming.lei@canonical.com> wro=
te:
> The IRQ52 on OMAP2+ is not a shared interrupt line. If IRQF_SHARED
> is passed to request_irq and dev_id is set as NULL, request_irq will
> return -EINVAL.
>
GPMC IRQ line can shared between the multiple devices you
connect on it.

> This patch just removes the flag of IRQF_SHARED to make the irq
> registration successful.
>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
> =A0arch/arm/mach-omap2/gpmc.c | =A0 =A02 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>
Are you sure it fails ?
I just tried booting OMAP4 with 3.4-rc4 and don't see the irq
failure error message. What I am missing ?

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
