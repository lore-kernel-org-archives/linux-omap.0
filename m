From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 0/10] omap mailbox: Adding OMAP4 support
Date: Fri, 4 Sep 2009 17:16:57 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108E9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59459 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785AbZIDLqS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 07:46:18 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi All,
This is the series of patches adding OMAP4 support for omap mailbox driver. The patches are generated against tag (2.6.31-rc5). Functionality has been tested in OMAP4430. These patches also include various cleanup done in the omap mailbox.

File modified:

arch/arm/mach-omap2/Makefile
arch/arm/mach-omap2/devices.c
arch/arm/plat-omap/include/mach/omap44xx.h
arch/arm/plat-omap/mailbox.c
arch/arm/plat-omap/include/mach/mailbox.h
arch/arm/mach-omap2/mailbox.c


Regards
Subramaniam C A,
Ramesh Gupta . G
Kanigeri Hari