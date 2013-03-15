From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Fri, 15 Mar 2013 12:21:56 +0100
Message-ID: <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com>
 <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
 <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org>
 <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost> <51391F41.5000303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36327 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab3COLWR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Mar 2013 07:22:17 -0400
Received: by mail-ie0-f176.google.com with SMTP id k13so4135098iea.7
        for <linux-omap@vger.kernel.org>; Fri, 15 Mar 2013 04:22:17 -0700 (PDT)
In-Reply-To: <51391F41.5000303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 8, 2013 at 12:14 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 03/02/2013 02:05 PM, Grant Likely wrote:
>> On Tue, 26 Feb 2013 17:01:22 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
>>>
>>> On 02/26/2013 04:44 PM, Stephen Warren wrote:
>>>> On 02/26/2013 03:40 PM, Jon Hunter wrote:
>>>>> On 02/26/2013 04:01 AM, Javier Martinez Canillas wrote:
>>>>> Are you requesting the gpio anywhere? If not then this is not going to
>>>>> work as-is. This was discussed fairly recently [1] and the conclusion
>>>>> was that the gpio needs to be requested before we can use as an interrupt.
>>>>
>>>> That seems wrong; the GPIO/IRQ driver should handle this internally. The
>>>> Ethernet driver shouldn't know/care whether the interrupt it's given is
>>>> some form of dedicated interrupt or a GPIO-based interrupt, and even if
>>>> it somehow did, there's no irq_to_gpio() any more, so the driver can't
>>>> tell which GPIO ID it should request, unless it's given yet another
>>>> property to represent this.
>>>
>>> I agree that ideally this should be handled internally. Did you read the
>>> discussion on the thread that I referenced [1]? If you have any thoughts
>>> we are open to ideas :-)
>>
>> I'm on an airplane right now, but I agree 100% with Stephen. I'll try to
>> remember to go read that thread and respond, but this falls firmly in
>> the its-a-bug category for me.  :-)
>
> Grant, did you have chance to review the thread [1]?
>
> I am trying to figure out if we should just take the original patch
> proposed in the thread (although Linus had some objections) or look at
> alternative solutions such as adding a irq_chip request as Stephen
> suggested.
>
> Cheers
> Jon
>
> [1] comments.gmane.org/gmane.linux.ports.arm.omap/92192

Hello Grant,

I was wondering if you have any opinions on this issue. As Jon said,
Stephen proposed [2] to add a request callback to irq_chip.

I hacked a very simple and naive patch (just to validate the idea) and
is working. The GPIO bank is requested before calling the gpio-omap
.irq_set_type function handler (gpio_irq_type) when using a GPIO as an
IRQ on a DT. So is not necessary to call it explicitly anymore.

But the patch is obviously wrong (to say the least) since the kernel
runtime locking validator complains that "possible circular locking
dependency detected"

I just wanted to know if I was on the right track or completely lost here.

Thanks a lot and best regards,
javier

[2]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85592.html

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 159f5c5..f5feb43 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -807,6 +807,13 @@ static void gpio_unmask_irq(struct irq_data *d)
 	spin_unlock_irqrestore(&bank->lock, flags);
 }

+static int gpio_irq_request(struct irq_data *d)
+{
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+
+	return gpio_request(irq_to_gpio(bank, d->irq), "gpio-irq");
+}
+
 static struct irq_chip gpio_irq_chip = {
 	.name		= "GPIO",
 	.irq_shutdown	= gpio_irq_shutdown,
@@ -815,6 +822,7 @@ static struct irq_chip gpio_irq_chip = {
 	.irq_unmask	= gpio_unmask_irq,
 	.irq_set_type	= gpio_irq_type,
 	.irq_set_wake	= gpio_wake_enable,
+	.irq_request    = gpio_irq_request,
 };

 /*---------------------------------------------------------------------*/
diff --git a/include/linux/irq.h b/include/linux/irq.h
index bc4e066..2aeaa24 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -303,6 +303,7 @@ struct irq_chip {
 	void		(*irq_shutdown)(struct irq_data *data);
 	void		(*irq_enable)(struct irq_data *data);
 	void		(*irq_disable)(struct irq_data *data);
+	int             (*irq_request)(struct irq_data *data);

 	void		(*irq_ack)(struct irq_data *data);
 	void		(*irq_mask)(struct irq_data *data);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fa17855..07c20f7 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1093,6 +1093,13 @@ __setup_irq(unsigned int irq, struct irq_desc
*desc, struct irqaction *new)
 	if (!shared) {
 		init_waitqueue_head(&desc->wait_for_threads);

+		if (desc->irq_data.chip->irq_request) {
+			ret = desc->irq_data.chip->irq_request(&desc->irq_data);
+
+			if (ret)
+				goto out_mask;
+		}
+
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
 			ret = __irq_set_trigger(desc, irq,
