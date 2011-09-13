From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/25] ARM: mm: Add strongly ordered descriptor support.
Date: Tue, 13 Sep 2011 13:23:17 -0700
Message-ID: <20110913202317.GE24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51249 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932471Ab1IMUXX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 16:23:23 -0400
Content-Disposition: inline
In-Reply-To: <1315144466-9395-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Woodruff Richard <r-woodruff2@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:22]:
> On certain architectures, there might be a need to mark certain
> addresses with strongly ordered memory attributes to avoid ordering
> issues at the interconnect level.

This is something Russell needs to look.

You might want to also read the mailing list archives regarding the
strongly ordered access.

Basically it still won't guarantee that the write gets to the
device, only a read back from the device in question guarantees
that at the bus level.

Regards,

Tony 
