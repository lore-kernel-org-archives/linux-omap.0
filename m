From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 14:32:46 -0800
Message-ID: <200611301432.46837.david-b@pacbell.net>
References: <EA12F909C0431D458B9D18A176BEE4A508CE04CD@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A508CE04CD@dlee02.ent.ti.com>
Content-Disposition: inline
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 30 November 2006 1:49 pm, Woodruff, Richard wrote:

> The only thing about using two timers which made me think twice was what
> happens during retention/off mode sleeps.  This forces you to add a
> little code to account for clock switching (sys_clk to 32KHz) at the
> periodic timer, and adding knowledge about the stopped free running one.
> 
> Having a single GPT1 timer active which is wake up capable makes it all
> simpler.  I did ask for a 2nd timer in the wake up domain and that
> actually happened in 3430.
> 
> ... Actually, I would guess many use cases would be find using a CORE
> domain timer and setting the target for the system sleep to be
> 'request-idle' this removes any worry about the clock transition as the
> functional clock of the CORE timer can run and its ISR can issue a PRCM
> wake up.  This is the state you want to generally go into anyway in an
> idle routine if you any kind of peripheral activity.

Not that I have time to look into OMAP2 low power modes ... but I'd thought
the preferred solution when low power was a concern would be to use the
32k timers not the general purpose ones, and that you more or less said
just that.  Did I translate that correctly?  :)
