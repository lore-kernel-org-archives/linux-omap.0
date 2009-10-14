From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: Broken cpuidle on PM branch?
Date: Wed, 14 Oct 2009 16:11:29 +0300
Message-ID: <20091014131129.GA3509@esdhcp037198.research.nokia.com>
References: <20091012192347.GI32041@smtp.gmail.com>
 <20091013133151.GA8028@esdhcp037198.research.nokia.com>
 <87r5t7mfbm.fsf@deeprootsystems.com>
 <20091014064822.GA1000@esdhcp037198.research.nokia.com>
 <87aazugm5a.fsf@deeprootsystems.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57080 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760534AbZJNNNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 09:13:05 -0400
Content-Disposition: inline
In-Reply-To: <87aazugm5a.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 14, 2009 at 03:06:41PM +0200, ext Kevin Hilman wrote:
> Eduardo Valentin <eduardo.valentin@nokia.com> writes:
> 
> > On Tue, Oct 13, 2009 at 06:25:17PM +0200, ext Kevin Hilman wrote:
> >> Eduardo Valentin <eduardo.valentin@nokia.com> writes:
> >> 
> >> > Hello Amit,
> >> >
> >> > On Mon, Oct 12, 2009 at 09:23:47PM +0200, ext Amit Kucheria wrote:
> >> >> Hi,
> >> >> 
> >> >> I am testing twl4030 script optimisations on the current PM branch. But I am
> >> >> seeing the board (RX51) freeze when CPU_IDLE is enabled in the config.
> >> >> 
> >> >> Is it known to work on other boards?
> >> >
> >> > I'm actually seeing this same behavior. But the board actually does not
> >> > freeze. If you keep a key pressed of send a sysrq through serial line
> >> > then you eventually get it back.
> >> >
> >> > It seams to be something related to serial driver and wakeup ?
> >> >
> >> 
> >> Do you see this problem after doing
> >> 
> >>   # echo 1 > /debug/pm_debug/sleep_while_idle
> >> 
> >
> > No I don't. The problem is gone it seams.
> >
> > similar effect happens if we
> >
> > # echo 0 > /sys/devices/platform/serial8250.2/sleep_timeout
> >
> > Of course, this would prevent device go to sleep I guess.
> >
> 
> Yes, there is a problem with UART3 (in PER) going idle independently
> of CORE/MPU that I have not yet found.


yeah, one possible fix would be preventing it if core is going to on
@@ -514,7 +514,9 @@ void omap_sram_idle(void)

        /* PER */
        if (per_next_state < PWRDM_POWER_ON) {
-               omap_uart_prepare_idle(2);
+               if (core_next_state != PWRDM_POWER_ON)
+                       omap_uart_prepare_idle(2);
+


Needs to see what is the impact of this approach though
> 
> Kevin

-- 
Eduardo Valentin
