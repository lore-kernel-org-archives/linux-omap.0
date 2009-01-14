From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH 1/1] OMAP gptimer based event monitor driver for oprofile
Date: Wed, 14 Jan 2009 20:13:25 +0200
Message-ID: <200901142013.25802.siarhei.siamashka@nokia.com>
References: <ESEBH102NgEpTX5V3Gy000037d9@esebh102.NOE.Nokia.com>
	<20090113143152.GO7344@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <20090113143152.GO7344@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, oprofile-list <oprofile-list@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 January 2009 16:31:53 ext Tony Lindgren wrote:
> Hi,
>
> Looks OK in general, few comments below.
>
> Once you're done with the changes, this should get posted to
> linux-arm-kernel@lists.arm.linux.org.uk for review with linux-omap
> list Cc'd.

Thanks a lot for a patch review. I just have a few questions before
resubmitting a fixed version.

[...]

> > +static int gptimer_start(void)
> > +{
> > +	u32 count = counter_config[0].count;
> > +	gptimer = omap_dm_timer_request();
> > +	BUG_ON(gptimer == NULL);
>
> Maybe just return -ENODEV here instead BUG_ON? In theory you could
> build a multi-omap kernel that works on multiple boards, and you
> could have all timers used up on some boards.

OK

> > +	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
> > +	if (request_irq(omap_dm_timer_get_irq(gptimer), gptimer_interrupt,
> > +			IRQF_DISABLED, "oprofile gptimer", NULL) != 0) {
> > +		printk(KERN_ERR "oprofile: unable to request gptimer IRQ\n");
> > +		return -1;
>
> Could return something from errno.h here.

I grepped the kernel sources for 'request_irq' calls and they are not very
consistent about what to return in the case when it fails. But one of the
most common variants to handle this error is just to propagate error code
returned by 'request_irq' outside. Would it be ok?

> > +	}
> > +
> > +	if (count < 1)
> > +		count = 1;
> > +
> > +	omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - count);
> > +	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
> > +	return 0;
> > +}
>
> You might want to use omap_dm_timer_request_specific() instead, and
> use a timer that's connected to WKUP domain. Otherwise you'll miss
> timer events in off-while-idle and retention-while-idle.

Probably having timer events when idle is actually not desired. Ideally
oprofile should collect samples only when CPU is active and provide a
report which represents CPU usage more or less precisely. So maybe
CORE power domain suits better here?

Also 'common.c' from oprofile directory contains code under CONFIG_PM ifdef
and provides hooks supposedly for suspend and resume operations.

About 'omap_dm_timer_request_specific'. Would it be right to first try all the
timers from the suitable domain, and then try to get just any timer before
bailing out (to handle the case when most of the timers are already used)?

> I suggest not to use GPTIMER12, as it's interrupt also gets triggered
> by spurious interrupts. But maybe you can find some other timer that's
> in the WKUP domain by reading the 34xx TRM.

Thanks, note about broken GPTIMER12 taken.

> Note that you cannot use GPTIMER1 either, because it's used for the
> system timer. I believe 24xx only has GPTIMER1 in the WKUP domain,
> so you might want to use omap_dm_timer_request() if cpu_is_omap24xx().
> Don't know if 2430 has more thant GPTIMER1 in WKUP domain.

IMHO there is little need to use this oprofile driver on OMAP2 chips at all
(except for testing purposes, which I actually also have done on OMAP2420
too prior to submitting initial revision of the patch). The hardware
performance counters work and do the job fine there. Supporting OMAP1 may
have some practical value.

-- 
Best regards,
Siarhei Siamashka

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
