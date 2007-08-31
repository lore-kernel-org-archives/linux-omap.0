From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix sleep under spinlock for cpufreq
Date: Fri, 31 Aug 2007 10:14:57 -0700
Message-ID: <20070831171456.GG12350@atomide.com>
References: <11884671992065-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11884671992065-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroshi.DOYU@nokia.com <Hiroshi.DOYU@nokia.com> [070830 02:48]:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> [   10.523437] BUG: sleeping function called from invalid context at kernel/mut6
> [   10.523437] in_atomic():0, irqs_disabled():128
> [   10.523437] [<c002c168>] (dump_stack+0x0/0x14) from [<c005374c>] (__might_sl)
> [   10.523437] [<c0053698>] (__might_sleep+0x0/0xd4) from [<c024fdf4>] (mutex_l)
> [   10.523437]  r5 = C02F0DE8  r4 = C02F0DF0
> [   10.523437] [<c024fdd4>] (mutex_lock+0x0/0x44) from [<c0041df4>] (clk_get+0x)
> [   10.523437]  r4 = 00000000
> [   10.523437] [<c0041da4>] (clk_get+0x0/0x128) from [<c0046520>] (omap_getspee)
> [   10.523437]  r8 = 00000002  r7 = 00000000  r6 = C031DAF8  r5 = C0473980
> [   10.523437]  r4 = 00000000
> [   10.523437] [<c00464fc>] (omap_getspeed+0x0/0x5c) from [<c01b8518>] (cpufreq)
> [   10.523437]  r5 = C0473980  r4 = 00000002

Thanks pushing today. Hmmm, it was really doing clk_get every time,
how inefficient...

Tony
