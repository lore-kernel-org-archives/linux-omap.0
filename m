From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 22:58:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005142256070.11498-100000@netrider.rowland.org>
References: <AANLkTil-Ky5L84JF7xn6su8VMtglBpZwCNIh7VgBiHgL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:58855 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751316Ab0EOC6t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 22:58:49 -0400
In-Reply-To: <AANLkTil-Ky5L84JF7xn6su8VMtglBpZwCNIh7VgBiHgL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tony Lindgren <tony@atomide.com>, Matthew Garrett <mjg@redhat.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, 14 May 2010, Brian Swetland wrote:

> It provides useful functionality -- you apparently disagree, but the
> wakelock/suspendblock model is in use, shipping, and solving problems
> for quite a lot of android devices that have been shipping for a while
> now.  We actively go to lowest power state in idle (on omap, msm,
> etc), and use drivers that aggressively declock and depower modules
> (similar to runtime pm), but we have found that using the
> opportunistic suspend model combined with wakelocks allows us to
> attain even lower average power consumption in always-connected,
> actively-syncing devices.

Can you explain this in more detail?  Are you saying that some devices
go on generating interrupts and causing timers to be scheduled, even 
though what they're doing isn't important enough to prevent the system 
from powering down?

Alan Stern

