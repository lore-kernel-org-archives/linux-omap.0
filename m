From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 23:57:33 +0200
Message-ID: <201005132357.33385.rjw@sisk.pl>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com> <201005132314.22497.rjw@sisk.pl> <20100513213121.GJ3428@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100513213121.GJ3428@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul Walmsley <paul@pwsan.com>, Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kevin Hilman <khilman@deeprootsystems.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Matthew Garrett <mjg@redhat.com>, =?iso-8859-1?q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Linus Walleij <linus.walleij@ericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Thursday 13 May 2010, Tony Lindgren wrote:
> * Rafael J. Wysocki <rjw@sisk.pl> [100513 14:08]:
> > On Thursday 13 May 2010, Tony Lindgren wrote:
> > > 
> > > The difference between echo mem > /sys/power/state and suspend blocks
> > > is that with suspend blocks the system keeps running.
> > 
> > Care to elaborate?
> 
> The suspend blocks affects the runtime behaviour of the system by
> categorizing apps into good and bad apps in a weird way.

I don't see this, can you please explain?

Rafael
