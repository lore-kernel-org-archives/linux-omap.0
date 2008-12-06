From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP: Make dpll4_m4_ck programmable with
	clk_set_rate()
Date: Fri, 5 Dec 2008 17:10:29 -0800
Message-ID: <20081206011028.GU9714@atomide.com>
References: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com> <1224545064-25551-1-git-send-email-mans@mansr.com> <alpine.DEB.2.00.0812051650380.21247@utopia.booyaka.com> <20081206001153.GO9714@atomide.com> <alpine.DEB.2.00.0812051802280.21247@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56985 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbYLFBKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 20:10:32 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0812051802280.21247@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mans Rullgard <mans@mansr.com>, linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com

* Paul Walmsley <paul@pwsan.com> [081205 17:04]:
> On Fri, 5 Dec 2008, Tony Lindgren wrote:
> 
> > Pushing both to l-o tree today. Paul, I take it you will queue these
> > up for mainline via your clock series?
> 
> Yes, and that will go for any other clock patches that you push into l-o 
> between now and the time that I send that series to Russell.

OK, so I'll push the clock patches from Kevin's queue posted on Monday
to l-o, and then at some point we'll switch to your clock queue for
l-o tree.

Regards,

Tony
