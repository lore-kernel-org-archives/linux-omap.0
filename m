From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/1] Group and resource assignments for TWL4030
Date: Fri, 27 Feb 2009 08:59:49 -0800
Message-ID: <20090227165949.GB11594@atomide.com>
References: <1234271495-11705-1-git-send-email-peter.de-schrijver@nokia.com> <200902131255.21379.david-b@pacbell.net> <20090215164851.GA19407@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63055 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757772AbZB0Q74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 11:59:56 -0500
Content-Disposition: inline
In-Reply-To: <20090215164851.GA19407@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: ext David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [090215 08:49]:
> On Fri, Feb 13, 2009 at 09:55:21PM +0100, ext David Brownell wrote:
> > On Tuesday 10 February 2009, Peter 'p2' De Schrijver wrote:
> > >
> > > This patch introduces support for board specific group assignments of TWL4030
> > > resources. The resource type and type2 fields can also be specified.
> > 
> > Do we have any real examples yet of needing to assign
> > resources to anything other than P1 (processor)?
> > 
> 
> Yes. On our custom hardware we use it to assign CLKEN to P3.

BTW, this should be discussed and integrated via the driver lists,
in this case that's Samuel Ortiz and LKML.

Regards,

Tony
