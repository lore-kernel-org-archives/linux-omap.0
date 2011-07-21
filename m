From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Kconfig help descriptions
Date: Thu, 21 Jul 2011 10:22:21 +0100
Message-ID: <20110721092221.GA28942@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38239 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab1GUJW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 05:22:27 -0400
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1QjpSY-0003Zg-S4
	for linux-omap@vger.kernel.org; Thu, 21 Jul 2011 10:22:23 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1QjpSX-0000ed-J9
	for linux-omap@vger.kernel.org; Thu, 21 Jul 2011 10:22:21 +0100
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Some of the Kconfig help descriptions aren't very useful - for example:

| CONFIG_TWL4030_MADC:
| 
| This driver provides support for triton TWL4030-MADC. The
| driver supports both RT and SW conversion methods.
| 
| This driver can be built as a module. If so it will be
| named twl4030-madc

What is madc?  What does it do?  Do I enable it for the OMAP 4430SDP ?
