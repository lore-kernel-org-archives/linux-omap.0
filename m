From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.6-rc4
Date: Sat, 22 Sep 2012 18:31:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209221817540.10663@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209051523340.11516@utopia.booyaka.com>
 <504999AB.6020703@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <504999AB.6020703@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, "Balbi, Felipe" <balbi@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

cc Santosh

Hi Igor,

I regret the delay in responding,

On Fri, 7 Sep 2012, Igor Grinberg wrote:

> On 09/05/12 18:44, Paul Walmsley wrote:
> 
> > * CM-T3517: L3 in-band error with USB OTG during boot
> >   - Cause unknown; longstanding issue; does not occur on the 3517EVM
> 
> We see this problem on several cm-t3517, but not all of them.

There's probably a dependency on the bootloader or X-Loader.

> It looks something like:
> --------------------cut----------------------------
> NET: Registered protocol family 16
> GPMC revision 5.0
> gpmc: irq-20 could not claim: err -22
> OMAP GPIO hardware version 2.5
> In-band Error seen by USB_OTG  at address 0

That tag "USB_OTG" above isn't 100% accurate for AM3517/3505, by the way.  
omap_l3_smx.c doesn't have a correct initiator map for those chips.  The 
offender could be USBOTG, but it could also be any other initiator in the 
"IP subsystem", such as Camera/VPFE or EMAC.  Table 5-18 "InitiatorID 
Definition" in the AM35x TRM vB (SPRUGR0B) lists these.

As far as I know, the message means that some module in the IPSS tried to 
initiate an L3 interconnect transaction, but that it failed.  Probably the 
IPSS isn't clocked.

> ------------[ cut here ]------------
> WARNING: at /home/lifshitz/workroot/git-repo/linux-cm-t3x/arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_irq+0xdc/0x120()
> Modules linked in:
> [<c001ad08>] (unwind_backtrace+0x0/0xf4) from [<c003f670>] (warn_slowpath_common+0x4c/0x64)
> [<c003f670>] (warn_slowpath_common+0x4c/0x64) from [<c003f6a4>] (warn_slowpath_null+0x1c/0x24)
> [<c003f6a4>] (warn_slowpath_null+0x1c/0x24) from [<c0033af0>] (omap3_l3_app_irq+0xdc/0x120)
> [<c0033af0>] (omap3_l3_app_irq+0xdc/0x120) from [<c008b8bc>] (handle_irq_event_percpu+0xac/0x298)
> [<c008b8bc>] (handle_irq_event_percpu+0xac/0x298) from [<c008bafc>] (handle_irq_event+0x54/0x74)
> [<c008bafc>] (handle_irq_event+0x54/0x74) from [<c008e290>] (handle_level_irq+0xc4/0x118)
> [<c008e290>] (handle_level_irq+0xc4/0x118) from [<c008b3ac>] (generic_handle_irq+0x2c/0x44)
> [<c008b3ac>] (generic_handle_irq+0x2c/0x44) from [<c001500c>] (handle_IRQ+0x60/0x80)
> [<c001500c>] (handle_IRQ+0x60/0x80) from [<c00085ec>] (omap3_intc_handle_irq+0x60/0x74)
> [<c00085ec>] (omap3_intc_handle_irq+0x60/0x74) from [<c04e3100>] (__irq_svc+0x40/0x74)
> Exception stack(0xcf02de00 to 0xcf02de48)
> de00: 00000000 0000000a 00000000 00000021 c074bcac cf046280 0000000a 60000013
> de20: c074bcdc c070020c 00010000 00000000 00000000 cf02de48 00000000 c008c988
> de40: 40000013 ffffffff
> [<c04e3100>] (__irq_svc+0x40/0x74) from [<c008c988>] (__setup_irq+0x2a8/0x404)
> [<c008c988>] (__setup_irq+0x2a8/0x404) from [<c008cd18>] (request_threaded_irq+0xe8/0x13c)
> [<c008cd18>] (request_threaded_irq+0xe8/0x13c) from [<c06c3d24>] (omap3_l3_probe+0x10c/0x16c)
> [<c06c3d24>] (omap3_l3_probe+0x10c/0x16c) from [<c033586c>] (platform_drv_probe+0x18/0x1c)
> [<c033586c>] (platform_drv_probe+0x18/0x1c) from [<c0334414>] (really_probe+0xac/0x1c8)
> [<c0334414>] (really_probe+0xac/0x1c8) from [<c0334578>] (driver_probe_device+0x48/0x60)
> [<c0334578>] (driver_probe_device+0x48/0x60) from [<c03345f0>] (__driver_attach+0x60/0x84)
> [<c03345f0>] (__driver_attach+0x60/0x84) from [<c0332ce0>] (bus_for_each_dev+0x4c/0x80)
> [<c0332ce0>] (bus_for_each_dev+0x4c/0x80) from [<c0333414>] (bus_add_driver+0xa4/0x294)
> [<c0333414>] (bus_add_driver+0xa4/0x294) from [<c0334bdc>] (driver_register+0xa4/0x188)
> [<c0334bdc>] (driver_register+0xa4/0x188) from [<c0335c5c>] (platform_driver_probe+0x18/0x98)
> [<c0335c5c>] (platform_driver_probe+0x18/0x98) from [<c0008798>] (do_one_initcall+0xac/0x16c)
> [<c0008798>] (do_one_initcall+0xac/0x16c) from [<c06b52ac>] (do_basic_setup+0x88/0xc0)
> [<c06b52ac>] (do_basic_setup+0x88/0xc0) from [<c06b53c4>] (kernel_init+0x60/0xfc)
> [<c06b53c4>] (kernel_init+0x60/0xfc) from [<c00150a4>] (kernel_thread_exit+0x0/0x8)
> ---[ end trace 1b75b31a2719ed1c ]---
> -----------------------------cut-------------------------------
> 
> After that, the board continues to function properly.
> Any hints how to debug this?

Probably the core problem is that we don't yet have the IPSS correctly 
supported in the AM35xx hwmod data.  This is partially due to the fact 
that we're missing hierarchical enables/disables in that code, a 
longstanding omission.  My guess is that if you hacked in some code to 
enable the IPSS early in boot (see the CONTROL_IPSS_CLK_CTRL register), 
the problem would probably go away.


- Paul
