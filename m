From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v2] Consolidate SRAM support
Date: Wed, 20 Apr 2011 00:20:38 +0100
Message-ID: <20110419232038.GC24972@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <20110418085259.GA26044@n2100.arm.linux.org.uk> <20110419160135.GA4204@game.jcrosoft.org> <20110419161846.GB24972@n2100.arm.linux.org.uk> <20110419190557.GB4204@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41666 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab1DSXVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 19:21:12 -0400
Content-Disposition: inline
In-Reply-To: <20110419190557.GB4204@game.jcrosoft.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Apr 19, 2011 at 09:05:57PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:18 Tue 19 Apr     , Russell King - ARM Linux wrote:
> > On Tue, Apr 19, 2011 at 06:01:35PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > Hi,
> > > 
> > > 	I do post a patch to add the support to specify a virt and phys
> > > 	address to the generic allocator so the pv-pool.c is not needed
> > > 	we can just use the generic fucntion
> > 
> > You've talked about this before in the thread, but the patch never appeared.
> I forget to re-send it sorry
> it's the mm tree

One obvious issue here is that you're using 'unsigned long' for phys
addresses.  With LPAE we could start seeing SRAM outside of the 4GB
PA range, and so would need this to be phys_addr_t.
