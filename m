From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 25 May 2010 11:33:35 -0700
Message-ID: <20100525183334.GA4669@core.coreip.homeip.net>
References: <20100525165137.GB2730@core.coreip.homeip.net>
	<Pine.LNX.4.44L0.1005251408120.1634-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005251408120.1634-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?iso-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@google.com>
List-Id: linux-omap@vger.kernel.org

On Tue, May 25, 2010 at 02:25:08PM -0400, Alan Stern wrote:
> On Tue, 25 May 2010, Dmitry Torokhov wrote:
> 
> > BTW, If you are concerned about events that already "left" physical
> > device but has not reached userspace yet - maybe instead of suspend
> > blockers we should make sure that all drivers throughout the chain
> > implement suspend/resume and refuse suspending if their queues are not
> > empty.  In input land that would mean extending suspend routine in
> > input_dev and adding one to evdev.
> 
> That's not the only problem.  We also have to consider events that have
> reached userspace but not yet been fully processed.  The user thread
> handling the event needs some way to prevent the system from suspending
> until it is all done.
> 

It is a problem if kernel initiated suspend transition on its own. I
believe that it is userspace responsibility to initiate sustend (and
make sure that needs of userspace, including processing of certain
events, are served beforehand).

-- 
Dmitry
