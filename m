From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/5] watchdog: cleanup a bit omap_wdt.c
Date: Sat, 20 Sep 2008 10:18:41 -0700
Message-ID: <200809201018.42127.david-b@pacbell.net>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <200809200832.15440.david-b@pacbell.net> <20080920161111.GA9873@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:26755 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750900AbYITRSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Sep 2008 13:18:45 -0400
In-Reply-To: <20080920161111.GA9873@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>

> > > > Oh, I see where "omap_wdt_dev" (global) gets used.  The normal
> > > > way to do stuff like that is using void* pointers placed in the
> > > > inode and file structures for exactly that purpose.
> > > 
> > > You don't have an inode or a file structure until open() is called -
> > > at which point it _is_ placed in file->private_data.  So this driver
> > > is doing the right thing.
> > 
> > Well, the conventional thing for misc drivers, at any rate.  In
> > various other drivers, inode->i_private is set up earlier, just
> > to avoid such a need for globals (or equivalent).
> 
> None that I know about - generally other drivers look up their private
> data in some kind of array and assign to file->private_data in their
> open() method - in much the same way that watchdog and misc drivers do.

Yet i_private gets set up *somewhere* else that field wouldn't exist.
Look around; you'll see it gets used.  (My quick grep started in the
USB tree, where it turns out both usbfs and gadgetfs use it.)

When the inode stays permanently in memory that's simple to manage.
Regardless, for misc drivers the scheme I mentioned is equally simple:

--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -147,6 +147,7 @@ static int misc_open(struct inode * inode, struct file * file)
 	err = 0;
 	old_fops = file->f_op;
 	file->f_op = new_fops;
+	inode->i_private = c;
 	if (file->f_op->open) {
 		err=file->f_op->open(inode,file);
 		if (err) {

> The simplest solution is as the watchdog drivers are doing.

I'll disagree.  It requires extra state even in this simple case;
state of a generically undesirable flavor (global).  And likewise,
it requires lookup mechanisms ... which if you look around, tend
to be rather error prone, locking often gets goofed up there.

Familiar and simple != simplest, != best.  It will often become
cargo cult programming.


> And anyway, the point of these patches is not to fix issues like this.
> It's to get what's in mainline updated to what's in the OMAP tree so
> stuff can move forwards.  So, let's not go down rabbit warrens trying
> to find obscure new issues which lots of other code already "suffers"
> from.

Right, my original comment pointed out one thing that was clearly
wrong (extra/unused struct field) and one odd thing (the global).

You said "not that odd, here's why"; I said "hmm, well OK but it's
still got problem X, which isn't for fixing in this patchset".

(Leaving the extra/unused struct field still an issue.  It came
from the original d99241c86f6ccd1226935f8f59d3bb17a4186b85 patch
which made the OMAP tree diverge from upstream.  I suspect that
one didn't get much review, partly because at that time OMAP3 was
much less available than now.  Pushing that upstream may not even
have been an option then.)


> We're into the third day on this one driver.  If every OMAP driver takes
> this long ...

That seems like a strange way to account things.  It presumes
that the only time review comments should be accepted is within
a day of the patch getting posted.  Regardless of whether the
reviewer has time at that point.

If you *really* wanted to avoid wasting time you wouldn't have
replied to my previous post, which agreed that one point I raised
was a non-issue for this particular patch series.

- Dave
