From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] [PATCH] OMAP: DMA: move LCD DMA related code from plat-omap
 to mach-omap1 (Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken
 when PM set)
Date: Wed, 25 Nov 2009 11:57:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911251152160.17998@utopia.booyaka.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200911211658.31404.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.0911230154230.26334@utopia.booyaka.com> <200911251454.49078.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33099 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759100AbZKYS5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 13:57:52 -0500
In-Reply-To: <200911251454.49078.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 25 Nov 2009, Janusz Krzysztofik wrote:

> Thanks for your review time.

Thank you for doing this work :-)

> Since I started with just duplicating files and then removing unnecessary
> sections, I wondered how I could split that work into several subsequent
> patches so it is more easy to verify how those chunks put into a new file
> differ from those extracted from the old one, but didn't find a good solution
> yet. 

Looking through the code, you've cleaned up several things that indicate 
that you've put some thought and care into doing it (e.g., all the 
cpu_class_is_omap1(), for example).  Plus, you mention that you've tested 
the code on OMAP1 and compile-tested on OMAP2.  So it seems fine to me 
after those two minor changes are made that I mentioned in the last 
E-mail.


- Paul
