From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
Date: Tue, 09 Apr 2013 00:56:31 +0200
Message-ID: <51634B1F.4030408@collabora.co.uk>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk> <51633F26.7000400@gmail.com> <516341AF.7030207@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60143 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934888Ab3DHW4e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 18:56:34 -0400
In-Reply-To: <516341AF.7030207@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Rob Herring <robherring2@gmail.com>, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 04/09/2013 12:16 AM, Stephen Warren wrote:
> On 04/08/2013 04:05 PM, Rob Herring wrote:
>> On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
>>> According to Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>> the "#interrupt-cells" property of an "interrupt-controller" is used
>>> to define the number of cells needed to specify a single interrupt.
> ...
>>> But the type is never returned so it can't be saved on the IRQ struct
>>> resource flags member.
>>>
>>> This means that drivers that need the IRQ type/level flags defined in
>>> the DT won't be able to get it.
>> 
>> But the interrupt controllers that need the information should be able
>> to get to it via irqd_get_trigger_type. What problem exactly are you
>> trying to fix? What driver would use this?
> 
> FYI, that is indeed what I did in sound/soc/codecs/wm8903.c. Thinking
> back, I'm not sure if that was the right thing or whether I should have
> sent this same patch:-)
> 

Hi Stephen,

I'm glad you agree :-)

I could change drivers/net/ethernet/smsc/smsc911x.c to get the type flags for
the IRQ with irqd_get_trigger_type() but I prefer $subject because:

a) This works in the non-DT case with board files and filling the resources from
platform data in arch/arm/mach-omap2/gpmc-smsc911x.c. So this is definitely a
bug on the DT core.

b) I don't see why of_irq_to_resource() should discard the type/level flags when
filling the IORESOURCE_IRQ if it was specified on the DT.

c) We will have to change all drivers that expect to get the IRQ type flags from
a IORESOURCE_IRQ struct resource.

Thanks a lot and best regards,
Javier
