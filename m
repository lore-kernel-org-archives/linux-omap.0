From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Sat, 15 May 2010 20:54:01 +0100
Message-ID: <20100515195401.GA29677@srcf.ucam.org>
References: <20100513192522.GA19256@srcf.ucam.org> <20100513194205.GC3428@atomide.com> <20100513195349.GB19722@srcf.ucam.org> <20100513200003.GE3428@atomide.com> <20100513200814.GA20254@srcf.ucam.org> <20100513202320.GF3428@atomide.com> <20100513203412.GA21244@srcf.ucam.org> <20100513211006.GG3428@atomide.com> <20100513212108.GA22103@srcf.ucam.org> <20100513213455.GK3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100513213455.GK3428@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul Walmsley <paul@pwsan.com>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Kevin Hilman <khilman@deeprootsystems.com>, magnus.damm@gmail.com, Theodore Ts'o <tytso@mit.edu>, mark gross <mgross@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Vitaly Wool <vitalywool@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, May 13, 2010 at 02:34:55PM -0700, Tony Lindgren wrote:
> * Matthew Garrett <mjg@redhat.com> [100513 14:16]:
> > What race-free mechanism do you use to ensure that? It's very easy to 
> > handwave these problems away. It's very difficult to actually write an 
> > implementation that works.
> 
> Can you describe where do you see the race now?

1) Trusted app decides to suspend
2) Network packet that would otherwise wake the system is received
3) Trusted app sends SIGSTOP to untrusted userspace
4) Network packet sits waiting for stopped userspace to process it

Unless the trusted userspace gets woken up on every event that would 
potentially cause a wakeup, you're racy. And the alternative involves an 
extra userspace wakeup for every network packet - which is expensive.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
