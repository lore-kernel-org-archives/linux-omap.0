From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 0/1] Group and resource assignments for TWL4030
Date: Wed, 4 Mar 2009 16:41:21 +0200
Message-ID: <20090304144121.GA2944@codecarver.research.nokia.com>
References: <1234271495-11705-1-git-send-email-peter.de-schrijver@nokia.com> <20090215164851.GA19407@codecarver.research.nokia.com> <20090227165949.GB11594@atomide.com> <200903031538.16757.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53317 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbZCDOlw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 09:41:52 -0500
Content-Disposition: inline
In-Reply-To: <200903031538.16757.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Mar 04, 2009 at 12:38:16AM +0100, ext David Brownell wrote:
> On Friday 27 February 2009, Tony Lindgren wrote:
> > * Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [090215 08:49]:
> > > On Fri, Feb 13, 2009 at 09:55:21PM +0100, ext David Brownell wrote:
> > > > On Tuesday 10 February 2009, Peter 'p2' De Schrijver wrote:
> > > > >
> > > > > This patch introduces support for board specific group assignments of TWL4030
> > > > > resources. The resource type and type2 fields can also be specified.
> > > > 
> > > > Do we have any real examples yet of needing to assign
> > > > resources to anything other than P1 (processor)?
> > > 
> > > Yes. On our custom hardware we use it to assign CLKEN to P3.
> 
> P3 roughly translating to "system running", with
> no regard to whether ARM(s) or DSP are active, yes?
> 

Depends on the board. We use P3 to control the system oscillator. The
SYSCLK_REQ output of OMAP3 is wired to the CLKREQ input on the TWL4030.
OMAP3 will disable SYSCLK_REQ when the system clock is no longer
necessary. (Eg, when going to chip retention).  This obviously only works if
CLKEN is only in P3.  (Otherwise it won't be turned off as P1 is still
active). A similar setup is used on the TI SDP3430 board.

Cheers,

Peter.

-- 
goa is a state of mind
