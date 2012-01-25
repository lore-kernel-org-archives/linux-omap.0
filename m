From: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
 driver to platform_driver
Date: Wed, 25 Jan 2012 15:53:30 -0800
Message-ID: <1327535610.2141.15.camel@localhost>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
 <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, balbi@ti.com, tglx@linutronix.de, linux-omap@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2012-01-18 at 16:58 +0530, Vaibhav Hiremath wrote:
> +/**
> + * read_persistent_clock -  Return time from a persistent clock.
> + *
> + * Reads the time from a source which isn't disabled during PM, the
> + * 32k sync timer.  Convert the cycles elapsed since last read into
> + * nsecs and adds to a monotonically increasing timespec.
> + */
> +void read_persistent_clock(struct timespec *ts)
> +{
> +	cycles_t delta;
> +	struct timespec *tsp;
> +	unsigned long long nsecs;
> +	struct omap_counter_32k_device  *omap = cs;
> +
> +	if (!omap) {
> +		ts->tv_sec = 0;
> +		ts->tv_nsec = 0;
> +		return;
> +	}
> +	tsp = &omap->persistent_ts;
> +
> +	omap->last_cycles = omap->cycles;
> +	omap->cycles = omap->cs.read(&omap->cs);
> +	delta = omap->cycles - omap->last_cycles;
> +
> +	nsecs = clocksource_cyc2ns(delta,
> +			omap->cs.mult, omap->cs.shift);
> +
> +	timespec_add_ns(tsp, nsecs);
> +	*ts = *tsp;
> +}

Hrm. So read_persistent_clock should probably be defined once per arch.
So I'm not sure if it makes sense to include this implementation into
the generic drivers/clocksource directory, as if some other arch tried
to include this clocksource (say if they had the same hardware) they
might have collisions w/ their read_persistent_clock implementation.


I'm all for being able to re-use clocksource drivers. But this is the
sort of thing that makes me worry we're maybe being too aggressive in
pushing clocksources that really are fairly arch/platform specific into
drivers/clocksource/

thanks
-john
