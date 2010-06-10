From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Thu, 10 Jun 2010 17:46:46 +0200
Message-ID: <201006101746.47035.rjw@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <201006101059.44411.rjw@sisk.pl> <20100610135714.GA27848@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100610135714.GA27848@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Neil Brown <neilb@suse.de>, Felipe Contreras <felipe.contreras@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, david@lang.hm, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Brian Swetland <swetland@google.com>, Arve Hj?nnev?g <arve@android.com>, Arjan van de Ven <arjan@infradead.org>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-omap@vger.kernel.org

On Thursday, June 10, 2010, Mark Brown wrote:
> On Thu, Jun 10, 2010 at 10:59:43AM +0200, Rafael J. Wysocki wrote:
> 
> > So, for a phone-like system, where you'd generally want to simplify user space,
> > having a "power manager" in the kernel seems to make sense to me.
> 
> I'm not clear where this requirement to simplify user space specifically
> for phones comes from

This isn't a requirement, but something that IMO is reasonable.

> - phones do have pretty substantial software stacks that aren't that far away
> to PCs.

That doesn't seem to be relevant here.

Rafael
