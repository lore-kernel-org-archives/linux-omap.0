From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC] ARM: omap2: fix lack of timer interrupts on CPU1
 after hotplug
Date: Thu, 7 Feb 2019 13:45:48 +0000
Message-ID: <20190207134548.43yyk3wsadwvcmd6@shell.armlinux.org.uk>
References: <E1gX31P-0004wA-Eq@rmk-PC.armlinux.org.uk>
 <20181212175332.GI6707@atomide.com>
 <20181212185741.GJ6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181212185741.GJ6707@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 12, 2018 at 10:57:41AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [181212 17:53]:
> > * Russell King <rmk+kernel@armlinux.org.uk> [181212 11:49]:
> > > We call tick_broadcast_enter() in omap_enter_idle_coupled(), which one
> > > would expect would take care of the issue, but internally this only
> > > deals with one-shot local timers - tick_broadcast_enable() on the other
> > > hand only deals with periodic local timers.  So, we need to call both.
> > 
> > This works just fine for me for NO_HZ and cpuidle:
> >
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> And also works for me without NO_HZ too FYI.

Hi Tony,

Could you pick this patch up and submit for 5.0-rc please?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
