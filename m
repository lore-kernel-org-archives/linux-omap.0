From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc handling
Date: Thu, 16 Dec 2010 10:32:41 -0600
Message-ID: <AANLkTinJOFMF=eC2MQB92e2XUsyyjNRRz7Bm_cyXEmp6@mail.gmail.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60351 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752871Ab0LPQcm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 11:32:42 -0500
Received: by pxi2 with SMTP id 2so586921pxi.40
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 08:32:41 -0800 (PST)
In-Reply-To: <1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Charulatha V <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Omar,

On Thu, Dec 16, 2010 at 12:47 AM, Omar Ramirez Luna <omar.ramirez@ti.co=
m> wrote:
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
> @@ -91,13 +86,8 @@ static int omap2_mbox_startup(struct omap_mbox *mb=
ox)
> =A0 =A0 =A0 =A0u32 l;
> =A0 =A0 =A0 =A0unsigned long timeout;
>
> - =A0 =A0 =A0 mbox_ick_handle =3D clk_get(NULL, "mailboxes_ick");
> - =A0 =A0 =A0 if (IS_ERR(mbox_ick_handle)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Could not get mailboxe=
s_ick: %ld\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PTR_ERR(mbox_ick_handle=
));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(mbox_ick_handle);
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 clk_enable(mbox_ick_handle);
> + =A0 =A0 =A0 pm_runtime_enable(mbox->dev->parent);
> + =A0 =A0 =A0 pm_runtime_get_sync(mbox->dev->parent);
>
> =A0 =A0 =A0 =A0if (cpu_is_omap44xx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mbox_write_reg(OMAP4_SOFTRESET, MAILBO=
X_SYSCONFIG);
> @@ -130,12 +120,6 @@ static int omap2_mbox_startup(struct omap_mbox *=
mbox)
> =A0 =A0 =A0 =A0l =3D mbox_read_reg(MAILBOX_REVISION);
> =A0 =A0 =A0 =A0pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, =
(l & 0x0f));
>
> - =A0 =A0 =A0 if (cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D OMAP4_SMARTIDLE;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D SMARTIDLE | AUTOIDLE;
> - =A0 =A0 =A0 mbox_write_reg(l, MAILBOX_SYSCONFIG);
> -

The OMAP4 mailbox sysconfig register bits are laid out differently
from previous OMAP mailbox's. Example is smart idle bit location is
different from previous OMAPs. Can I know as how are you handling this
aspect in hwmod code ?


Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
