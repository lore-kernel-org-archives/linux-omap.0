From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Tue, 14 Mar 2017 11:14:26 -0700
Message-ID: <20170314181425.GF20572@atomide.com>
References: <20170313205231.1593-1-tony@atomide.com>
 <0bade322-5bee-412f-ef21-972c99846e84@ti.com>
 <20170314151725.GC20572@atomide.com>
 <d0fe191f-66f8-b72d-0a2a-00815e663a8d@ti.com>
 <20170314164106.GE20572@atomide.com>
 <ea09d676-29f6-7100-4c68-88920deaeb7c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ea09d676-29f6-7100-4c68-88920deaeb7c@ti.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [170314 10:59]:
> On 03/14/2017 11:41 AM, Tony Lindgren wrote:
> > * Andrew F. Davis <afd@ti.com> [170314 09:04]:
> >> On 03/14/2017 10:17 AM, Tony Lindgren wrote:
> >>> And if the CPU1 start-up address is programmed to be in the currently
> >>> booting kernel's area by something else, it's almost certainly totally
> >>> broken.
> >>>
> >>
> >> I disagree, the core can be parked correctly and still have the boot-to
> >> address point to anywhere. There are two registers in play here, one
> >> sets the target jump-to address, the other lets it out of the parking
> >> loop. To know we are not parked we need to check the parking release
> >> register, the jump-to address is completely irrelevant as a check for
> >> proper parking.
> > 
> > Well at this point we have CPU1 parked and configured for a wrong
> > start-up address. So the boot-to address is a valid check. I can
> > certainly add a check for CPU1 being parked too.

OK I sent out v3 version of the patch doing that. Can you please
review and test that one?

<snip>

Then onto the other related patches..

> We re-park cpu1 in bootROM in U-Boot already, in the U-Boot tree:
> arch/arm/mach-omap2/omap5/sec_entry_cpu1.S

OK good to hear.

> omap_smc_sec_cpu1() wakes up cpu1 into the function cpu1_entry(), this
> makes an SMC call to setup the core, then re-parks itself back in bootROM.
> Relevant code to run on cpu1:
> 
> > #define AUX_CORE_BOOT_0		0x48281800
> > #define AUX_CORE_BOOT_1		0x48281804
> > /* DRA7xx ROM code function "startup_BootSlave". This function is where CPU1
> >  * waits on WFE, polling on AUX_CORE_BOOT_x registers.
> >  * This address is same for J6 and J6 Eco.
> >  */
> > #define ROM_FXN_STARTUP_BOOTSLAVE     0x00038a64
> >
> > ldr	r4, =AUX_CORE_BOOT_0
> > mov	r5, #0x0
> > str	r5, [r4]
> > ldr	r4, =ROM_FXN_STARTUP_BOOTSLAVE
> > bx	r4	@ Jump back to ROM
> 
> We would have to do this in kernel. The issue I'm thinking we are going
> to hit is that the parking function in bootROM expects the MMU to be
> off. Although we don't really need to turn it off as long as we can
> identity map the bootROM area, the AUX_CORE_BOOT_0/1 space, and wherever
> we plan to exit the parking loop.

Would be good to hear what Russell thinks we should do here to park
CPU1.

Regards,

Tony
