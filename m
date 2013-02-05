From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Latest additional build warnings
Date: Tue, 5 Feb 2013 14:22:18 +0000
Message-ID: <20130205142218.GB17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35773 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab3BEOW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 09:22:27 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, arm@kernel.org, Tony Lindgren <tony@atomide.com>

arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used

