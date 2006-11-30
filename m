From: tony@atomide.com
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 13:59:27 -0800
Message-ID: <20061130215926.GA7762@atomide.com>
References: <20061110005357.GZ16172@atomide.com>
	<EA12F909C0431D458B9D18A176BEE4A508CE02C7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A508CE02C7@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Woodruff, Richard <r-woodruff2@ti.com> [061130 11:58]:
> 
> > If anybody with 1510 has a chance, it may be worth scanning through
> some
> > registers in case there is some continuously running timer for this..
> 
> TRM shows 1510 has 3 general timers and 1 32KHz timer.  The 32KHz timer
> is at base=0xFFFB9000.  TVR=base+0, TCR=base+4, CR=base+8.  It comes in
> on L2-Pic-IRQ22.  It has a 24 bit counter.

Thanks for the info, I guess I was looking for the continuously running
32KHz timer in addition to that, as then we could use the same dyntick
code on 1510 also. Do you know if there is continuously running 32KHz
timer on 1510?

Regards,

Tony
