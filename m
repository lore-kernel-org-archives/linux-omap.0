From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 16:59:41 +0000
Message-ID: <20120127165941.GK2347@mudshark.cambridge.arm.com>
References: <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
	<CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
	<CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
	<CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
	<CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
	<20120127155454.GH2347@mudshark.cambridge.arm.com>
	<CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: "eranian@gmail.com" <eranian@gmail.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "Cousson,
	Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 27, 2012 at 03:57:25PM +0000, stephane eranian wrote:
> On Fri, Jan 27, 2012 at 4:54 PM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > Ok. Note that on ARM the PMU generates a standard IRQ (i.e. not an NMI) so
> > you may miss samples if they occur during critical kernel sections (and if
> > you look at a profile, spin_unlock_irqrestore will be quite high).
> >
> But I am only running a user space noploop. So it spends 99% in user space, no
> critical section.

and your result is almost 99% of the way there :)

There are also potential overheads from the PMU interrupts themselves, since
there is a latency between overflow and taking the interrupt and then
between there are actually reading the counter (they continue to count after
overflow).

That said, if you see any bugs in the code please do shout!

> > A7 and A15 have the ability to filter counters based on privilege level, so
> > you can get more accurate userspace counts there.
> 
> Ok, that's better. Need to update libpfm4 for A15 with priv levels then!

How do you handle that in libpfm4? On ARM, the event encodings remain the same,
you just need to set some extra bits to determine which levels are included or
excluded (you can do this with the perf tool by using the :{u,k,h} suffix on an
event description).

Will

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
