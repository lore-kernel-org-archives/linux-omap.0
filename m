From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 16:37:30 -0700 (PDT)
Message-ID: <641482.90616.qm@web180303.mail.gq1.yahoo.com>
References: <alpine.DEB.2.00.1005172018380.27473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1005172018380.27473@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Paul Walmsley <paul@pwsan.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Daniel Mack <daniel@caiaq.de>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Linus Walleij <linus.walleij@stericsson.com>, =?iso-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>
List-Id: linux-omap@vger.kernel.org


> > > On Mon, 3 May 2010, Arve Hj=F8nnev=E5g wrote:
> > >
> > >> No, suspend blockers are mostly used to
> ensure wakeup events are not
> > >> ignored, and to ensure tasks triggered by
> these wakeup events
> > >> complete.
> > >
> > > Standard Linux systems don't need these,
> > =

> > If you don't want to lose wakeup events they do.=A0
> Standard Linux systems =

> > support suspend, but since they usually don't have a
> lot of wakeup =

> > events you don't run into a lot of problems.

Yes and no...  stick a bunch of USB hubs and devices
on the system, and you may have a lot of wake events.
Keyboard, mouse, network adapter, and so on.

 Way back when I made USB remote wakeup work, ISTR running
into a version of the issue you're raising.  Briefly, the
wake event could be queued in hardware, but there were also
various unavoidable races .... with ambiguity about just when
particular events should be recognized.  If the system entered
sleep before the wake event(s) triggered, or the relevant devices
suspended first, then things were clear; otherwise, not.  On
first blush, I'd expect every hardware wake mechanism would have
the same issues; the fact that USB wakes are mediated via khubd
is not a huge difference.
