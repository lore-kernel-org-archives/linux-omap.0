From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
Date: Wed, 18 Nov 2009 12:11:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911181202380.9248@utopia.booyaka.com>
References: <20091116133237.14128.39687.stgit@localhost.localdomain> <20091116133654.14128.175.stgit@localhost.localdomain> <20091116140830.GA31522@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0911171036430.27682@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA689E6A@dbde02.ent.ti.com> <20091117222409.GH29266@atomide.com> <20091118184740.GQ29266@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57349 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758305AbZKRTK5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:10:57 -0500
In-Reply-To: <20091118184740.GQ29266@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?ISO-8859-15?Q?Juha_Lepp=E4nen?= <juha_motorsportcom@luukku.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 18 Nov 2009, Tony Lindgren wrote:

> To me it sounds like this can wait until the merge window,
> so not adding to omap-fixes for now.

Indeed, there's no rush on this one, so let's set it up for 2.6.33.
I'll keep that macro in plat/system.h unless you or Russell have a better 
suggestion.  It might be worth looking at the rest of the Linux codebase 
to see if there are other potential users; maybe someone might be willing 
to pick up a "kernel-janitor" task for this?

Vikram, I agree with your comment.  Maybe someone can send a patch to 
clean up ehci-hcd.c and any other users of the same idiom to use this 
macro for 2.6.33?  Looks like also plat-omap/mailbox.c:__mbox_msg_send() 
and mach-omap2/powerdomain.c:pwrdm_wait_transition() would be good 
candidates for this, under arch/arm/*omap*.


- Paul
