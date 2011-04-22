From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Fri, 22 Apr 2011 09:11:26 +0300
Message-ID: <20110422061126.GB16892@atomide.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
 <20110419062633.GA15620@atomide.com>
 <87r58w4gq3.fsf@ti.com>
 <20110421054221.GF5918@atomide.com>
 <87r58v3ab8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25246 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751569Ab1DVGLb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 02:11:31 -0400
Content-Disposition: inline
In-Reply-To: <87r58v3ab8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

* Kevin Hilman <khilman@ti.com> [110421 18:12]:
> Tony Lindgren <tony@atomide.com> writes:
> >
> > Saw that, looks good :) Need to post it also to lakml BTW.
> 
> Yeah, I only posted to l-o so far because it's not done.  I only removed
> a few of the #ifdef sections, there are still several more to do.

Oh I see. Anyways looks good to me. I can give it a try next week
too on few boards.

Regards,

Tony
