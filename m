From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 3/3] HACK: OMAP: Serial: use PRCM wakeup events to enable clocks
Date: Wed, 15 Jun 2011 10:21:50 +0300
Message-ID: <1308122510.1851.6.camel@sokoban>
References: <1307625904-18629-1-git-send-email-t-kristo@ti.com> <1307625904-18629-4-git-send-email-t-kristo@ti.com> <BANLkTikTnMEDmXgbi1kxAJ0F0-NUAEDtzg@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60615 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505Ab1FOHVy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jun 2011 03:21:54 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <BANLkTikTnMEDmXgbi1kxAJ0F0-NUAEDtzg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: linux-omap@vger.kernel.org, "Basak, Partha" <p-basak2@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

On Tue, 2011-06-14 at 14:34 +0200, Govindraj wrote:
> On Thu, Jun 9, 2011 at 6:55 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > This patch is just to test that the idea works generally, proper implementation
> > should be done for the OMAP UART driver.
> >

Hi Govindraj,

Thanks for testing this out on OMAP3.

> 
> Doesn't seem to wake-up from off mode.
> (uart pad wakeup after enable_offmode and uart timeouts)
> 
> I used attached patch which has some more additions to this patch.
> (basically to get rid of prepare idle and resume idle calls from sram
> idle path and cut clocks independently).

I am currently checking out your patch on my code base on OMAP4, so far
I have not succeeded to get it work properly.

> 
> IIUC we have to comment out all resume calls even from omap-serial.c
> irq_chaining should call uart_irq handler registered in serial.c
> and block sleep.

Yep, this would be the case. A few calls are probably required in the
omap-serial.c because console can try to print something out, and if
this happens while clocks are cut, it dies. This is at least what I saw
on my setup.

> And on 3430SDP even for module level wakeup after cutting clocks
> I see it gets looped in prcm_irq handler trying to clear wakeup status bits
> trying to handle same from serial_omap_irq calling resume_idle
> doesn't seem to help though if I use the same call from prcm_clear_mod_irqs
> helps in wakeup.

Not sure about this as I don't have OMAP3.

> Also patch series doesn't seem to apply cleanly on 3.0 kernel conflicts with
> 4430pm things.

This is probably true, I was forced to apply quite a large amount of
code on top of PM branch to get sleep to work properly on OMAP4.

Anyway, I'll continue testing on OMAP4 on top of your patch.

-Tero

> 
> --
> Thanks,
> Govindraj.R
> 
> 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/pm44xx.c     |    4 ----
> >  arch/arm/mach-omap2/serial.c     |    3 +++
> >  drivers/tty/serial/omap-serial.c |    7 +++++++
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> > index f70a9ad..ac6aa77 100644
> > --- a/arch/arm/mach-omap2/pm44xx.c
> > +++ b/arch/arm/mach-omap2/pm44xx.c
> > @@ -103,10 +103,6 @@ void omap4_enter_sleep(unsigned int cpu, unsigned int power_state)
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
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
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
> > @@ -574,6 +575,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
> >        ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
> >                                   IRQF_SHARED, "serial idle", (void *)uart);
> >        WARN_ON(ret);
> > +       ret = omap_prcm_register_pad_irq(uart->padconf, uart->irq);
> > +       WARN_ON(ret);
> >  }
> >
> >  void omap_uart_enable_irqs(int enable)
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > index 0275c28..cfe2e7c 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -261,6 +261,8 @@ static void serial_omap_start_tx(struct uart_port *port)
> >        unsigned int start;
> >        int ret = 0;
> >
> > +       omap_uart_resume_idle(up->pdev->id);
> > +
> >        if (!up->use_dma) {
> >                serial_omap_enable_ier_thri(up);
> >                return;
> > @@ -354,6 +356,8 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
> >        unsigned int iir, lsr;
> >        unsigned long flags;
> >
> > +       omap_uart_resume_idle(up->pdev->id);
> > +
> >        iir = serial_in(up, UART_IIR);
> >        if (iir & UART_IIR_NO_INT)
> >                return IRQ_NONE;
> > @@ -947,6 +951,8 @@ serial_omap_console_write(struct console *co, const char *s,
> >        unsigned int ier;
> >        int locked = 1;
> >
> > +       omap_uart_resume_idle(up->pdev->id);
> > +
> >        local_irq_save(flags);
> >        if (up->port.sysrq)
> >                locked = 0;
> > @@ -1303,6 +1309,7 @@ static int serial_omap_probe(struct platform_device *pdev)
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
> > Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

