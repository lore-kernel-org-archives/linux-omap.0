From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/10] ARM: OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
Date: Mon, 6 Oct 2008 16:09:04 +0100
Message-ID: <20081006150903.GA27466@flint.arm.linux.org.uk>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163749.15385.75147.stgit@localhost.localdomain> <20081004131911.GA5674@flint.arm.linux.org.uk> <alpine.DEB.2.00.0810060848470.354@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52825 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYJFPJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 11:09:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0810060848470.354@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, Oct 06, 2008 at 08:52:46AM -0600, Paul Walmsley wrote:
> OK.  Tony's tree contains some patches which thoroughly clean this 
> function up, but they are large.  Would you like me to send those along 
> with this patch set, or would you prefer that I just drop this part of the 
> patch and repost?

Probably the most productive solution is to drop that part and repost.

However, my thoughts from looking over the existing clock code is that,
at some point, I'd like to rewrite the entire OMAP clk code to get rid
of stuff like this.  Realistically, I'm scared to do so - the current
implementation is very complex that getting a proper overview is rather
difficult...
