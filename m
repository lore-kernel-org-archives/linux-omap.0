From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
Date: Thu, 11 Jun 2009 20:46:37 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0115CBC08A@dlee02.ent.ti.com>
References: <1244767784-22820-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41324 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbZFLBql convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 21:46:41 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5C1kcF7015034
	for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 20:46:43 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5C1kc2h006047
	for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 20:46:38 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5C1kcFE001835
	for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 20:46:38 -0500 (CDT)
In-Reply-To: <1244767784-22820-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Thursday, June 11, 2009 7:50 PM
> To: linux-omap@vger.kernel.org
> Cc: Pandita, Vikram
> Subject: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
> 
> 
> +	/* Get IRQ Trigger Flag */
> +	if (up->port.flags & UPF_IRQ_TRIG_RISING)
> +		irq_flags |= IRQF_TRIGGER_RISING;
> +	else if (up->port.flags & UPF_IRQ_TRIG_FALLING)
> +		irq_flags |= IRQF_TRIGGER_FALLING;
> +	else if (up->port.flags & UPF_IRQ_TRIG_HIGH)
> +		irq_flags |= IRQF_TRIGGER_HIGH;
> +	else if (up->port.flags & UPF_IRQ_TRIG_LOW)
> +		irq_flags |= IRQF_TRIGGER_LOW;
> +
Blame it on my dislike for nested if elseif, but...
irq_flags |= 
	(up->port.flags & UPF_IRQ_TRIG_RISING)? IRQF_TRIGGER_RISING :
	(up->port.flags & UPF_IRQ_TRIG_FALLING)? IRQF_TRIGGER_FALLING :
	(up->port.flags & IRQF_TRIGGER_HIGH)? IRQF_TRIGGER_HIGH :
	(up->port.flags & UPF_IRQ_TRIG_LOW)? IRQF_TRIGGER_LOW : 0;

Makes sense?

Regards,
Nishanth Menon
