From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Tue, 14 Mar 2017 11:02:02 -0500
Message-ID: <d0fe191f-66f8-b72d-0a2a-00815e663a8d@ti.com>
References: <20170313205231.1593-1-tony@atomide.com>
 <0bade322-5bee-412f-ef21-972c99846e84@ti.com>
 <20170314151725.GC20572@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170314151725.GC20572@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/14/2017 10:17 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170314 00:32]:
>> On 13/03/17 22:52, Tony Lindgren wrote:
>>> Additionally we also need to fix the hot-unplug code to properly park CPU1
>>> to the bootrom loop so it's not affected by SDRAM changes done by kexec
>>> booting kernel.
>>
>> Imo, we are doing too much bandaid hackery for this issue now. How much do
>> we care if the older kernels don't work properly with kexec? I know I don't
>> care a bit myself. It means you just need to do 1 cold-boot for the system
>> to fix it.
> 
> Well kexec is a standard Linux feature and it is currently working and
> at least I care.
> 
> And if the CPU1 start-up address is programmed to be in the currently
> booting kernel's area by something else, it's almost certainly totally
> broken.
> 

I disagree, the core can be parked correctly and still have the boot-to
address point to anywhere. There are two registers in play here, one
sets the target jump-to address, the other lets it out of the parking
loop. To know we are not parked we need to check the parking release
register, the jump-to address is completely irrelevant as a check for
proper parking.

> Note that this still does not remove the need to park CPU1 properly to
> bootrom loop.
> 

I agree, and if we always park the the core correctly every time then
there is no reason to do all these checks and resets, we just boot as
normal.

If the core is not parked correctly then the system is messed up and
should be cold-booted, we have no way to know whether that core is off
running in space wreaking stuff.

I cannot think of any reliable test, for now the focus should be
figuring out why we have escaped cores in the first place.

In my testing, core1 always ends up looping in omap4_cpu_die(), the loop
in this function doesn't check for the boot-to address register, just
the core release register. I'm not sure how this works at all, if even
in the same kernel, when trying to bring this core back up it will
ignore our set boot-to address and return to the caller of this
function. Maybe the kernel is able to cope with that, but it does not
seem to be the intended wakeup path.

I'll do some testing and see if this will help in omap4_cpu_die():

if (boot_cpu == smp_processor_id()) {
	/*
	 * OK, proper wakeup, we're done
	 */
+
+	boot_address = readl_relaxed(base + OMAP_AUX_CORE_BOOT_1);
+	boot_address();
+
	break;
}

Andrew
