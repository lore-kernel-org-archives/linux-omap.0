From: Kumar Gala <galak@kernel.crashing.org>
Subject: defconfig for panda
Date: Thu, 29 Mar 2012 14:21:56 -0500
Message-ID: <1F91D012-8308-45BB-83AD-90E52D472AC2@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45686 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646Ab2C2TV7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 15:21:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>

As I'm new to the OMAP community this might be a stupid question but trying to just build and run a stock v3.3 kernel on a pandaboard.  In doing so it seems as if some basic drivers are not enabled in omap2plus_defconfig for the board.  I'm trying to figure out if this is normal for some reason or just an oversight.

For example, USB and USB ethernet (SMC95xx).  I notice the linaro kernel tree introduces an omap4_defconfig, so just wondering should I send patches to omap2plus_defconfig or what?

thanks

- k