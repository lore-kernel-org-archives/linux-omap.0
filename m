From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Mon, 1 Oct 2012 06:28:44 -0700
Message-ID: <20121001132844.GA2558@linux.vnet.ibm.com>
References: <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <20120920232114.GO2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
 <20120921185827.GC2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
 <20120921195717.GD2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209221836070.10663@utopia.booyaka.com>
 <20120922201043.GE2934@linux.vnet.ibm.com>
 <20120922215923.GA13161@linux.vnet.ibm.com>
 <CACRpkdb2f18vwv9qXZkypPxM4UwyeTrDs4+JnpFtYRCzADzFPQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:52435 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab2JAN3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 09:29:32 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-omap@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 1 Oct 2012 07:29:23 -0600
Content-Disposition: inline
In-Reply-To: <CACRpkdb2f18vwv9qXZkypPxM4UwyeTrDs4+JnpFtYRCzADzFPQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, "Bruce, Becky" <bbruce@ti.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>, fweisbec@gmail.com

On Mon, Oct 01, 2012 at 10:55:11AM +0200, Linus Walleij wrote:
> On Sat, Sep 22, 2012 at 11:59 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> 
> > rcu: Fix day-one dyntick-idle stall-warning bug
> 
> As mentioned in another thread this solves the same problem for ux500.
> Reported/Tested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> But now it appears that this commit didn't make it into v3.6 so
> it definately needs to be tagged with Cc: stable@kernel.org
> before it gets merged since the stall warnings are kinda scary.

Ingo submitting this to Linus Torvalds earlier today, so we should be
able to send to stable shortly.

							Thanx, Paul

