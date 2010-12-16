From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc handling
Date: Thu, 16 Dec 2010 13:58:07 +0530
Message-ID: <AANLkTi=RE3ZEuoe=jMRLiFZ7iVgvuXMrgqfXMAYa92=z@mail.gmail.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com> <1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56942 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330Ab0LPI2t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 03:28:49 -0500
Received: by iwn8 with SMTP id 8so3302926iwn.20
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 00:28:48 -0800 (PST)
In-Reply-To: <1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 16, 2010 at 12:17, Omar Ramirez Luna <omar.ramirez@ti.com> =
wrote:
> Use runtime pm APIs to enable/disable mailbox clocks and
> to configure SYSC register.
>
> Based on the patch sent by Felipe Contreras:
> https://patchwork.kernel.org/patch/101662/
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> =A0arch/arm/mach-omap2/mailbox.c | =A0 27 +++++----------------------
> =A01 files changed, 5 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mail=
box.c
> index 40ddeca..f5f72ba 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -14,6 +14,7 @@
> =A0#include <linux/err.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> =A0#include <plat/mailbox.h>
> =A0#include <mach/irqs.h>
>
> @@ -34,12 +35,8 @@
> =A0#define MAILBOX_IRQ_NOTFULL(m) =A0 =A0 =A0 =A0 (1 << (2 * (m) + 1)=
)
>
> =A0/* SYSCONFIG: register bit definition */
> -#define AUTOIDLE =A0 =A0 =A0 (1 << 0)
> =A0#define SOFTRESET =A0 =A0 =A0(1 << 1)
> -#define SMARTIDLE =A0 =A0 =A0(2 << 3)
> =A0#define OMAP4_SOFTRESET =A0 =A0 =A0 =A0(1 << 0)
> -#define OMAP4_NOIDLE =A0 (1 << 2)
> -#define OMAP4_SMARTIDLE =A0 =A0 =A0 =A0(2 << 2)
>
> =A0/* SYSSTATUS: register bit definition */
> =A0#define RESETDONE =A0 =A0 =A0(1 << 0)

Is this still required?

> @@ -70,8 +67,6 @@ struct omap_mbox2_priv {
> =A0 =A0 =A0 =A0unsigned long irqdisable;
> =A0};
>
> -static struct clk *mbox_ick_handle;
> -
> =A0static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0om=
ap_mbox_type_t irq);
>

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
