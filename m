From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC] ARM: omap2: fix lack of timer interrupts on CPU1
 after hotplug
Date: Thu, 7 Feb 2019 07:51:39 -0800
Message-ID: <20190207155139.GC5720@atomide.com>
References: <E1gX31P-0004wA-Eq@rmk-PC.armlinux.org.uk>
 <20181212175332.GI6707@atomide.com>
 <20181212185741.GJ6707@atomide.com>
 <20190207134548.43yyk3wsadwvcmd6@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190207134548.43yyk3wsadwvcmd6@shell.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux admin <linux@armlinux.org.uk> [190207 13:46]:
> On Wed, Dec 12, 2018 at 10:57:41AM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [181212 17:53]:
> > > * Russell King <rmk+kernel@armlinux.org.uk> [181212 11:49]:
> > > > We call tick_broadcast_enter() in omap_enter_idle_coupled(), which one
> > > > would expect would take care of the issue, but internally this only
> > > > deals with one-shot local timers - tick_broadcast_enable() on the other
> > > > hand only deals with periodic local timers.  So, we need to call both.
> > > 
> > > This works just fine for me for NO_HZ and cpuidle:
> > >
> > > Tested-by: Tony Lindgren <tony@atomide.com>
> > 
> > And also works for me without NO_HZ too FYI.
> 
> Hi Tony,
> 
> Could you pick this patch up and submit for 5.0-rc please?

Oh sorry. I thought you had already merged it since I added
my Tested-by. Hmm I guess I need to start adding also an
Acked-by to signal it's OK to pick some misc patches.

Anyways, applying into omap-for-v5.0/fixes-v2.

Thanks,

Tony
