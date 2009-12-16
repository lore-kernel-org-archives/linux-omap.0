From: Tony Lindgren <tony@atomide.com>
Subject: Low level debugging using CONFIG_EARLY_PRINTK=y, omap-debug branch
 removed
Date: Tue, 15 Dec 2009 16:53:38 -0800
Message-ID: <20091216005337.GR4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49783 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758238AbZLPAxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 19:53:41 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1NKi96-0007iz-Fw
	for linux-omap@vger.kernel.org; Wed, 16 Dec 2009 00:53:40 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

Recent commit 93fd03a8c6728b58879f8af20ffd55d9c32a778b added
support for CONFIG_EARLY_PRINTK on ARM. Recent earlier kernels
should work too by applying the patch in the commit above.

This means we can now get rid of the old printk.c hack in the
omap-debug branch, so I've deleted that branch.

To use the earlyprintk, just do the following:

1. Make sure you have the necessary .config options set

CONFIG_DEBUG_LL=y
CONFIG_EARLY_PRINTK=y
CONFIG_OMAP_LL_DEBUG_UART1=y
# CONFIG_OMAP_LL_DEBUG_UART2 is not set
# CONFIG_OMAP_LL_DEBUG_UART3 is not set

The LL_DEBUG_UART above is typically 1, but it's 3 on Nokia
boards.

2. Edit the kernel CMDLINE in your .config to have "debug earlyprintk"

Optionally if you have a JTAG console, you can use CONFIG_DEBUG_ICEDCC
instead LL_DEBUG_UART.

I've also added these instructions to:

http://www.elinux.org/Debugging_OMAP_kernel

Regards,

Tony
