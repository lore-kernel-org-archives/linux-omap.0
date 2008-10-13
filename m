From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 7/7] omap3 evm, beagle and overo use the generic
	twl4030 script
Date: Mon, 13 Oct 2008 11:23:45 +0300
Message-ID: <20081013082345.GB4596@codecarver.research.nokia.com>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-7-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-8-git-send-email-peter.de-schrijver@nokia.com> <200810101050.29525.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60410 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879AbYJMIX5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 04:23:57 -0400
Content-Disposition: inline
In-Reply-To: <200810101050.29525.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 10, 2008 at 10:50:29AM -0700, ext David Brownell wrote:
> On Friday 10 October 2008, Peter 'p2' De Schrijver wrote:
> > +extern struct twl4030_power_data generic3430_t2scripts_data;
> 
> Such "extern" decls should as a rule be in header files...
> 
> In this case the rule is appropriate, since you've got the
> same decl in three different places.  That's about two times
> more often than I'm comfortable making exceptions to such a
> rule ... :)

Please suggest an appropriate header file. I couldn't find one and
creating a header file for a single extern declaration ?

Cheers,

Peter.

-- 
goa is a state of mind
