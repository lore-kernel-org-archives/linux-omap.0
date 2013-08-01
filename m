From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [FAILURE] omap4430-sdp allnoconfig
Date: Thu, 1 Aug 2013 18:52:14 +0100
Message-ID: <20130801175214.GA23053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39592 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3HARzt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Aug 2013 13:55:49 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

My allnoconfig fails with this error:

arch/arm/mach-omap2/built-in.o: In function `omap4_local_timer_init':
dss-common.c:(.init.text+0x1d90): undefined reference to `twd_local_timer_register'

Might be worth looking into whatever's missing?
