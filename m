From: "Premi, Sanjeev" <premi@ti.com>
Subject: Section mismatch when compiling v2.6.23-rc3
Date: Thu, 14 Aug 2008 17:55:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593013CB56D10@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:34616 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbYHNMZw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 08:25:52 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7ECPiAf003514
	for <linux-omap@vger.kernel.org>; Thu, 14 Aug 2008 07:25:50 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7ECPigu017921
	for <linux-omap@vger.kernel.org>; Thu, 14 Aug 2008 17:55:44 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,
 
Just wondering if anyone saw this error:
 
WARNING: vmlinux.o(.data+0x10c8c): Section mismatch in reference from the variable contig_page_data to the variable .init.data:bootmem_node_data
The variable contig_page_data references
the variable __initdata bootmem_node_data
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
 
I was building for OMAP3EVM using Codesourcery 2008-q3.
 
Best regards,
Sanjeev
