From: "Sudipta GHOSH" <sudipta.in@gmail.com>
Subject: omap display controller strange problem
Date: Thu, 20 Nov 2008 17:18:06 +0200
Message-ID: <9e6474ae0811200718t52b99d76m2e738254de770765@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:12678 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085AbYKTPSI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 10:18:08 -0500
Received: by ey-out-2122.google.com with SMTP id 6so206084eyi.37
        for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 07:18:06 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am facing a strange problem with omap display controller. (kernel 2.6.25)

in omap_dispc_irq_handler, if I use printk then only display is
working (initialization and refreshing)

else after few refresh ......its stop working.

static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
{
	....................

	if ((stat & dispc.enabled_irqs) && dispc.irq_callback) {
		printk("omap_irqH\n"); <---------------------------------------- ?????
		dispc.irq_callback(dispc.irq_callback_data);
	}


Regards,
-SG
