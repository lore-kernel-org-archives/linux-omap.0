From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: am437x: rollback to use
 omap3_gptimer_timer_init()
Date: Tue, 12 Apr 2016 11:42:50 -0700
Message-ID: <20160412184250.GT5995@atomide.com>
References: <1460457775-23850-1-git-send-email-grygorii.strashko@ti.com>
 <20160412160448.GN5995@atomide.com> <570D3EC8.7090807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <570D3EC8.7090807@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Felipe Balbi <balbi@kernel.org>, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160412 11:31]:
> On 04/12/2016 07:04 PM, Tony Lindgren wrote:
> > * Grygorii Strashko <grygorii.strashko@ti.com> [160412 03:44]:
> >> The commit 55ee7017ee31 ("arm: omap2: board-generic: use
> >> omap4_local_timer_init for AM437x") unintentionally changes the
> >> clocksource devices for AM437x from OMAP GP Timer to SyncTimer32K.
> >>
> >> Unfortunately, the SyncTimer32K is starving from frequency deviation
> >> as mentioned in commit 5b5c01359152 ("ARM: OMAP2+: AM43x: Use gptimer
> >> as clocksource") and, as reported by Franklin [1], even its monotonic
> >> nature is under question (most probably there is a HW issue, but it's
> >> still under investigation).
> >>
> >> Taking into account above facts It's reasonable to rollback to the use
> >> of omap3_gptimer_timer_init().
> > 
> > I thought only the ePOS EVM does not have the 32k clock available?
> > Maybe this is the the old sync timer autocorrection drift issue?
> > 
> 
> May be, as i mentioned in [1] it could be errata same as for Watchdog
> Advisory 22 (or OMAP_TIMER_ERRATA_I103_I767).
> 
> But as per commit 5b5c01359152 ("ARM: OMAP2+: AM43x: Use gptimer
> as clocksource") there is no reason to use SyncTimer32K as
> clocksource any way (not only on epos):
> 
> commit 5b5c01359152f3ddaa1aa0e5d1141bc2b29ba2c5
> Author: Rajendra Nayak <rnayak@ti.com>
> Date:   Fri Feb 7 15:51:26 2014 +0530
> 
>     ARM: OMAP2+: AM43x: Use gptimer as clocksource
>     
>     The SyncTimer in AM43x is clocked using the following two sources:
>     1) An inaccuarte 32k clock (CLK_32KHZ) derived from PER DPLL, causing system
>        time to go slowly (~10% deviation).
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     2) external 32KHz RTC clock, which may not always be available on board like
>        in the case of ePOS EVM

This sounds similar to recent "ARM: dts: dra7: Correct clock tree for
sys_32k_ck", can you see if similar changes help for am43x?

Regards,

Tony
