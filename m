From: tony@atomide.com
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 14:37:40 -0800
Message-ID: <20061130223739.GA9605@atomide.com>
References: <20061130215926.GA7762@atomide.com>
	<EA12F909C0431D458B9D18A176BEE4A508CE053E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A508CE053E@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [061130 14:24]:
> > Thanks for the info, I guess I was looking for the continuously
> running
> > 32KHz timer in addition to that, as then we could use the same dyntick
> > code on 1510 also. Do you know if there is continuously running 32KHz
> > timer on 1510?
> 
> You are looking for 32K Sync timer? I don't think 1510 had one.  1510
> did have an RTC which 32K goes to and can wake you.  Other OMAPs dropped
> it. I seem to recall it may have used to much current and the
> recommendation was to use an external one.  Granularity isn't so great.

Yeah, sync timer was what I was looking. If it does not exist on 1510,
then the dyntick code should use the 32KHz timer as the freely running
timer, and one of the mpu timers for the interrupts.

Regards,

Tony
