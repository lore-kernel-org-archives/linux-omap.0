From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: Add conditional compilation for board
 specific init functions
Date: Thu, 3 Nov 2011 12:16:09 -0700
Message-ID: <20111103191609.GW31337@atomide.com>
References: <1318629618-5313-1-git-send-email-martinez.javier@gmail.com>
 <CAM9fjH6TZnAWAPvp8Uvr4hHpf77CeRz3k=hv6FGN73X1aXTXQQ@mail.gmail.com>
 <CAAwP0s3UOr9kaEmE-kVx8qExGexHkSkN=eNa1RB8veQ9wBBkug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43261 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933862Ab1KCTQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 15:16:11 -0400
Content-Disposition: inline
In-Reply-To: <CAAwP0s3UOr9kaEmE-kVx8qExGexHkSkN=eNa1RB8veQ9wBBkug@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Kyle Manna <kyle.manna@gmail.com>, linux-omap@vger.kernel.org

* Javier Martinez Canillas <martinez.javier@gmail.com> [111018 12:27]:
> On Tue, Oct 18, 2011 at 8:36 PM, Kyle Manna <kyle.manna@gmail.com> wrote:
> > Looks like you're missing one more section for OMAP3. Will reply with
> > a complete patch I was about to submit.
> >
> 
> Yes, I added all the ones I need to compile my board correctly, but I
> could have missed one of them.
> 
> Perfect, feel free to add this fix on your patch.

FYI, I've applied this patch to fix this issue:

http://marc.info/?l=linux-omap&m=132034503812225&w=2

Regards,

Tony
