From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 22:38:40 +0300
Message-ID: <20100517193840.GB14047@gandalf>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
 <87hbm6cz90.fsf@deeprootsystems.com>
 <1274115885.4418.59.camel@mulgrave.site>
 <20100517174647.GA11512@gandalf>
 <1274119179.4418.68.camel@mulgrave.site>
 <20100517181252.GA14260@gandalf>
 <1274124267.4418.149.camel@mulgrave.site>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1274124267.4418.149.camel@mulgrave.site>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: me@felipebalbi.com, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, May 17, 2010 at 03:24:27PM -0400, James Bottomley wrote:
> Surely, depending on your UART FIFO depth, of course, a serial console
> interrupts once every 16 characters or so ... how do you filter out that
> storm of interrupts refreshing the powertop screen from the actual
> application problems?
> 
> But anyway, the average user probably either doesn't have or doesn't
> know how to get to a serial console on their phone ...

like I said: use a big memory buffer and print to that. Only flush after
you're done profiling. Something like dmesg.

> If you actually s/app/USB storage device/ (with a few other obvious text
> changes) in most of the above two paragraphs, you've got a good
> description of the problems we go through on an almost daily basis in
> the kernel for USB storage ... and why we've grown a massive exception
> table.
> 
> Just saying "devices should conform to specifications" is a wonderful
> magic wand for wishing away all the problems bad devices cause and
> bludgeoning manufacturers with the said spec wrapped around a large lead
> brick is very cathartic but it doesn't change the fact that users blame
> the kernel for not working with the bad devices ... and we gave up
> trying to re-educate users on that score years ago.

that's a whole other story. Hardware issues are things which in 99.999%
of the cases we can't change. We have to work around them. Software
bugs, on the other hand, can be fixed much more easily. I'm sure you
agree with that, don't you ?

Trying to make a comparisson between hardware bug and software bug is
simply non-sense in this case.

-- 
balbi
