From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch/rfc 2.6.29-rc6 2/2] regulator: twl4030 voltage
 enumeration (v2)
Date: Fri, 27 Feb 2009 21:26:33 +0000
Message-ID: <1235769993.31223.165.camel@vega.slimlogic.co.uk>
References: <200902081037.06645.david-b@pacbell.net>
	 <200902261602.58832.david-b@pacbell.net>
	 <1235737930.31223.117.camel@vega.slimlogic.co.uk>
	 <200902271239.44558.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:36636 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758748AbZB0V0j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Feb 2009 16:26:39 -0500
In-Reply-To: <200902271239.44558.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Fri, 2009-02-27 at 12:39 -0800, David Brownell wrote:
> On Friday 27 February 2009, Liam Girdwood wrote:

> > Sorry, this didn't apply. It looks like I'm missing an earlier patch(s)
> > here. Could you regenerate this and your core patch against latest
> > for-next.
> 
> The regulator -next tree seems to be missing a bunch of stuff...
> I generated this patch against a "twl4030-regulator.c" which I
> extracted *from that tree* yesterday.  But today it's different.
> 
> In this case, the current code doesn't have the $SUBJECT patch,
> which at that time you had applied.  But it does have a small
> snippet from that "minor patch"...
> 
> 
> Color me confused.  Are you asking for a "v3" of $SUBJECT, or
> is the "v2" going to re-appear? 

Applied the "v2".

>  And when will that -next tree
> acquire the rest of
> 
>  http://marc.info/?l=linux-kernel&m=123567791402469&w=2
> 

Applied and re-based this one into original patch.

Thanks

Liam

