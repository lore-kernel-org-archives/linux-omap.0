From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: omap display controller strange problem
Date: Thu, 20 Nov 2008 20:54:27 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E8E67B9A@dbde02.ent.ti.com>
References: <9e6474ae0811200718t52b99d76m2e738254de770765@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48310 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477AbYKTPYi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 10:24:38 -0500
In-Reply-To: <9e6474ae0811200718t52b99d76m2e738254de770765@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sudipta GHOSH <sudipta.in@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sudipta GHOSH
> Sent: Thursday, November 20, 2008 8:48 PM
> To: linux-omap@vger.kernel.org
> Subject: omap display controller strange problem
> 
> Hi,
> 
> I am facing a strange problem with omap display controller. (kernel
> 2.6.25)
> 
> in omap_dispc_irq_handler, if I use printk then only display is
> working (initialization and refreshing)
> 
[Hiremath, Vaibhav] What do you mean by "only display"?

Can you please provide detailed information about the issue? Your mail doesn't convey much.

> else after few refresh ......its stop working.
> 
> static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
> {
> 	....................
> 
> 	if ((stat & dispc.enabled_irqs) && dispc.irq_callback) {
> 		printk("omap_irqH\n"); <--------------------------------
> -------- ?????
> 		dispc.irq_callback(dispc.irq_callback_data);
> 	}
> 
> 
> Regards,
> -SG
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

