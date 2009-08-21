From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] ARM: OMAP4: Boot up crash 2.6.31-rc6
Date: Fri, 21 Aug 2009 14:40:59 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29BE14@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40503 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147AbZHUJL3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 05:11:29 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

Russell,

On the mainline 2.6.31-rc6, OMAP4 boot is crashing. Also serial code in the linux-next branch isn't merge correctly and needs reworked patches. 

Can you please see if they are ok? 

This patch series addresses the OMAP4430 boot up crash issues on the latest 2.6.31-rc6 kernel release. They are generated against 2.6.31-rc6 
(commit= 6c30c53fd5ae6a99a23ad78e90c428d2c8ffb07f)
OMAP4 was broken after "[PATCH 00/14] OMAP PM fixes for .31-rc series" series got merged in.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14527.html
 
Two issues -
1. NULL pointer dereference in omap_serial_init()-
static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS], has three instances populated and for OMAP4 macro OMAP_MAX_NR_PORTS=4. So at the fourth iteration, there is NULL pointer oops.
This was also related to the merge issue in the linux-next branch. 
http://lkml.org/lkml/2009/8/20/192

	[PATCH 1/2] ARM: OMAP4: Fix NULL pointer dereference crash.

2. Console is not working because the uart platform data is not getting registered to kernel. Registration fails because of clock check failure in omap_serial_init(). As you aware the clock framework is still under review on mailing list. Hence below patch is necessary to fix the same.

	[PATCH 2/2] ARM: OMAP4: Bypass the clock check.

Thanks !!

Regards,
Santosh

