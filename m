From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [ARM][OMAP] TWL4030 IRQ
Date: Sat, 20 Jun 2009 20:54:54 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B51887CE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58719 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbZFTPZH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Jun 2009 11:25:07 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>

Just to brief you all, I came across a dead lock scenario on the arm-smp kernel. After discussing with Russell on mailing list, the actual bug seems be located in twl4030 IRQ implementation.

Initially I was suspecting the arm-generic area and hence didn't include linux-omap list in the mail thread

For more information on this issue, please read this email thread.
http://marc.info/?l=linux-arm-kernel&m=124550947525299&w=2

I will create a patch for "twl4030" and also would be correcting upcoming "twl6030" accordingly.

If anyone on this mailing list has any other opinion, please react to the email thread. 

Thanks !!

Regards,
Santosh
