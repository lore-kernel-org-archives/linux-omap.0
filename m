From: Felipe Balbi <balbi@ti.com>
Subject: OMAP4 panda gets stuck during reboot
Date: Wed, 5 Jan 2011 16:08:01 +0200
Message-ID: <20110105140801.GC2304@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51856 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751988Ab1AEOI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 09:08:29 -0500
Received: by mail-ew0-f54.google.com with SMTP id 24so7155305ewy.13
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 06:08:28 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

It seems like there's a bug on flush_pmd_entry() for multicore ARM CPUs.

I'm testing 2.6.37 with pandaboard and when running "reboot" it gets
stuck on:

asm("mcr	p15, 0, %0, c7, c10, 1	@ flush_pmd"
			: : "r" (pmd) : "cc");

I added a few printk()s around the code to find the specific spot where
the reset sequence was getting stuck and here's the output:

[  112.497253] ===> kernel_restart (line 312)
[  112.501525] ===> kernel_restart_prepare (line 294)
[  112.506561] ===> device_shutdown (line 1661)
[  112.511871] ===> device_shutdown (line 1692)
[  112.516387] ===> sysdev_shutdown (line 323)
[  112.520782] ===> sysdev_shutdown (line 349)
[  112.525146] ===> kernel_restart_prepare (line 299)
[  112.530181] Restarting system.
[  112.533386] ===> machine_restart (line 254)
[  112.537750] ===> machine_shutdown (line 232)
[  112.542236] ===> machine_shutdown (line 236)
[  112.546722] ===> arm_machine_restart (line 96)
[  112.551391] ===> setup_mm_for_reboot (line 1059)
[  112.556213] ===> setup_mm_for_reboot (line 1066)
[  112.561035] ===> setup_mm_for_reboot (line 1071)
[  112.565856] ===> flush_pmd_entry (line 522)

What could it be ? Any more debugging I could do to help ?

-- 
balbi
