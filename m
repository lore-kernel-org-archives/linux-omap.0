From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
Date: Tue, 24 Jul 2012 14:52:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207241451580.10781@utopia.booyaka.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com> <87394wg97u.fsf@ti.com> <20120713064713.GI1122@atomide.com> <20120714085257.GB6522@atomide.com> <alpine.DEB.2.00.1207141150340.3876@utopia.booyaka.com> <20120716083609.GG6522@atomide.com>
 <alpine.DEB.2.00.1207180341001.16772@utopia.booyaka.com> <20120719115216.GP6522@atomide.com> <alpine.DEB.2.00.1207191242080.14390@utopia.booyaka.com> <20120724081636.GT6522@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59430 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab2GXUwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 16:52:49 -0400
In-Reply-To: <20120724081636.GT6522@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 24 Jul 2012, Tony Lindgren wrote:

> OK looks like Linus fixed up part of it, care to check what's needed
> against current mainline now?

Current mainline seems to be okay here.


- Paul
