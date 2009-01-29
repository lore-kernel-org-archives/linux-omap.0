From: Pavel Machek <pavel@suse.cz>
Subject: Re: lowmemory android driver not needed?
Date: Thu, 29 Jan 2009 23:06:33 +0100
Message-ID: <20090129220633.GA18603@elf.ucw.cz>
References: <2f11576a0901160518g52a3e70endc98fe4792a98b9b@mail.gmail.com> <d6200be20901212213x1069762cpd377d04bc5a04a91@mail.gmail.com> <20090128234209.A949.KOSAKI.MOTOHIRO@jp.fujitsu.com> <d6200be20901281851k45f9692em1379140c8951c195@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49668 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbZA2WGp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 17:06:45 -0500
Content-Disposition: inline
In-Reply-To: <d6200be20901281851k45f9692em1379140c8951c195@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Swetland <swetland@google.com>, arve@google.com, San Mehat <san@android.com>, Robert Love <rlove@google.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, ext Juha Yrj?????? <juha.yrjola@solidboot.com>, viktor.rosendahl@nokia.com, Trilok Soni <soni.trilok@gmail.com>

Hi!

> I never expected it to be merged. I wrote it to allow us to ship a product.
> 
> > The top problem is, this file stay on non proper place.
> > then, MM folks don't review at all.
> >
> > I think this patch need to receive MM folks review.
> 
> This patch solves two problems for us:
> 1. It gives us more control over which process gets killed when we run
> out of memory. This can easily be fixed in the regular oom killer
> instead.
> 2. It prevents the system from getting unusable due to excessive
> demand paging. Before we added the low memory killer, we had devices
> stuck for many minutes before the system managed to allocate enough
> memory for the oom killer to kick in.
> The second problem is the most critical and if it is solved, we will
> not need this patch.

Ok, maybe the best way forward is to create a "demo" that can be run
on desktop machine, where machine misbehaves (like becomes useless for
10 minutes before OOM killer kicks in), then draw attetion of
Andrew/Nick/etc?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
