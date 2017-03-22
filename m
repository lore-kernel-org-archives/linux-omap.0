From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Wed, 22 Mar 2017 10:57:51 -0700
Message-ID: <20170322175750.GF10760@atomide.com>
References: <20170314151725.GC20572@atomide.com>
 <d0fe191f-66f8-b72d-0a2a-00815e663a8d@ti.com>
 <20170314164106.GE20572@atomide.com>
 <ea09d676-29f6-7100-4c68-88920deaeb7c@ti.com>
 <20170314181425.GF20572@atomide.com>
 <20170315172200.GM20572@atomide.com>
 <20170316152925.GO20572@atomide.com>
 <20170317092458.GJ23750@n2100.armlinux.org.uk>
 <20170317135710.GQ20572@atomide.com>
 <0f81ef51-29a7-3a38-1d99-2f68d6ec9410@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0f81ef51-29a7-3a38-1d99-2f68d6ec9410@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [170317 09:28]:
> On 03/17/2017 08:57 AM, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@armlinux.org.uk> [170317 02:27]:
> >> Why can't you reset the CPU when it's died, possibly releasing the
> >> reset again to get it into the boot rom (which is where it'll be at
> >> boot time.)
> > 
> > Yes that would make most sense to me. Andrew, does that break your use
> > case again for CPU1 for suspend/restore?
> > 
> 
> We cannot reset the CPU, that is the only constraint I have. If you let
> a core go awol then it is lost for good, you should try to avoid that.
> The secure side on that core may still be running just fine, and may be
> performing very important tasks, resetting the whole core because the
> non-secure side lost control of its side is not okay.

For suspend/resume, I think the right solution is to put dra7
CPU1 into retention instead trying to put it into off which will
fail. This should fix the "smp_ops.cpu_die() returned, trying to
resuscitate" issue. And then there is no need to repark CPU1
anywhere for suspend/resume as it's not spinning. And it's context
won't get lost and no reset is needed. And some power is saved.

For kexec, things are trickier. If CPU1 is in some deeper power
state, it will wake to the configured address and there's no way
to reconfigure that AFAIK. So reset CPU1 reset is needed from that
state. Note that HS omap4 implementations do seem to survive CPU1
off mode just fine.

Andrew, does your use case really need kexec supported? If not,
I think the sane thing for is to just disable kexec in the HS
kernel for dra7 during runtime.

And then if it turns out we really need to repark CPU1 for kexec
into boot ROM, at least the following changes are needed:

1. We need to differentiate between suspend/resume and kexec for
   CPU1 hot-unplug so we can put CPU1 into retention for
   suspend/resume and park CPU1 for kexec

2. When parking CPU1 for kexec, it can be done in two stages.
   We can first park it to a loop waiting for flat memory mapping,
   then jump to boot ROM loop. But flat memory mapping is not
   enough we also need to remap boot ROM and L4.. Probably waiting
   for MMU off won't work here

So depending on the use cases, I don't know if implementing these
two are really needed or make sense.

Regards,

Tony
