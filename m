From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc7 regulator-next] regulator: refcount fixes
Date: Thu, 12 Mar 2009 15:02:55 -0800
Message-ID: <200903121602.55570.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <200903121335.25368.david-b@pacbell.net> <20090312210545.GJ24376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n10.bullet.mail.mud.yahoo.com ([209.191.125.208]:32993 "HELO
	n10.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752461AbZCLXC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Mar 2009 19:02:59 -0400
In-Reply-To: <20090312210545.GJ24376@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thursday 12 March 2009, Mark Brown wrote:
> On Thu, Mar 12, 2009 at 12:35:24PM -0800, David Brownell wrote:
> > On Thursday 12 March 2009, Mark Brown wrote:
> 
> > > safely share a regulator without extra work since they have no way of
> > > telling why a regulator is in the state that it's in without extra
> > > stuff.
> 
> > Depends what you mean by "safely".  If they weren't buggy
> > already, I don't see how they'd notice any difference.
> > Having buggy consumers become non-buggy isn't exactly a
> > job for the framework itself.
> 
> Previously the per-consumer reference count would've meant that they
> couldn't interfere with other consumers - they could set their own
> state but not reverse an enable something else had done.

They still can't ... *unless* they're already buggy.


> Now there is 
> only one reference count but there's no way for a consumer to exclude
> other consumers and nothing which protects against breakage.
> 
> > > We should probably have something along the lines of a 
> > > regulator_get_exclusive() for them.  Previously the consumer counting
> > > would have stopped them interfering with enables done by other
> > > consumers.
> 
> > I'd like to see get()/put() match the design pattern used
> > elsewhere in the kernel:  those calls signify refcount
> > operations.
> 
> Aquiring a reference is obviously what we want in the rather common case
> where the supply is shared.  We could name an operation that enforces
> non shared supplies something else but at the end of the day it's going
> to be the same operation.  The major purpose of adding an explicit call
> for this is to document the requirement the consumer has for direct
> control of what it's doing.

Step back from the current interface for a moment though.

There seem to be two things going on:

  * getting a handle on the regulator;

  * adding consumer-specific constraints to it.

Currently "handle" and "regulator" are two different objects;
while "handle" and "consumer-specific constraints" are one.

And, as a new thing not currently addressed well in code, you
are talking about "non-shared" handles.

One could as easily have "handle" and "regulator" be the
same ... so the get/put idioms could work like they do
elsewhere in the kernel.

Doing that would imply making the "constraints" be separate
(as they are for machine constraints) and possibly having the
ability to control sharing (like IRQF_SHARED does).


> > Agreed that the "consumer" access model probably needs a few
> > interface updates.  I'm not sure what they would be though;
> > one notion would be to focus on the constraints they apply
> > (including "enabled") instead of what they do now.
> 
> I'm not at all sure what you mean by this - constraint narrowing by the
> consumers is pretty much exactly the model the existing code has.  We
> need to do things like re-add the voltage handling that was removed pre
> merge but that's already the programming model we have.

See above.  Currently constraints are hidden for "consumers",
behind functional accessors like regulator_set_voltage().
There are no explicit constraint objects, as there are for
the machines.

That's all I'm saying:  the approached you sketched isn't
the only one, and may not be the best one.  If you want to
change things, there may be better approaches.  Even ones
that don't change the overall interface structure much.

- Dave


