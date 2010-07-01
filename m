From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: wait on IDLEST after enabling USBTLL fclk
Date: Thu, 1 Jul 2010 10:48:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007011048020.1550@utopia.booyaka.com>
References: <1273127288-21590-1-git-send-email-gadiyar@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032358E85A@dbde02.ent.ti.com> <alpine.DEB.2.00.1006211540100.1550@utopia.booyaka.com> <alpine.DEB.2.00.1006231819420.1550@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032366AE2A@dbde02.ent.ti.com> <alpine.DEB.2.00.1006240028140.1550@utopia.booyaka.com> <20100701105259.GK2822@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51471 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab0GAQsN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 12:48:13 -0400
In-Reply-To: <20100701105259.GK2822@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 1 Jul 2010, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [100624 09:22]:
> > Hi Tony,
> > 
> > what do you think on this one?  -rc or .36?
> 
> If we want to try to get it into the -rc cycle, the description
> should mention what it fixes and show the error. Otherwise it might
> be hard to argue this is a real fix or a regression.

Thanks, I'll queue it for .36.

- Paul
