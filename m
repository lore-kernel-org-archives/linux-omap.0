From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/10] omap non-critical fixes for v3.5 merge window
Date: Fri, 11 May 2012 08:21:24 -0700
Message-ID: <20120511152123.GR21851@atomide.com>
References: <4fac0be2.e9a0320a.1f37.7e70SMTPIN_ADDED@mx.google.com>
 <CAOesGMi0+fty-x1kq0qo+msya=p5xyQDsB9iFrtht38Rn5V=Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20172 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab2EKPV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 11:21:29 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMi0+fty-x1kq0qo+msya=p5xyQDsB9iFrtht38Rn5V=Eg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

* Olof Johansson <olof@lixom.net> [120511 00:25]:
> Tony,
> 
> I've pulled all 10 requests. Many of them ended up going into the same
> next/ branch, but that's quite OK. Please double check my merge
> conflict resolutions.
> 
> One nit is that at least one of the branches had a few varying patch
> subjects, so just a friendly reminder to sanitize them to ARM: OMAP.*:
> or so when you apply patches.

Oops, sorry looks like I missed some of them. Usually I do fix those
up though, and had my scripts do that automatically when applying
from k.o patchwork earlier.

I'll add some checks to my scripts applying from mbox format too.
 
Regards,

Tony
