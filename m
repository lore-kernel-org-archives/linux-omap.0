From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Latest config warning
Date: Fri, 7 Jan 2011 11:35:06 +0000
Message-ID: <20110107113506.GK1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44492 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab1AGLfL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 06:35:11 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PbAb5-0001av-Q4
	for linux-omap@vger.kernel.org; Fri, 07 Jan 2011 11:35:08 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PbAb4-0006K1-K9
	for linux-omap@vger.kernel.org; Fri, 07 Jan 2011 11:35:06 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

warning: (ARCH_STMP3XXX && <choice> || ARCH_OMAP3 && ARCH_OMAP2PLUS) selects USB_ARCH_HAS_EHCI which has unmet direct dependencies (USB_SUPPORT)

This didn't happen with 2.6.37.  Maybe a missing select USB_SUPPORT
somewhere?
