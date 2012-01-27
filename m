From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 15:54:54 +0000
Message-ID: <20120127155454.GH2347@mudshark.cambridge.arm.com>
References: <CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
	<CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
	<CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
	<CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
	<CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
	<CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
	<CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
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
	Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, santosh.shilimkar@ti.com, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 27, 2012 at 03:45:53PM +0000, stephane eranian wrote:
> Hi,

Hi Stephane,

> Ok, with the one-line patch [1], this works much better now.
> No more wrap around a 4 billion cycles.

Hurrah! Thanks Mans and Ming Lei for helping with this. Unfortunately, I
remember Santosh had objections to this patch so that needs to be resolved.

> Sampling is okay, though I noticed it tends to not get the
> correct number of samples for a controlled run:
> 
> $ perf record -e cycles -c 1009213 noploop 10
> noploop for 10 seconds
> 
> $ perf report -D | tail -20
> cycles stats:
>            TOTAL events:       9938
>             MMAP events:         13
>             COMM events:          2
>             EXIT events:          2
>         THROTTLE events:         12
>       UNTHROTTLE events:         12
>           SAMPLE events:       9897
> 
> Should not get throttled samples. Should get abour 10k samples
> but only seeing 9897. The max_rate limit is way higher
> than what I set the period (1000 samples/sec). But then,
> is 3.2.0 throttling is broken. I posted a patch to fix that
> yesterday. I will try with my patch applied as well.

Ok. Note that on ARM the PMU generates a standard IRQ (i.e. not an NMI) so
you may miss samples if they occur during critical kernel sections (and if
you look at a profile, spin_unlock_irqrestore will be quite high).

A7 and A15 have the ability to filter counters based on privilege level, so
you can get more accurate userspace counts there.

Will

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
