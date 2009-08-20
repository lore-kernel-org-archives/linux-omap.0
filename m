From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] ARM: OMAP4: Boot up crash 2.6.31-rc6
Date: Thu, 20 Aug 2009 21:54:23 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29BA4C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35297 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbZHTQYf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 12:24:35 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin/Tony,

This patch series addresses the OMAP4430 boot up crash issues on the latest 2.6.31-rc6 kernel release.

On the latest mainline as well as linux-omap master (2.6.31-rc6), OMAP4 boot is crashing. This has broken after "[PATCH 00/14] OMAP PM fixes for .31-rc series" series got merged in.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14527.html
 
Two issues -
1. NULL pointer dereference in omap_serial_init()-
static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS], has three instances populated and for OMAP4 macro OMAP_MAX_NR_PORTS=4. So at the fourth iteration, there is NULL pointer oops.
This was also related to the merge issue in the linux-next branch. 
http://lkml.org/lkml/2009/8/20/192

[PATCH 1/2] ARM: OMAP4: Fix NULL pointer dereference crash.

2. Console is not working because the uart platform data is not getting registered to kernel. Registration fails because of clock check failure in omap_serial_init(). As you aware the clock framework is still under review on mailing list. Hence below patch is necessary to fix the same.

[PATCH 2/2] ARM: OMAP4: Bypass the clock check.

Please review the same.

Thanks!!

Regards,
Santosh

