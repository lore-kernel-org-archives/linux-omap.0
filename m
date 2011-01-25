From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to
 use ldrex/strex
Date: Tue, 25 Jan 2011 11:51:18 -0800
Message-ID: <20110125195118.GS13589@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53607 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab1AYTvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 14:51:38 -0500
Content-Disposition: inline
In-Reply-To: <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:23]:
> Switch the set/clear/change bitops to use the word-based exclusive
> operations, which are only present in a wider range of ARM architectures
> than the byte-based exclusive operations.

This too been in use for about a week now with ext3 and nfs:

Tested-by: Tony Lindgren <tony@atomide.com>
