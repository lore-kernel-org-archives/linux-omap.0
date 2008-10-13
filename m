From: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>
Subject: RE: disable_irq is broken in linux-omap-git
Date: Mon, 13 Oct 2008 21:31:18 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B02A16CA@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B020CBE5@dbde02.ent.ti.com>
 <5e088bd90810130851o1e3f7860tb0ff50fcbd83587a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38079 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755967AbYJMQBa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 12:01:30 -0400
In-Reply-To: <5e088bd90810130851o1e3f7860tb0ff50fcbd83587a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Steve Sakoman
Sent: Monday, October 13, 2008 9:21 PM
To: linux-omap@vger.kernel.org
Subject: Re: disable_irq is broken in linux-omap-git

It has been an empty function for more than a year and a half -- see
the following patch for the reason it was removed:

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=76d2160147f43f982dfe881404cfde9fd0a9da21

Ok, but it does not seem that OMAP tree supplies disable handler either - so disable_irq is not recommended ?

arch/arm/mach-omap2/irq.c

static struct irq_chip omap_irq_chip = {
           .name   = "INTC",
           .ack    = omap_mask_ack_irq,
           .mask   = omap_mask_irq,
           .unmask = omap_unmask_irq,
};

arch/arm/plat-omap/gpio.c

static struct irq_chip mpuio_irq_chip = {
         .name           = "MPUIO",
         .ack            = mpuio_ack_irq,
         .mask           = mpuio_mask_irq,
         .unmask         = mpuio_unmask_irq,
         .set_type       = gpio_irq_type,
#ifdef CONFIG_ARCH_OMAP16XX
         /* REVISIT: assuming only 16xx supports MPUIO wake events */
         .set_wake       = gpio_wake_enable,
#endif
};

static struct irq_chip gpio_irq_chip = {
         .name           = "GPIO",
         .shutdown       = gpio_irq_shutdown,
         .ack            = gpio_ack_irq,
         .mask           = gpio_mask_irq,
         .unmask         = gpio_unmask_irq,
         .set_type       = gpio_irq_type,
         .set_wake       = gpio_wake_enable,
};

Regards,
Pratheesh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

