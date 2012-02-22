From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Latest OMAP randconfig build error
Date: Wed, 22 Feb 2012 08:51:30 +0000
Message-ID: <20120222085130.GE22675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57665 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab2BVIvf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 03:51:35 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:55541)
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1S07v9-00037n-Od
	for linux-omap@vger.kernel.org; Wed, 22 Feb 2012 08:51:32 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1S07v8-0005ta-HY
	for linux-omap@vger.kernel.org; Wed, 22 Feb 2012 08:51:30 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

arch/arm/mach-omap2/mailbox.c: In function 'omap2_mbox_probe':
arch/arm/mach-omap2/mailbox.c:354: error: 'omap2_mboxes' undeclared (first use in this function)
arch/arm/mach-omap2/mailbox.c:354: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/mailbox.c:354: error: for each function it appears in.)

There's also these warnings:

arch/arm/mach-omap2/omap-wakeupgen.c:181: warning: 'wakeupgen_irqmask_all' defined but not used

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x7878): Section mismatch in reference from the function sr_dev_init() to the function .init.text:sr_set_nvalues()
The function sr_dev_init() references
the function __init sr_set_nvalues().
This is often because sr_dev_init lacks a __init
annotation or the annotation of sr_set_nvalues is wrong.

Config is at the usual place.
