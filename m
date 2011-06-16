From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 3/3] HACK: OMAP: Serial: use PRCM wakeup events to enable clocks
Date: Thu, 16 Jun 2011 15:29:51 +0300
Message-ID: <1308227391.1851.13.camel@sokoban>
References: <1307625904-18629-1-git-send-email-t-kristo@ti.com> <1307625904-18629-4-git-send-email-t-kristo@ti.com> <BANLkTikTnMEDmXgbi1kxAJ0F0-NUAEDtzg@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xl2Uj0hoJnvWy0KAIuw6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53468 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756211Ab1FPM34 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 08:29:56 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <BANLkTikTnMEDmXgbi1kxAJ0F0-NUAEDtzg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: linux-omap@vger.kernel.org, "Basak, Partha" <p-basak2@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

--=-xl2Uj0hoJnvWy0KAIuw6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I was able to get this implementation to work on my setup, turned out
there was something wrong in the patch set I used on top of
linux-omap/pm to get cpuidle work on OMAP4. Anyway, attached two patches
I used for the UART part (to replace patch 3), patches 1/2 of the
original set did not need any modifications. I don't know what is the
issue with OMAP3, and I can't debug it as I don't have OMAP3 HW yet. I
should receive one in hopefully a couple of weeks though.

-Tero

On Tue, 2011-06-14 at 14:34 +0200, Govindraj wrote:
> On Thu, Jun 9, 2011 at 6:55 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > This patch is just to test that the idea works generally, proper =
implementation
> > should be done for the OMAP UART driver.
> >
>=20
> Doesn't seem to wake-up from off mode.
> (uart pad wakeup after enable_offmode and uart timeouts)
>=20
> I used attached patch which has some more additions to this patch.
> (basically to get rid of prepare idle and resume idle calls from sram
> idle path and cut clocks independently).
>=20
> IIUC we have to comment out all resume calls even from omap-serial.c
> irq_chaining should call uart_irq handler registered in serial.c
> and block sleep.
>=20
> And on 3430SDP even for module level wakeup after cutting clocks
> I see it gets looped in prcm_irq handler trying to clear wakeup status =
bits
> trying to handle same from serial_omap_irq calling resume_idle
> doesn't seem to help though if I use the same call from =
prcm_clear_mod_irqs
> helps in wakeup.
>=20
> Also patch series doesn't seem to apply cleanly on 3.0 kernel =
conflicts with
> 4430pm things.
>=20
> --
> Thanks,
> Govindraj.R
>=20
>=20
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/pm44xx.c     |    4 ----
> >  arch/arm/mach-omap2/serial.c     |    3 +++
> >  drivers/tty/serial/omap-serial.c |    7 +++++++
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm44xx.c =
b/arch/arm/mach-omap2/pm44xx.c
> > index f70a9ad..ac6aa77 100644
> > --- a/arch/arm/mach-omap2/pm44xx.c
> > +++ b/arch/arm/mach-omap2/pm44xx.c
> > @@ -103,10 +103,6 @@ void omap4_enter_sleep(unsigned int cpu, =
unsigned int power_state)
> >
> >        if (core_next_state < PWRDM_POWER_ON) {
> >                omap2_gpio_resume_after_idle();
> > -               omap_uart_resume_idle(0);
> > -               omap_uart_resume_idle(1);
> > -               omap_uart_resume_idle(2);
> > -               omap_uart_resume_idle(3);
> >        }
> >
> >        return;
> > diff --git a/arch/arm/mach-omap2/serial.c =
b/arch/arm/mach-omap2/serial.c
> > index 6959d65..4cf8c4a 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -39,6 +39,7 @@
> >  #include <plat/dma.h>
> >  #include <plat/omap_hwmod.h>
> >  #include <plat/omap_device.h>
> > +#include <plat/prcm.h>
> >
> >  #include "prm2xxx_3xxx.h"
> >  #include "pm.h"
> > @@ -574,6 +575,8 @@ static void omap_uart_idle_init(struct =
omap_uart_state *uart)
> >        ret =3D request_threaded_irq(uart->irq, NULL, =
omap_uart_interrupt,
> >                                   IRQF_SHARED, "serial idle", (void =
*)uart);
> >        WARN_ON(ret);
> > +       ret =3D omap_prcm_register_pad_irq(uart->padconf, =
uart->irq);
> > +       WARN_ON(ret);
> >  }
> >
> >  void omap_uart_enable_irqs(int enable)
> > diff --git a/drivers/tty/serial/omap-serial.c =
b/drivers/tty/serial/omap-serial.c
> > index 0275c28..cfe2e7c 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -261,6 +261,8 @@ static void serial_omap_start_tx(struct =
uart_port *port)
> >        unsigned int start;
> >        int ret =3D 0;
> >
> > +       omap_uart_resume_idle(up->pdev->id);
> > +
> >        if (!up->use_dma) {
> >                serial_omap_enable_ier_thri(up);
> >                return;
> > @@ -354,6 +356,8 @@ static inline irqreturn_t serial_omap_irq(int =
irq, void *dev_id)
> >        unsigned int iir, lsr;
> >        unsigned long flags;
> >
> > +       omap_uart_resume_idle(up->pdev->id);
> > +
> >        iir =3D serial_in(up, UART_IIR);
> >        if (iir & UART_IIR_NO_INT)
> >                return IRQ_NONE;
> > @@ -947,6 +951,8 @@ serial_omap_console_write(struct console *co, =
const char *s,
> >        unsigned int ier;
> >        int locked =3D 1;
> >
> > +       omap_uart_resume_idle(up->pdev->id);
> > +
> >        local_irq_save(flags);
> >        if (up->port.sysrq)
> >                locked =3D 0;
> > @@ -1303,6 +1309,7 @@ static int serial_omap_probe(struct =
platform_device *pdev)
> >                goto do_release_region;
> >
> >        platform_set_drvdata(pdev, up);
> > +       pr_info("OMAP UART %d is up\n", pdev->id);
> >        return 0;
> >  err:
> >        dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
> > --
> > 1.7.4.1
> >
> >
> > Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: =
0115040-6. Kotipaikka: Helsinki
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe =
linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. =
Kotipaikka: Helsinki
=20


--=-xl2Uj0hoJnvWy0KAIuw6
Content-Disposition: attachment;
	filename*0="0001-OMAP4-UART-remove-resume-prepare-idle-hooks-from-PM-.pat";
	filename*1="ch"
Content-Type: text/x-patch; charset="UTF-8";
	name="0001-OMAP4-UART-remove-resume-prepare-idle-hooks-from-PM-.patch"
Content-Transfer-Encoding: 7bit

>From 109743ff53f9fca746b41381cc1d603f042e9347 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 15 Jun 2011 15:01:18 +0300
Subject: [PATCH 1/2] OMAP4: UART: remove resume / prepare idle hooks from PM code

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index df5e2ee..fd365c3 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -91,10 +91,6 @@ void omap4_enter_sleep(unsigned int cpu, unsigned int power_state)
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(0);
-		omap_uart_prepare_idle(1);
-		omap_uart_prepare_idle(2);
-		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(0);
 		omap4_trigger_ioctrl();
 	}
@@ -103,10 +99,6 @@ void omap4_enter_sleep(unsigned int cpu, unsigned int power_state)
 
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap2_gpio_resume_after_idle();
-		omap_uart_resume_idle(0);
-		omap_uart_resume_idle(1);
-		omap_uart_resume_idle(2);
-		omap_uart_resume_idle(3);
 	}
 
 	return;
