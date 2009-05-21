From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM: SDRC: ensure mux of SDRC clock enable pins
 for self-refresh
Date: Thu, 21 May 2009 17:46:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905211739270.26015@utopia.booyaka.com>
References: <1242835699-11113-1-git-send-email-khilman@deeprootsystems.com>  <alpine.DEB.2.00.0905211635560.26015@utopia.booyaka.com> <f476eb440905211617y3ccf85f7i7fff7f7cad147fed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44433 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbZEUXqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 19:46:16 -0400
In-Reply-To: <f476eb440905211617y3ccf85f7i7fff7f7cad147fed@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mikechan@google.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, r-woodruff2@ti.com, linux-omap@vger.kernel.org

On Thu, 21 May 2009, Mike Chan wrote:

> On Thu, May 21, 2009 at 3:37 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > would suggest keeping pin remuxing in board-*.c or maybe chip-*.c files;
> > ideally this file would only pertain to the SDRC IP block itself.
> 
> Is there a reason why any board-*.c would not want this? It seems a
> little silly for everyone to be doing the same repetitive pin muxing
> if they want to suspend properly for a reasonable amount of time.

I suspect you are asking a slightly different question, which is, "why 
shouldn't this pin muxing go in sdrc.c".  The reason is because the pin 
muxing API we have is chip- and package-specific.  This sdrc.c file 
shouldn't contain any chip- or package-specific information.  Whether it 
goes into board-*.c or into a chip- or package-specific file is another 
question.

Richard's earlier E-mail covered the answer to your literal question.  It 
seems wisest for boards that don't use SDRC_CKE1 to keep it in safe mode.


- Paul
