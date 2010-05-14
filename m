From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 23:50:01 +0200
Message-ID: <201005142350.01222.rjw@sisk.pl>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<878w7mgqse.fsf@deeprootsystems.com>
	<87tyqaduvr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87tyqaduvr.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-omap@vger.kernel.org

On Friday 14 May 2010, Kevin Hilman wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >
> >> On Thursday 13 May 2010, Tony Lindgren wrote:
> >>> * Rafael J. Wysocki <rjw@sisk.pl> [100513 14:16]:
> >
> > [...]
> >
> >>>  
> >>> > It solves a practical issue that _at_ _the_ _moment_ cannot be solved
> >>> > differently, while there's a growing number of out-of-tree drivers depending
> >>> > on this framework.  We need those drivers in and because we don't have any
> >>> > viable alternative at hand, we have no good reason to reject it.
> >>> 
> >>> Nothing is preventing merging the drivers can be merged without
> >>> these calls.
> >>
> >> And yet, there _is_ a growing nuber of drivers that don't get merge because
> >> of that.  That's _reality_.  Are you going to discuss with facts, or what?
> >
> > It may be reality, but IMO, "preventing other drivers" isn't a good
> > *technical* argument for merging a feature.  It feels like these "for
> > the 'good' of the community" arguments are being used to trump the
> > technical arguments.  Maybe we need to keep the separate.
> 
> To continue along the "for the good of the community" path...
> 
> If it truly is the lack of a suspend blocker API that is preventing
> the merge of these out of tree drivers, I second Mark's proposal[1] to
> merge a noop version of the API while the technical issues continue to
> be discussed.

I'm against that, sorry.

> Then we would see how many drivers get submitted and merged.
>
> Personally, I suspect that lack of this feature is not the real
> obstacle to getting these out-of-tree drivers upstream.  Having this
> API upstream will not change the product schedules and corporate
> cultures that have prevented code from making its way upstream.

But apparently it is considered as a suitable excuse.

Rafael
