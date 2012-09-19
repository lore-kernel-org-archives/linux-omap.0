From: Gary Thomas <gary@mlbassoc.com>
Subject: Unknown L3 interrupt/error
Date: Wed, 19 Sep 2012 10:24:13 -0600
Message-ID: <5059F1AD.40008@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.mlbassoc.com ([65.100.170.105]:34718 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab2ISQbV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 12:31:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm trying to bring up a custom OMAP4 board and I get this
error as soon as the EHCI USB controller is initialized:
   WARNING: at /local/new_kernel/arch/arm/mach-omap2/omap_l3_noc.c:99 l3_interrupt_handler+0x114/0x174()
   L3 standard error: TARGET:ABE at address 0x0

Can someone enlighten me what this means and what might be
causing it?  That USB controller is working fine in U-Boot.

n.b. I'm working from the Ubuntu 12.04 kernel sources
   git://dev.omapzoom.org/pub/scm/integration/kernel-ubuntu.git ti-ubuntu-3.4-1485.7

Thanks for any pointers

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
