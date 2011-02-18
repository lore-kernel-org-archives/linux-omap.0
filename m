From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Have separate irq handlers for DISPC and
 DSI
Date: Fri, 18 Feb 2011 13:11:37 +0200
Message-ID: <1298027497.24062.53.camel@deskari>
References: <1297952702-13419-1-git-send-email-archit@ti.com>
	 <91F20383AC6A5F4DB94C692112281213B4C15EBB91@dlee07.ent.ti.com>
	 <4D5E3D35.9000902@ti.com> <1298023223.24062.24.camel@deskari>
	 <4D5E5275.4020002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40274 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719Ab1BRLLl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 06:11:41 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1IBBeOk007160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:11:40 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1IBBetn027391
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:11:40 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1IBBee9021351
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:11:40 -0600 (CST)
In-Reply-To: <4D5E5275.4020002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, 2011-02-18 at 05:05 -0600, Taneja, Archit wrote:
> Hi,
> 

<snip>

> One strange thing I see though is the increment with and without printks 
> in the irq handler in  both the cases. I always see increments of 2 when 
> I put prints. I see 3 when I don't. That's a bit peculiar.

Hmm. That's probably because prints make it slower. TE_TRIGGER and
VC0_IRQ probably happen at different times. If you have printks, they
are combined into one interrupt. If no printk, the code is faster and
handles them separately.

> Behavior looks as expected. I guess we can go without DSS_IRQSTATUS 
> then. Should I send out a patch? Also, should we remove DSS_IRQSTATUS in 
> totality from the code now?

Ok. Yes, please send a patch. Is DSS_IRQSTATUS used anywhere after the
patch? I guess not. But let's leave the define there, as the register
still exists.

 Tomi


