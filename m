From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC] ARM: omap2: fix lack of timer interrupts on CPU1
 after hotplug
Date: Wed, 12 Dec 2018 09:53:32 -0800
Message-ID: <20181212175332.GI6707@atomide.com>
References: <E1gX31P-0004wA-Eq@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1gX31P-0004wA-Eq@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King <rmk+kernel@armlinux.org.uk> [181212 11:49]:
> We call tick_broadcast_enter() in omap_enter_idle_coupled(), which one
> would expect would take care of the issue, but internally this only
> deals with one-shot local timers - tick_broadcast_enable() on the other
> hand only deals with periodic local timers.  So, we need to call both.

This works just fine for me for NO_HZ and cpuidle:

Tested-by: Tony Lindgren <tony@atomide.com>
