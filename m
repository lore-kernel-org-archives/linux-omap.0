From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 0/3] Add OMAP hardware spinlock misc driver
Date: Mon, 18 Oct 2010 16:28:06 +0200
Message-ID: <AANLkTimYK_JVafj5XdN+d9O8h_qon17Jkw7LRpJVZvuO@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287406015.29097.1579.camel@twins> <20101018133502.GA12449@n2100.arm.linux.org.uk>
 <1287409417.29097.1598.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51972 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab0JRO3C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 10:29:02 -0400
In-Reply-To: <1287409417.29097.1598.camel@twins>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Oct 18, 2010 at 3:43 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> Right, so the problem is that there simply is no way to do atomic memory
> access from these auxiliary processing units wrt the main CPU?

Yes. There are a few relevant system-wide limitations, one of them is
that simply the system interconnect does not support those fancy
atomic operations.
