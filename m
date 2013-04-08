From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
Date: Mon, 08 Apr 2013 16:16:15 -0600
Message-ID: <516341AF.7030207@wwwdotorg.org>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk> <51633F26.7000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51392 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935124Ab3DHWQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 18:16:18 -0400
In-Reply-To: <51633F26.7000400@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 04/08/2013 04:05 PM, Rob Herring wrote:
> On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
>> According to Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> the "#interrupt-cells" property of an "interrupt-controller" is used
>> to define the number of cells needed to specify a single interrupt.
...
>> But the type is never returned so it can't be saved on the IRQ struct
>> resource flags member.
>>
>> This means that drivers that need the IRQ type/level flags defined in
>> the DT won't be able to get it.
> 
> But the interrupt controllers that need the information should be able
> to get to it via irqd_get_trigger_type. What problem exactly are you
> trying to fix? What driver would use this?

FYI, that is indeed what I did in sound/soc/codecs/wm8903.c. Thinking
back, I'm not sure if that was the right thing or whether I should have
sent this same patch:-)
