From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 24/30] ARM: omap2+: ensure that one of omap2/3/4 is
 selected
Date: Mon, 3 Oct 2011 11:21:25 -0700
Message-ID: <20111003182124.GA6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <1317566760-25681-25-git-send-email-arnd@arndb.de>
 <4E89462D.7010208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23020 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab1JCSV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 14:21:28 -0400
Content-Disposition: inline
In-Reply-To: <4E89462D.7010208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111002 21:46]:
> On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> > Random configurations can fail if none of the omap families
> > in mach-omap2 is selected. This patch automatically selects
> > omap2 if the user has not made any other choice.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> 
> OMAP4 would have been a better default but am fine with
> OMAP2 too.
> 
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Hmm yeah then that would mean constant patching for the
latest omap.. So OMAP2 here makes the fastest build and
avoids having to update it on regular basis.

Acked-by: Tony Lindgren <tony@atomide.com>
