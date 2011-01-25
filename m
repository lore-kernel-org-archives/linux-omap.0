From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/14] ARM: bitops: ensure set/clear/change bitops take
 a word-aligned pointer
Date: Tue, 25 Jan 2011 11:50:39 -0800
Message-ID: <20110125195038.GR13589@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52055 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab1AYTvH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 14:51:07 -0500
Content-Disposition: inline
In-Reply-To: <E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:20]:
> Add additional instructions to our assembly bitops functions to ensure
> that they only operate on word-aligned pointers.  This will be necessary
> when we switch these operations to use the word-based exclusive
> operations.

If it's still not too late, we've had this in the testing branch
in the linux-omap tree for about a week now. So far no problems,
for me file systems tested have been ext3 and nfs.

Tested-by: Tony Lindgren <tony@atomide.com>
