From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
Date: Fri, 09 Sep 2011 14:35:49 +0530
Message-ID: <4E69D6ED.4080409@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com> <878vpyhotu.fsf@ti.com> <4E69961D.40700@ti.com> <alpine.LFD.2.02.1109090912130.2723@ionos> <4E69C957.5070708@ti.com> <alpine.LFD.2.02.1109091017300.2723@ionos>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010300060004050802040203"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:44502 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933053Ab1IIJF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 05:05:56 -0400
Received: by mail-gx0-f180.google.com with SMTP id 10so998727gxk.11
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 02:05:55 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1109091017300.2723@ionos>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

This is a multi-part message in MIME format.
--------------010300060004050802040203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Friday 09 September 2011 01:48 PM, Thomas Gleixner wrote:
> On Fri, 9 Sep 2011, Santosh wrote:
>> On Friday 09 September 2011 12:49 PM, Thomas Gleixner wrote:
>>>
>>> The flag says: MASK ON SUSPEND and it does not imply that you don't
>>> need a wake function. There might be cases where you want to setup
>>> stuff in that function in order to have the wakeup happen on that
>>> interrupt line despite of the mask on suspend.
>>>
>> I see your point.
>>
>>> We either need a separate flag or a global dummy set_wake function in
>>> the core to avoid empty copies all over the place.
>>>
>> A flag is probably better since you mentioned that on some arch, there
>> might be need to have actual set_wake() handler. Or if the global
>> dummy can be over-ridden by platform, that's fine too.
>
> Global dummy would mean:
>
> int irq_set_wake_dummy(...)
> {
> 	return 0;
> }
>
> And you just add it to your chip, but either way I don't care whether
> it's a dummy function or a flag.
>
Will below patch work for you then ?
Attaching the same in case mailer damages it.

Regards,
Santosh

 From d63d4347dc8fb144b19f4d4e7c0621397cccea94 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 9 Sep 2011 13:59:35 +0530
Subject: [PATCH] irq: Add IRQCHIP_SKIP_SET_WAKE flag to avoid need of 
dummy set_wake() handler.

Certain IRQCHIP's may not need to install the irq_set_wake() handler if
the IRQCHIP_MASK_ON_SUSPEND flag is set. But but if it's not implemented,
enable_irq_wake() will return an error.  That needs the IRQCHIP to install
an empty set_wake handler.

Add an 'IRQCHIP_SKIP_SET_WAKE' flag so that IRQCHIP can inform the core
irq code that irq_set_wake() handler is not necessary.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
  include/linux/irq.h |    2 ++
  kernel/irq/manage.c |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5951730..4b0d842 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -336,12 +336,14 @@ struct irq_chip {
   * IRQCHIP_MASK_ON_SUSPEND:	Mask non wake irqs in the suspend path
   * IRQCHIP_ONOFFLINE_ENABLED:	Only call irq_on/off_line callbacks
   *				when irq enabled
+ * IRQCHIP_SKIP_SET_WAKE:	Skip chip.irq_set_wake(), for this IRQCHIP
   */
  enum {
  	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
  	IRQCHIP_EOI_IF_HANDLED		= (1 <<  1),
  	IRQCHIP_MASK_ON_SUSPEND		= (1 <<  2),
  	IRQCHIP_ONOFFLINE_ENABLED	= (1 <<  3),
+	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
  };

  /* This include will go away once we isolated irq_desc usage to core 
code */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9b956fa..7e1a3ed 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -467,6 +467,9 @@ static int set_irq_wake_real(unsigned int irq, 
unsigned int on)
  	struct irq_desc *desc = irq_to_desc(irq);
  	int ret = -ENXIO;

+	if (irq_desc_get_chip(desc)->flags &  IRQCHIP_SKIP_SET_WAKE)
+		return 0;
+
  	if (desc->irq_data.chip->irq_set_wake)
  		ret = desc->irq_data.chip->irq_set_wake(&desc->irq_data, on);

-- 
1.7.4.1


--------------010300060004050802040203
Content-Type: text/x-patch;
 name="0001-irq-Add-IRQCHIP_SKIP_SET_WAKE-flag-to-avoid-need-of-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-irq-Add-IRQCHIP_SKIP_SET_WAKE-flag-to-avoid-need-of-.pa";
 filename*1="tch"

>From d63d4347dc8fb144b19f4d4e7c0621397cccea94 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 9 Sep 2011 13:59:35 +0530
Subject: [PATCH] irq: Add IRQCHIP_SKIP_SET_WAKE flag to avoid need of dummy set_wake() handler.

Certain IRQCHIP's may not need to install the irq_set_wake() handler if
the IRQCHIP_MASK_ON_SUSPEND flag is set. But but if it's not implemented,
enable_irq_wake() will return an error.  That needs the IRQCHIP to install
an empty set_wake handler.

Add an 'IRQCHIP_SKIP_SET_WAKE' flag so that IRQCHIP can inform the core
irq code that irq_set_wake() handler is not necessary.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |    2 ++
 kernel/irq/manage.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5951730..4b0d842 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -336,12 +336,14 @@ struct irq_chip {
  * IRQCHIP_MASK_ON_SUSPEND:	Mask non wake irqs in the suspend path
  * IRQCHIP_ONOFFLINE_ENABLED:	Only call irq_on/off_line callbacks
  *				when irq enabled
+ * IRQCHIP_SKIP_SET_WAKE:	Skip chip.irq_set_wake(), for this IRQCHIP
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
 	IRQCHIP_EOI_IF_HANDLED		= (1 <<  1),
 	IRQCHIP_MASK_ON_SUSPEND		= (1 <<  2),
 	IRQCHIP_ONOFFLINE_ENABLED	= (1 <<  3),
+	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
 };
 
 /* This include will go away once we isolated irq_desc usage to core code */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9b956fa..7e1a3ed 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -467,6 +467,9 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
 	struct irq_desc *desc = irq_to_desc(irq);
 	int ret = -ENXIO;
 
+	if (irq_desc_get_chip(desc)->flags &  IRQCHIP_SKIP_SET_WAKE)
+		return 0;
+
 	if (desc->irq_data.chip->irq_set_wake)
 		ret = desc->irq_data.chip->irq_set_wake(&desc->irq_data, on);
 
-- 
1.7.4.1


--------------010300060004050802040203--
