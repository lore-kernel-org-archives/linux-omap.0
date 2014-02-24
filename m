From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [patch 08/26] arm: Replace various irq_desc accesses
Date: Mon, 24 Feb 2014 10:55:41 +0800
Message-ID: <20140224025539.GE25011@S2101-09.ap.freescale.net>
References: <20140223212703.511977310@linutronix.de>
 <20140223212737.099151500@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140223212737.099151500@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>, omap <linux-omap@vger.kernel.org>, arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Feb 23, 2014 at 09:40:12PM -0000, Thomas Gleixner wrote:
> Use the proper functions. There is no need to fiddle with irq_desc.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
...
>  arch/arm/mach-imx/pm-imx6q.c        |    7 +++----

Acked-by: Shawn Guo <shawn.guo@linaro.org>
