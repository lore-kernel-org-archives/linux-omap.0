From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] To add WDT support for OMAP3430
Date: Fri, 12 Oct 2007 13:34:24 -0700
Message-ID: <20071012203424.GL7979@atomide.com>
References: <001301c80cd8$54ea0030$248918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <001301c80cd8$54ea0030$248918ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com> [071012 07:01]:
> 
> Add watchdog timer support for TI OMAP3430.
> 
> Fix clk_put functions mismatch in the release fn which would crash the
> kernel if
> the WDT test is run multiple times with "CONFIG_WATCHDOG_NOWAYOUT" disabled.
> 
> Fix the shutdown function.Check for wdt users before calling disable.

Can you please resend without wrapping? See the outlook instructions for
avoiding patches wrapping, or try to use some other SMTP software.

Regards,

Tony