-- 
1.7.4.1


--=-xl2Uj0hoJnvWy0KAIuw6
Content-Disposition: attachment;
	filename*0="0002-OMAP-serial-use-chained-interrupt-handler-for-IO-pad.pat";
	filename*1="ch"
Content-Type: text/x-patch; charset="UTF-8";
	name="0002-OMAP-serial-use-chained-interrupt-handler-for-IO-pad.patch"
Content-Transfer-Encoding: 7bit

>From 52d23bb47644c1a48d10d552066ac86885137e8a Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Thu, 16 Jun 2011 15:21:14 +0300
Subject: [PATCH 2/2] OMAP: serial: use chained interrupt handler for IO pad wakeup

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/serial.c     |   31 +++++++++++--------------------
 drivers/tty/serial/omap-serial.c |    6 ++++++
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 6959d65..c443c0f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -39,6 +39,7 @@
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/prcm.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
@@ -386,6 +387,7 @@ static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 	omap_uart_smart_idle_enable(uart, 1);
 	uart->can_sleep = 1;
 	del_timer(&uart->timer);
+	omap_uart_disable_clocks(uart);
 }
 
 static void omap_uart_idle_timer(unsigned long data)
@@ -397,36 +399,23 @@ static void omap_uart_idle_timer(unsigned long data)
 
 void omap_uart_prepare_idle(int num)
 {
-	struct omap_uart_state *uart;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
-			return;
-		}
-	}
 }
 
 void omap_uart_resume_idle(int num)
 {
 	struct omap_uart_state *uart;
+	u32 wkst;
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (num == uart->num && uart->can_sleep) {
-			omap_uart_enable_clocks(uart);
-
-			/* Check for IO pad wakeup */
-			if (cpu_is_omap34xx() && uart->padconf) {
-				u16 p = omap_ctrl_readw(uart->padconf);
+			omap_uart_block_sleep(uart);
 
-				if (p & OMAP3_PADCONF_WAKEUPEVENT0)
-					omap_uart_block_sleep(uart);
+			/* Check for normal UART wakeup (and clear it) */
+			if (uart->wk_st && uart->wk_mask) {
+				wkst = __raw_readl(uart->wk_st) & uart->wk_mask;
+				if (wkst)
+					__raw_writel(wkst, uart->wk_st);
 			}
-
-			/* Check for normal UART wakeup */
-			if (uart->wk_st && uart->wk_mask)
-				if (__raw_readl(uart->wk_st) & uart->wk_mask)
-					omap_uart_block_sleep(uart);
 			return;
 		}
 	}
@@ -574,6 +563,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
 				   IRQF_SHARED, "serial idle", (void *)uart);
 	WARN_ON(ret);
+	ret = omap_prcm_register_pad_irq(uart->padconf, uart->irq);
+	WARN_ON(ret);
 }
 
 void omap_uart_enable_irqs(int enable)
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0275c28..bbea099 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -261,6 +261,8 @@ static void serial_omap_start_tx(struct uart_port *port)
 	unsigned int start;
 	int ret = 0;
 
+	omap_uart_resume_idle(up->pdev->id);
+
 	if (!up->use_dma) {
 		serial_omap_enable_ier_thri(up);
 		return;
@@ -354,6 +356,8 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	unsigned int iir, lsr;
 	unsigned long flags;
 
+	omap_uart_resume_idle(up->pdev->id);
+
 	iir = serial_in(up, UART_IIR);
 	if (iir & UART_IIR_NO_INT)
 		return IRQ_NONE;
@@ -947,6 +951,8 @@ serial_omap_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
+	omap_uart_resume_idle(up->pdev->id);
+
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
-- 
1.7.4.1


--=-xl2Uj0hoJnvWy0KAIuw6--
