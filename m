From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc7 regulator-next] regulator: refcount fixes
Date: Sat, 14 Mar 2009 14:29:24 -0700
Message-ID: <200903141429.24534.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <200903121602.55570.david-b@pacbell.net> <20090313013813.GK24376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:22199 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751242AbZCNV31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Mar 2009 17:29:27 -0400
In-Reply-To: <20090313013813.GK24376@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thursday 12 March 2009, Mark Brown wrote:
> On Thu, Mar 12, 2009 at 03:02:55PM -0800, David Brownell wrote:
>
> > One could as easily have "handle" and "regulator" be the
> > same ... so the get/put idioms could work like they do
> > elsewhere in the kernel.
> 
> I really don't see that there is any meaningful difference here; from
> the point of view of the consumer the fact that the thing it gets back
> is a handle to a structure the core uses to keep track of the consumer
> rather than the underlying hardware object is an implementation detail
> that shouldn't make any difference to them.  In terms of the programming
> model it seems like a layering violation to know the difference between
> one opaque structure and another.

You're not stepping back from the current interface, which is
a prerequisite to understanding the points I was making:

 * Almost everywhere else in the kernel, there's only one
   handle (no per-client facet idiom), for which get/put
   works.

   Having the handle alloc/free methods be called get/put
   is a kind of problem.  We want models and idioms to
   converge, not diverge, in almost all cases ... using
   the same names to mean different things isn't good.

 * The thing that *is* per-client is basically a constraint
   set ... but it's called a "regulator", which again is
   confusing.

In the regulator-next tree you've now moved regulator_dev
into the public interface ... that's the handle to the
real hardware.  Sort of a hint that it can't really be
hidden in the way you originally thought.


> > See above.  Currently constraints are hidden for "consumers",
> > behind functional accessors like regulator_set_voltage().
> > There are no explicit constraint objects, as there are for
> > the machines.
> 
> The current interface has been driven by the needs of the users: the
> majority of consumers want to do one operation on a regular basis -
> normally that's enable/disable, most devices are just powering
> themselves up and down, though for some things voltage changes are much
> more common (DVFS being the prime example).  Overall it's been fairly
> similar to the clock API in terms of usage pattern.

Except that the clock interface uses put/get in the normal way;
they are not alloc/free calls, just lookup/refcount calls.


> In terms of looking at redesigning the API

You were the one suggesting the need for a new call, formalizing
a model that didn't previously exist ... not me!  :)

Which is why I suggested taht if you were going to add calls,
it'd be worth thinking a bit more about some existing glitches.
