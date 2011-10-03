From: Nicolas Pitre <nico@fluxnic.net>
Subject: Please help with the OMAP static mapping mess
Date: Mon, 03 Oct 2011 14:59:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


<rant>

I must state up front that I'm starting to share the frustration that 
was publicly expressed by some other kernel maintainers on a few 
occasions during the last year.  I'm sorry that this frustration 
build-up often ends up bursting out on the OMAP code, but the OMAP 
kernel community is not (or at least used not to) always play fair with 
the rest of the kernel code and this is probably what is tipping us over 
the edge.  There is a faint "let's hack our way through locally and work 
around the generic code limitations" smell here that is not pleasant at 
all.

</rant>

So... here's the issue:

In arch/arm/mach-omap2/common.c:

static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
{
        omap2_set_globals_tap(omap2_globals);
        omap2_set_globals_sdrc(omap2_globals);
        omap2_set_globals_control(omap2_globals);
        omap2_set_globals_prcm(omap2_globals);
}

and also

void __init omap2_set_globals_443x(void)
{
        omap2_set_globals_tap(&omap4_globals);
        omap2_set_globals_control(&omap4_globals);
        omap2_set_globals_prcm(&omap4_globals);
}

Except for omap2_set_globals_tap(), those calls all look like:

void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
{
        /* Static mapping, never released */
        if (omap2_globals->prm) {
                prm_base = ioremap(omap2_globals->prm, SZ_8K);
                WARN_ON(!prm_base);
        }
        if (omap2_globals->cm) {
                cm_base = ioremap(omap2_globals->cm, SZ_8K);
                WARN_ON(!cm_base);
        }
        if (omap2_globals->cm2) {
                cm2_base = ioremap(omap2_globals->cm2, SZ_8K);
                WARN_ON(!cm2_base);
        }
}

The problem is that those ioremap() calls are performed _*before*_ the 
memory is fully set up yet, and also even before the corresponding 
static mappings are even in place!  So not only is the ioremap code 
unoperational at this point, but a generic way to trap ioremap() calls 
in order to toss a static mapping back won't even work here because 
iotable_init() was not even called yet.

The current code get away with it because OMAP is providing its own 
__arch_ioremap() which does the interception and provide a virtual 
address from hardcoded but yet to exist mappings.  But the goal of 
global kernel maintenance is to _remove_ such SOC-specific special cases 
and move such a perfectly valid optimization into core code where it can 
be applied uniformly to all.  So the OMAP __arch_ioremap() is going 
away, meaning that static mappings have to be in place before ioremap() 
calls can return something minimally usable.

OK, so let's modify omap4_panda_map_io() just to test this one board and 
reverse the omap44xx_map_common_io() and omap2_set_globals_443x() call 
order.  Now the mappings will be there before ioremap() is called.  But 
that, too, doesn't work and the kernel now complains with:

|OMAP revision unknown, please fix!
|Uninitialized omap_chip, please fix!
|Could not detect SRAM size

But it looks like omap2_set_globals_tap() still has to be called first!  
Isn't this wonderfully convoluted?

Also the repeated local_flush_tlb_all()/flush_cache_all() calls found in 
the OMAP mdesc->map_io code paths (one in _omap2_map_common_io(), 
another in omap_map_sram(), just to pick those as examples) is a sure 
sign that too much is being done via this call and layering violations 
are present.

So could someone in the OMAP camp fix this nonsense ASAP please?
Of course, yesterday would be best.

Furthermore... there is also a static mapping for physical address 
0x4e000000 using virtual address 0xff100000 which is already reserved 
for other purposes i.e. the consistent DMA area.  It is not immediately 
obvious where this comes from without being intimate with the OMAP code. 
Can this be fixed as well i.e. moved elsewhere please?

Patches will be extremely welcome.
Thank you.


Nicolas
