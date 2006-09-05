From: tony@atomide.com
Subject: Re: [PATCH] support printk-times by fixing sched_clock to be
	callable in early boot
Date: Tue, 5 Sep 2006 18:37:11 +0300
Message-ID: <20060905153710.GD18073@atomide.com>
References: <44ECA01B.7000408@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <44ECA01B.7000408@am.sony.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Tim Bird <tim.bird@am.sony.com> [060823 21:37]:
> Hi all,
> 
> This patch has been sitting in my 'to-submit' queue for a long time.
> 
> Basically, you can't use the printk times feature on omap, because
> by default it calls sched_clock() before the timer is set up, which
> causes the machine to hang.  This simplistic fix makes sched_clock()
> return 0 until the clock has been properly initialized.
>  
> The overhead of the flag check is not big, but it's impact could
> be reduced by moving the test into a separate printk_clock()
> routine (which would front the sched_clock() function, and
> is only called by printk when printk timing is active.)
> Let me know if you would prefer that I rework this patch to
> use that approach instead.

Sorry for the long delay in replying. Let's rather implement
printk_clock() like you suggest as sched_clock is called quite a bit.
That should also allow us to remove the current hack
e4fb3a282725bc66dc63fd248e9d05e0396ddf95 in kernel/printk.c.

Regards,

Tony
