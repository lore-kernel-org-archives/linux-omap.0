From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [ANNOUNCE:RFC] convert OMAP to use clkdev
Date: Mon, 26 Jan 2009 18:00:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0901261758281.15648@utopia.booyaka.com>
References: <20090124120317.GA20593@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47095 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbZA0BAU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 20:00:20 -0500
In-Reply-To: <20090124120317.GA20593@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

On Sat, 24 Jan 2009, Russell King - ARM Linux wrote:

> In a bid to clean up the clk API implementations, and more importantly
> ensure that implementations are using the clk API correctly, I've
> converted OMAP over to the generic clock lookup (clkdev) implementation.

I have some comments on this proposal; I will post them after the clock 
update series have been sent to the lists.


- Paul
