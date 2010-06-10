From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Thu, 10 Jun 2010 14:57:15 +0100
Message-ID: <20100610135714.GA27848@sirena.org.uk>
References: <20100603193045.GA7188@elte.hu> <201006091140.28034.rjw@sisk.pl> <20100610080425.6f005dbb@notabene.brown> <201006101059.44411.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201006101059.44411.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Neil Brown <neilb@suse.de>, Felipe Contreras <felipe.contreras@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, david@lang.hm, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Brian Swetland <swetland@google.com>, Arve Hj?nnev?g <arve@android.com>, Arjan van de Ven <arjan@infradead.org>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 10, 2010 at 10:59:43AM +0200, Rafael J. Wysocki wrote:

> So, for a phone-like system, where you'd generally want to simplify user space,
> having a "power manager" in the kernel seems to make sense to me.

I'm not clear where this requirement to simplify user space specifically
for phones comes from - phones do have pretty substantial software
stacks that aren't that far away to PCs.
