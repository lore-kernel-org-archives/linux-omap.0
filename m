From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for
 GPT1
Date: Thu, 10 Mar 2011 07:45:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100744500.15132@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com> <alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com> <3b8b985f13158fbcd110cf45ed7035ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58033 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab1CJOpR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 09:45:17 -0500
In-Reply-To: <3b8b985f13158fbcd110cf45ed7035ad@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

On Thu, 10 Mar 2011, Santosh Shilimkar wrote:

> We continued further debug on the static dependency issues with
> OMAP4 PM series.
> So far from the findings what I have, this timer patch is actually not
> needed and can be dropped. Infact the patch is not really effective
> because current timer driver(not hwmod adapted yet) puts timer1
> in smart idle again.
> 
> There is another static dep. just like MPUSS<-->EMIF seems to create
> an issue. The lock-up is not very consistently reproducible so it's
> very easy to get miss-leading results. Timer patch was one of those
> observations. With or without timer patch I can reproduce the hang
> with long duration test.
> 
> Will keep narrowing down the next offending static dependency but
> in mean time I suggest you to drop this patch.

Okay, dropped.


- Paul
