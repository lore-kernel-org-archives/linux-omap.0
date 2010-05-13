From: Tony Lindgren <tony@atomide.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 14:36:57 -0700
Message-ID: <20100513213656.GL3428@atomide.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
 <201005132311.26293.rjw@sisk.pl>
 <1273785399.19100.98.camel@c-dwalke-linux.qualcomm.com>
 <201005132327.16163.rjw@sisk.pl>
 <1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Brian Swetland <swetland@google.com>, Paul Walmsley <paul@pwsan.com>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Greg KH <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

* Daniel Walker <dwalker@fifo99.com> [100513 14:28]:
> On Thu, 2010-05-13 at 23:27 +0200, Rafael J. Wysocki wrote:
> 
> > Because someone would have to remove suspend blockers (or rather wakelocks)
> > from the drivers, test that they work correctly without suspend blockers and
> > submit the modified versions.  Going forward, every party responsible for such
> > a driver would have to maintain an out-of-tree version with suspend blockers
> > (or wakelocks) anyway, so the incentive to do that is zero.
> 
> They should work without wakelock since wakelock are optional .. I mean
> there's nothing in suspend blockers I've seen that indicates it's
> required for some drivers to work. So it's just a matter of patching out
> the wakelocks, with no need to re-test anything.
> 
> You get the driver mainlined, then maintain a small patch to add
> wakelocks. Not hard at all , with lots of incentive to do so since you
> don't have to maintain such a large block of code out of tree.
> 
> > Practically, as long as the opportunistic suspend is out of tree, there will be
> > a _growing_ number of out-of-tree drivers out there, which is not acceptable
> > in the long run.
> 
> I don't see why your saying that. These driver should work with out all
> of this, which means they can get mainlined right now.

I agree with Daniel here. We should keep merging the drivers separate
from the suspend blocks issues.

Regards,

Tony
