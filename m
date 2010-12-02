From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Unbalanced IRQ wake disable during resume from static suspend
Date: Thu, 2 Dec 2010 14:38:34 +0530
Message-ID: <1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com>
References: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com> <alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47127 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751680Ab0LBJIp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 04:08:45 -0500
Received: by mail-qw0-f43.google.com with SMTP id 3so2745334qwk.2
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 01:08:44 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Govindraj <govindraj.ti@gmail.com>
Cc: khilman@deeprootsystems.com

Paul,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Thursday, December 02, 2010 1:44 PM
> To: linux-omap@vger.kernel.org; Govindraj
> Cc: khilman@deeprootsystems.com
> Subject: Re: Unbalanced IRQ wake disable during resume from static
suspend
>
> On Thu, 2 Dec 2010, Paul Walmsley wrote:
>
> > On current linux-omap master (commit
> > 7fd1cffc56ca9944fec583eb2ecda5ce88b36bff "Linux-omap rebuilt: Updated
to
> > -rc4"), when resuming from static suspend, several "Unbalanced IRQ
> > wake disable" warnings are generated, one for each of the serial
ports.
> > This is on Beagle 35xx rev C2.
>
> Just to follow up on this, these messages are not logged when
> /sys/devices/platform/omap/omap-hsuart.*/tty/ttyO*/power/wakeup are set
to
> 'disabled'.
>
> Also this is with omap2plus_defconfig.
>
Just a wild guess here but is this because the 'set_wake' is
not setup and then fw might be returning some error whenever
driver invoke this API as part of enable_irq_wake() callback

If that being the case, below patch might might help. Can
somebody try this out ?

Regards,
Santosh

omap: irq: Dummy handler for enable_irq_wake

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/irq.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 32eeabe..6a964d3 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -143,11 +143,21 @@ static void omap_mask_ack_irq(unsigned int irq)
 	omap_ack_irq(irq);
 }

+#ifdef CONFIG_PM
+static int omap_set_wake(unsigned int irq, unsigned int on)
+{
+	return 0;
+}
+#else
+#define omap_set_wake NULL
+#endif
+
 static struct irq_chip omap_irq_chip = {
 	.name	= "INTC",
 	.ack	= omap_mask_ack_irq,
 	.mask	= omap_mask_irq,
 	.unmask	= omap_unmask_irq,
+	.set_wake = omap_set_wake,
 };

 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
-- 
1.6.0.4
