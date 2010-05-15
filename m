From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 22:25:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005142216481.11498-100000@netrider.rowland.org>
References: <AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@google.co>
List-Id: linux-omap@vger.kernel.org

On Fri, 14 May 2010, Arve Hj=F8nnev=E5g wrote:

> On Fri, May 14, 2010 at 1:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > Hello,
> >
> > On Mon, 3 May 2010, Arve Hj=F8nnev=E5g wrote:
> >
> >> No, suspend blockers are mostly used to ensure wakeup events are not
> >> ignored, and to ensure tasks triggered by these wakeup events
> >> complete.
> >
> > Standard Linux systems don't need these,
> =

> If you don't want to lose wakeup events they do. Standard Linux
> systems support suspend, but since they usually don't have a lot of
> wakeup events you don't run into a lot of problems.

The primary client for opportunistic suspend and suspend blockers
appears to be embedded systems.  These systems are typically capable of
powering the CPU down and up again with low latency, and they typically
have very aggressive runtime PM support capable of powering down each
device when it's not in active use.  Given this ability, it does seem
that opportunistic suspend and suspend blockers might be unnecessary.

I'd like to explore this avenue a little farther.  In particular, what =

is the issue involving loss of wakeup events?  Can you describe this in =

more detail?

> > because the scheduler just keeps
> > the system running as long as there is work to be done.
> >
> =

> That is only true if you never use suspend.

Why would you want to use system suspend if runtime PM can do
everything you need?

Sure, I can see that an ACPI-based system needs something more.  But =

that's not the real issue here.

Alan Stern
