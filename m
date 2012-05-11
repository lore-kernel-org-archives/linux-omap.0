From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: New OMAP build warning
Date: Fri, 11 May 2012 08:27:53 +0100
Message-ID: <20120511072753.GA6253@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55079 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab2EKH17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 03:27:59 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

arch/arm/plat-omap/usb.c: In function 'omap_otg_init':
arch/arm/plat-omap/usb.c:40: warning: unused variable 'status'

caused by:

commit eeb3711b89d68e147e05e7b43a49ecc5009dc157
Author: Paul Walmsley <paul@pwsan.com>
Date:   Fri Apr 13 06:34:32 2012 -0600

    ARM: OMAP2+: clean up some cppcheck warnings

