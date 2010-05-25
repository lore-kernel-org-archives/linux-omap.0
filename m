From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 25 May 2010 15:28:14 -0700
Message-ID: <20100525222814.GB4928@core.coreip.homeip.net>
References: <20100525165137.GB2730@core.coreip.homeip.net>
	<Pine.LNX.4.44L0.1005251408120.1634-100000@iolanthe.rowland.org>
	<20100525183334.GA4669@core.coreip.homeip.net>
	<AANLkTinz4wUJFkvhpMuYDEpQogBJtj-nhSRoEIFQBK6_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinz4wUJFkvhpMuYDEpQogBJtj-nhSRoEIFQBK6_@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?iso-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Tue, May 25, 2010 at 03:05:41PM -0700, Arve Hj=F8nnev=E5g wrote:
> On Tue, May 25, 2010 at 11:33 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, May 25, 2010 at 02:25:08PM -0400, Alan Stern wrote:
> >> On Tue, 25 May 2010, Dmitry Torokhov wrote:
> >>
> >> > BTW, If you are concerned about events that already "left" physical
> >> > device but has not reached userspace yet - maybe instead of suspend
> >> > blockers we should make sure that all drivers throughout the chain
> >> > implement suspend/resume and refuse suspending if their queues are n=
ot
> >> > empty. =A0In input land that would mean extending suspend routine in
> >> > input_dev and adding one to evdev.
> >>
> >> That's not the only problem. =A0We also have to consider events that h=
ave
> >> reached userspace but not yet been fully processed. =A0The user thread
> >> handling the event needs some way to prevent the system from suspending
> >> until it is all done.
> >>
> >
> > It is a problem if kernel initiated suspend transition on its own. I
> > believe that it is userspace responsibility to initiate sustend (and
> > make sure that needs of userspace, including processing of certain
> > events, are served beforehand).
> =

> That only works if a single user-space thread initiates suspend

Yes, there should be a single entity controlling suspend.

> and
> consumes all wakeup events (or if the user-space code that initiates
> suspend implements suspend blockers),

Yes.

> and even then the kernel would
> still need to block suspend in same places as it does if the kernel
> initiates suspend. If a wakeup event happens right after user-space
> initiates suspend, that suspend must be aborted.

This is true regardless of whether we use suspend blockers or not. If,
after initiating suspend, we detect wake up event that event shoudl be
acted upon and suspend should be ignored.

> By only initiating
> suspend from user-space, you force this to be a polling operation.
>

I am not sure what you mean by this.

-- =

Dmitry
