From: archit taneja <archit@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 13:33:52 +0530
Message-ID: <4D5A3368.8070801@ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com>	 <1297693307.2951.25.camel@deskari>	 <20110214143001.GK2549@legolas.emea.dhcp.ti.com> <1297755911.2289.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42959 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab1BOIDA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 03:03:00 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1F82vaj026500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 02:02:59 -0600
In-Reply-To: <1297755911.2289.28.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,


On Tuesday 15 February 2011 01:15 PM, Valkeinen, Tomi wrote:
<snip>

> I'm not familiar with genirq/irq_chip. But yes, as Archit said, we can
> mask/unmask DSS interrupts. I mean, there's only one interrupt line, but
> DSS has irqstatus and irqenable registers that can be used.
>
> If I understood correctly, irq_chip could be used to manage DSS and DSI
> interrupts, but I don't know right away what that would mean in
> practice, and would it make things easier or not. But this could be
> something that needs more study, as there's a custom isr handling system
> in DSS, and it would be nice if that could be replaced with genirq.
>
> But I guess the main problem still remains with genirqs also: we have
> one interrupt line on omap3, used by two separate modules. And one irq
> on omap2, used by one module, and two irqs on omap4, used by two
> modules.
>
>   Tomi

We actually have 4 interrupt lines on OMAP4, 1 for dispc, 2 for dsi1 and 
dsi2 and 1 for hdmi.

Regards,
Archit
