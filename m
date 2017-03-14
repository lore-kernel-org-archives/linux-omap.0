From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Tue, 14 Mar 2017 08:17:26 -0700
Message-ID: <20170314151725.GC20572@atomide.com>
References: <20170313205231.1593-1-tony@atomide.com>
 <0bade322-5bee-412f-ef21-972c99846e84@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0bade322-5bee-412f-ef21-972c99846e84@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170314 00:32]:
> On 13/03/17 22:52, Tony Lindgren wrote:
> > Additionally we also need to fix the hot-unplug code to properly park CPU1
> > to the bootrom loop so it's not affected by SDRAM changes done by kexec
> > booting kernel.
> 
> Imo, we are doing too much bandaid hackery for this issue now. How much do
> we care if the older kernels don't work properly with kexec? I know I don't
> care a bit myself. It means you just need to do 1 cold-boot for the system
> to fix it.

Well kexec is a standard Linux feature and it is currently working and
at least I care.

And if the CPU1 start-up address is programmed to be in the currently
booting kernel's area by something else, it's almost certainly totally
broken.

Note that this still does not remove the need to park CPU1 properly to
bootrom loop.

> If we just drop all the cpu1 reset code and park cpu1 properly at end when
> executing kexec we should be just fine, and the implementation will be much
> cleaner.
> 
> Does the wakeup issue for cpu1 ever happen with suspend, so that you
> actually must reset the cpu so that it comes up? If that is the case, it is
> going to be a tricky situation overall and we should understand the root
> cause for it before trying to fix it.

Yes omap4 CPU1 can fail occasional suspend/resume cycle. But let's assume
that's a separate issue or a side effect of not properly initializing
CPU1 during kexec before the suspend/resume cycle. I can do some more
tests on that.

Regards,

Tony
