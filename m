From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v2] Consolidate SRAM support
Date: Tue, 19 Apr 2011 17:18:46 +0100
Message-ID: <20110419161846.GB24972@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <20110418085259.GA26044@n2100.arm.linux.org.uk> <20110419160135.GA4204@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50913 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1DSQTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 12:19:12 -0400
Content-Disposition: inline
In-Reply-To: <20110419160135.GA4204@game.jcrosoft.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Apr 19, 2011 at 06:01:35PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Hi,
> 
> 	I do post a patch to add the support to specify a virt and phys
> 	address to the generic allocator so the pv-pool.c is not needed
> 	we can just use the generic fucntion

You've talked about this before in the thread, but the patch never appeared.
