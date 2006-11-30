From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 13:57:50 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A508CE02C7@dlee02.ent.ti.com>
References: <20061110005357.GZ16172@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20061110005357.GZ16172@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@mvista.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> In this case it will start drifting if you try to do it with just one
> timer. On omaps, we should use the always running 32 KiHZ timer for
> clocksource like the timer32k.c does. Unfortunately that's does not
seem
> to be available on 1510, and maybe that's why the original mpu timer
> code from RidgeRun used two timers.

That code uses two timers to account for isr latency and to provide
accurate timestamps.  One timer is periodic and the other is free
running. The 2nd is used as a relative reference.  Along with being used
as a reference the 2nd free runner uses its current value and its roll
over interrupt to sum/calculate the number of ns the system has been up.
This enables sched_clock to be enabled with accuracy (vs. just
multiplying times jiffies).

The single timer method does not do either of these.  The code was
reasonably clear, I also sent in a path long ago to enable this.  Is
there some aspect of this which I mis-understood?

> If anybody with 1510 has a chance, it may be worth scanning through
some
> registers in case there is some continuously running timer for this..

TRM shows 1510 has 3 general timers and 1 32KHz timer.  The 32KHz timer
is at base=3D0xFFFB9000.  TVR=3Dbase+0, TCR=3Dbase+4, CR=3Dbase+8.  It =
comes in
on L2-Pic-IRQ22.  It has a 24 bit counter.

Regards,
Richard W.
