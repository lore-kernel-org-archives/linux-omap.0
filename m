From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: dts: dra7: arch timer sits in always-on power domain
Date: Wed, 15 Jul 2015 03:00:36 -0700
Message-ID: <20150715100035.GB17550@atomide.com>
References: <1436820101-2172-1-git-send-email-balbi@ti.com>
 <20150715092437.GC9627@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150715092437.GC9627@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Nishanth Menon <nm@ti.com>, marc.zyngier@arm.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Mark Rutland <mark.rutland@arm.com> [150715 02:27]:
> On Mon, Jul 13, 2015 at 09:41:41PM +0100, Felipe Balbi wrote:
> > According to DRA7x TRM section 4.3.5 Realtime Counter (Master Counter),
> > the realtime counter sits in the Wakeup Always-On Power domain.
> > Furthermore, the counter will automatically switch the 32K clock source
> > when MPU goes into standby and automatically switch back to SYS_CLK or
> > ABE_LP when MPU goes out of standby.
> 
> While the counter is in an always-on domain (the architecture mandates
> this) I don't think that applies to the timers (i.e. the comparators
> within a CPU), which are almost certainly not in an always-on domain.
> 
> I suspect that this is incorrect, and it will be very painful to debug
> if it is...

OK good point. And there would have to be some wake-up line wired to the
IO chain or the PMIC in this case if the comparator was always on.

Dropping this patch for now anyways.

Regards,

Tony
