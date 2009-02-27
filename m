From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.29-rc6 2/2] regulator: twl4030 voltage enumeration (v2)
Date: Fri, 27 Feb 2009 12:39:44 -0800
Message-ID: <200902271239.44558.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902261602.58832.david-b@pacbell.net> <1235737930.31223.117.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n13a.bullet.mail.mud.yahoo.com ([68.142.207.51]:46947 "HELO
	n13a.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761334AbZB0Ujs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Feb 2009 15:39:48 -0500
In-Reply-To: <1235737930.31223.117.camel@vega.slimlogic.co.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Friday 27 February 2009, Liam Girdwood wrote:
> On Thu, 2009-02-26 at 16:02 -0800, David Brownell wrote:
> > On Thursday 26 February 2009, Liam Girdwood wrote:
> > > > 
> > > > Note that the twl4030 regulator patch referred to will need a
> > > > minor patch to work with the -next tree, because of interface
> > > > change in the regulator framework.
> > > 
> > > Applied.
> > 
> > .... and here's that "minor patch".
> > 
> > ...
> 
> Sorry, this didn't apply. It looks like I'm missing an earlier patch(s)
> here. Could you regenerate this and your core patch against latest
> for-next.

The regulator -next tree seems to be missing a bunch of stuff...
I generated this patch against a "twl4030-regulator.c" which I
extracted *from that tree* yesterday.  But today it's different.

In this case, the current code doesn't have the $SUBJECT patch,
which at that time you had applied.  But it does have a small
snippet from that "minor patch"...


Color me confused.  Are you asking for a "v3" of $SUBJECT, or
is the "v2" going to re-appear?  And when will that -next tree
acquire the rest of

 http://marc.info/?l=linux-kernel&m=123567791402469&w=2

Having only the driver.h part of that patch breaks things
(your 0ae0e667c8a2bacfe066b90f8f2ee3b4a83a120d).

- Dave


