From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Sun, 15 Apr 2018 16:50:37 +0100
Message-ID: <20180415155037.GI10990@n2100.armlinux.org.uk>
References: <E1f5qij-00033R-Sl@rmk-PC.armlinux.org.uk>
 <20180410134149.GQ5700@atomide.com>
 <685f80e3-30b3-8806-b81c-8de456507001@ti.com>
 <20180411125210.GF10990@n2100.armlinux.org.uk>
 <20180411141139.GU5700@atomide.com>
 <20180415140833.GH10990@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180415140833.GH10990@n2100.armlinux.org.uk>
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
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, Apr 15, 2018 at 03:08:34PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 11, 2018 at 07:11:39AM -0700, Tony Lindgren wrote:
> > We already have code in the kernel (and in the bootrom) to "park" a
> > cpu after starting. But using it without resetting the cpu would require
> > 1-1 memory mapping or modifying the code. That is if we wanted to use
> > the same code also for parking the cpus for kexec without resetting
> > them.
> 
> In which case, how about using:
> 
> 	while (1) {
> 		cpu_relax();
> 		wfe();
> 	}
> 
> instead - that appears to also have the desired effect, allowing kdump
> to work on the SDP4430.

... but results in compile failures on non-ARMv7 targets.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
