From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap24xx is broken in current head
Date: Mon, 11 Aug 2008 17:50:53 +0300
Message-ID: <20080811145053.GL25784@atomide.com>
References: <20080810115818.GG7574@frodo> <20080810121655.GH7574@frodo> <C558C578-1F45-433E-B82F-F5667CEBAFAF@student.utwente.nl> <1218388936.24010.138.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53401 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYHKOvZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 10:51:25 -0400
Content-Disposition: inline
In-Reply-To: <1218388936.24010.138.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: ext Koen Kooi <k.kooi@student.utwente.nl>, me@felipebalbi.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Igor Stoppa <igor.stoppa@nokia.com> [080810 20:39]:
> On Sun, 2008-08-10 at 14:37 +0200, ext Koen Kooi wrote:
> 
> > "Broken as hell" if you want to do anything NEON related with it. 
> 
> yup
> Very unlucky but very true.
> > I  
> > use 2007q3 with the -Os fix for compiling omap3 kernels
> 
> Felipe: that's also what we should use internally, since it's the only
> one approved by our system performance team.

I'll revert this patch for now to avoid adding a compiler dependency
as we already have a pile of other issues to solve.

Let's plan on re-applying this patch once the other issues are out of
the way.

Tony
