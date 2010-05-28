From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 20:16:20 +0200
Message-ID: <1275070580.1645.379.camel@laptop>
References: <20100528114123.GA22947@srcf.ucam.org>
	 <4BFFB681.1000105@nokia.com>
	 <AANLkTim04ZfMcPHRB2D_bqcAuguaGwySH2b6repuYLkk@mail.gmail.com>
	 <4BFFC5DF.5030504@nokia.com> <20100528133900.GG26177@thunk.org>
	 <4BFFCFC7.7070302@nokia.com> <20100528142124.GA26733@srcf.ucam.org>
	 <AANLkTilj6i7Qi-eh7e3WWeh4zxKALqr-0yhAvWKis52t@mail.gmail.com>
	 <20100528160628.7c121dab@lxorguk.ukuu.org.uk>
	 <AANLkTin3suKfGBSfiDj0n8ztY8UiHzr4af_Cr0SPOevY@mail.gmail.com>
	 <20100528172713.GA7444@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:48178 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab0E1SQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 14:16:24 -0400
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.71 #1 (Red Hat Linux))
	id 1OI46Z-0007Zi-QN
	for linux-omap@vger.kernel.org; Fri, 28 May 2010 18:16:23 +0000
In-Reply-To: <20100528172713.GA7444@gibbs.hungrycats.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>
Cc: Brian Swetland <swetland@google.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, Igor Stoppa <igor.stoppa@nokia.com>, tytso@mit.edu, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Fri, 2010-05-28 at 13:27 -0400, Zygo Blaxell wrote:
> From my reading of this thread, there's a lot of overlap between
> suspendblockers and constraints.  Many use cases are served equally
> well with one or the other, 

If using suspend-blockers, 

Please explain to me how:

- I will avoid the cpu going into some idle state for which the wakeup
latency is larger than my RT app fancies?

- to avoid some tasks from being serviced by the filesystems whilst
others are? (ionice on steroids).

- does my sporadic task (with strict bandwidth budget) not suffer
bandwidth inversion?


suspend blockers do a bit of each of that, but none of it in a usable
fashion.

