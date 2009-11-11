From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/1]: Thaws refrigerated bdi flusher threads before
	invoking kthread_stop on them
Date: Wed, 11 Nov 2009 20:37:20 +0100
Message-ID: <20091111193719.GR8742@kernel.dk>
References: <1257928216.15415.57.camel@boson> <20091111103444.GD26423@elf.ucw.cz> <200911111230.58479.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758757AbZKKThR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200911111230.58479.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Romit Dasgupta <romit@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 11 2009, Rafael J. Wysocki wrote:
> On Wednesday 11 November 2009, Pavel Machek wrote:
> > On Wed 2009-11-11 14:00:16, Romit Dasgupta wrote:
> > > Kicks out frozen bdi flusher task out of the refrigerator when the flusher task
> > > needs to exit.
> > 
> > 
> > > Signed-off-by: Romit Dasgupta <romit@ti.com>
> > 
> > Ok, its slightly "interesting", but better than modifying common
> > code. Looks ok to me.
> > 
> > ACK.
> 
> Agreed.
> 
> Jens, any objections?

Nope, looks fine to me. Though I'd probably prefer just doing an
unconditional PF_FROZEN clear.

/*
 * Force unfreeze of the bdi threads before stopping it, since otherwise
 * it would never exit if it is stuck in the refrigerator.
 */
list_for_each_entry(wb, &bdi->wb_list, list) {
	wb->task->flags &= ~PF_FROZEN;
	kthread_stop(wb->task);
}

And the comment too, it's not enough to stuff this into the commit.

-- 
Jens Axboe
