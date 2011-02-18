From: archit taneja <archit@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Have separate irq handlers for DISPC and
 DSI
Date: Fri, 18 Feb 2011 16:35:25 +0530
Message-ID: <4D5E5275.4020002@ti.com>
References: <1297952702-13419-1-git-send-email-archit@ti.com>	 <91F20383AC6A5F4DB94C692112281213B4C15EBB91@dlee07.ent.ti.com>	 <4D5E3D35.9000902@ti.com> <1298023223.24062.24.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795Ab1BRLEH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 06:04:07 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1IB43mA020454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:04:05 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1IB43MQ000724
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 16:34:03 +0530 (IST)
In-Reply-To: <1298023223.24062.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Friday 18 February 2011 03:30 PM, Valkeinen, Tomi wrote:


<snip>
> Well, if DSS_IRQSTATUS doesn't work as I described above, in the worst
> case we will just run a few more lines of code in the irq handler, as we
> check for registered interrupts. But that would only happen if either
> DISPC or DSI has no interrupts enabled, which is... never?
>
> So I think it should work fine anyway.
>
>   Tomi

I tried to read IRQSTATUS registers in 2 the cases:

With DSS_IRQSTATUS:

[   51.166503] DSS_IRQSTATUS 2 -> DSI
[   51.170135] DSS_IRQSTATUS 2 -> DSI
[   51.173095] DSI_IRQSTATUS 20001 -> TE_TRIGGER | VC0_IRQ
[   51.208282] DSS_IRQSTATUS 1 -> DISPC
[   51.211242] DISPC_IRQSTATUS 81
[   51.214508] DSS_IRQSTATUS 2 -> FRAMEDONE | GFX_END_WINDOW
[   51.217437] DSI_IRQSTATUS 20001 -> TE_TRIGGER | VC0_IRQ

The cat /proc/interrupts increments by 2 for every manual update call.

Without DSS_IRQSTATUS:


Doing a ./upd (from omapfb-tests) on 3430sdp with Taal:

[   77.060668] DISPC irqstatus 0
[   77.064270] DSI irqstatus 20001-> TE_TRIGGER | VC0_IRQ
[   77.104888] DISPC irqstatus 81 -> FRAMEDONE | GFX_END_WINDOW
[   77.108154] DSI irqstatus 20001 -> TE_TRIGGER | VC0_IRQ

VC0_IRQSTATUS came as 0x24 -> BTA_ACK | PACKET_SENT

The cat /proc/interrupts increments by 2 for every manual update call as 
before.

One strange thing I see though is the increment with and without printks 
in the irq handler in  both the cases. I always see increments of 2 when 
I put prints. I see 3 when I don't. That's a bit peculiar.

Behavior looks as expected. I guess we can go without DSS_IRQSTATUS 
then. Should I send out a patch? Also, should we remove DSS_IRQSTATUS in 
totality from the code now?

Archit
