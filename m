From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/06] OMAP3 CPUidle patches - supports C0-C5
Date: Thu, 4 Sep 2008 22:19:04 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809042213030.25143@utopia.booyaka.com>
References: <63857.192.168.10.89.1219755782.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39156 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbYIEETH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 00:19:07 -0400
In-Reply-To: <63857.192.168.10.89.1219755782.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Rajendra,

On Tue, 26 Aug 2008, Rajendra Nayak wrote:

> This is an updated set of CPUidle patches for OMAP3 with a few more comment
> fixes, cleanup, 2.6.27-rc3 migration.

Thanks - here are a few more review comments:


Bugs
----

1. In patch 3/6, control.c:omap3_save_scratchpad_contents() calls
   get_restore_pointer().  This is defined in sleep34xx.S; its purpose
   appears to be to return the SRAM address of the code at the
   "restore" label in omap34xx_cpu_suspend(), later in the same file.
   Is this summary correct?  If so, I don't see how this can
   work.  The code will initially be loaded into SDRAM space,
   so the address of the "restore" label will be an address in SDRAM.
   omap34xx_cpu_suspend() will get pushed into SRAM by pm34xx.c during
   boot, but the address of the "restore" label will still be in SDRAM
   code.  To me, it seems that the get_restore_pointer() SRAM code is
   unnecessary and should be dropped; and that you should add a
   ".globl restore" directive in sleep34xx.S to make the label
   available to the linker.  Is this interpretation correct?


2. In patch 3/6, the memcpys to scratchpad space should use
   memcpy_toio().


3. In patch 4/6, the scratchpad reads/writes in restore_table_entry()
   should use __raw_writel/__raw_readl.


Optimizations
-------------

4. In patch 1/6, the two pwrdm_lookup() calls should be moved out of 
   omap3_enter_idle() to keep it fast.  Move them to omap3_idle_init(), 
   and just use file static mpu_pd, core_pd variables.


CodingStyle
-----------

5. In several places in these patches, your comments are missing a
   space between the comment text and the comment delimiter */.
   Please add a space in on these per CodingStyle.  You can use the
   following command to find these in your patches/source files:

   egrep -n '[^[:space:]]\*/' filename_goes_here


6. In patch 2/6, in omap3_enter_idle() changes, remove second semicolon 
here:

+       struct powerdomain *mpu_pd, *core_pd;;


7. In patch 2/6: in the pm34xx.c:omap_sram_idle(), use tabs rather
   than spaces for indentation here:

+             set_pwrdm_state(neon_pwrdm, mpu_next_state);


8. In patch 3/6: in control.c:omap3_clear_scratchpad_contents(), this
   comment should be changed to follow CodingStyle for multi-line
   comments, e.g.:
 
   /*
    * Clears the scratchpad contents in case of cold boot -
    * called during bootup
    */

   rather than:

+/* Clears the scratchpad contents in case of cold boot-
+ called during bootup*/


9. In patch 4/6, most of the comments in restore_table_entry() seem
   unnecessary and should be removed.  It would be much better to have
   a good comment at the top of this function explaining why the MMU
   table address needs to be converted from a physical address to a
   virtual address.  (I assume this is the address of the page table?)


Other
-----

10. In patch 2/6: in pm34xx.c:omap3_pm_init(), the comment beginning with
    "REVISIT: This wkdep" should go *between* the two pwrdm_add_wkdep()
    statements, rather than before them, since it only applies to the
    second pwrdm_add_wkdep().

+       /*
+        * REVISIT: This wkdep is only necessary when GPIO2-6 are enabled for
+        * IO-pad wakeup.  Otherwise it will unnecessarily waste power
+        * waking up PER with every CORE wakeup - see
+        * http://marc.info/?l=linux-omap&m=121852150710062&w=2
+       */
+       pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
+       pwrdm_add_wkdep(per_pwrdm, core_pwrdm);


11. Scratchpad is misspelled on patch 3/6: s/SCRATHPAD/SCRATCHPAD/g 

+       u32 max_offset = OMAP343X_SCRATHPAD_ROM_OFFSET;


12. In patch 3/6, in control.c:omap3_clear_scratchpad_contents(),
    please use:

        if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3430_PRM_RSTST_OFFSET) & 
	    OMAP3430_GLOBAL_COLD_RST)) {

   in place of this:

+       if (__raw_readl(OMAP3430_PRM_RSTST) & 0x1) {

   The former uses preprocessor macros rather than "magic numbers," so
   is easier to understand; and uses the PRCM accessor functions
   rather than __raw_readl.


13. In patch 3/6, in control.c:omap3_clear_scratchpad_contents(),
    please use: 

    prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST, OMAP3430_GR_MOD, 
                         OMAP3430_PRM_RSTST_OFFSET);

    in place of this code:

+               v = __raw_readl(OMAP3430_PRM_RSTST);
+               v |= 0x1;
+               __raw_writel(v, OMAP3430_PRM_RSTST);


14. In patch 3/6, in control.c, please drop the OMAP3430_PRM_RSTST define,
    since it now should no longer be necessary.


15. In patch 3/6, in control.c:omap3_save_scratchpad_contents(),
    please get rid of the following casts in the public_restore_ptr and 
    sdrc_context_addr assignments by defining them as (u32 *) in the 
    scratchpad_contents structure.

+       scratchpad_contents.public_restore_ptr =
+                       (u32)((u32 *)virt_to_phys(get_restore_pointer()));

+       sdrc_block_contents.sdrc_context_addr =
+                       (u32)((u32 *)io_v2p(context_mem));


16. In patch 3/6 in control.c:restore_table_entry(), scratchpad_address
    and address should be void __iomem *, and io_p2v() should be 
    OMAP2_IO_ADDRESS() per rmk's recent changes:

+       scratchpad_address = (u32 *)io_p2v(OMAP343X_SCRATCHPAD);

+       address = (u32 *) *(scratchpad_address + OMAP343X_TABLE_ADDRESS_OFFSET);


17. In patch 3/6: please add a comment noting that the "/4" works because
    all scratchpad data are 32 bits long.


18. In patch 3/6: in control.h, please at least define these macros as
    offsets from OMAP343X_CTRL_BASE, e.g., (OMAP343X_CTRL_BASE + 0x860).
    Absolute address defines just cause maintenance headaches in the long
    run.

+#define OMAP343X_SCRATCHPAD_ROM                0x48002860
+#define OMAP343X_SCRATCHPAD            0x48002910


19. In patch 3/6: the scratchpad sdrc_context_addr field gets a
    pointer to u32 context_mem[128], defined in pm34xx.c, with an
    extern defined in control.h.  Since this array presumably contains
    SDRC context data, it belongs in mach-omap2/sdrc.c, not pm34xx.c.
    Similarly, please put the prototype in mach-omap2/sdrc.h, not
    control.h; and #include mach-omap2/sdrc.h into control.c.

+u32 context_mem[128];
+

+extern u32 context_mem[128];


20. In patch 5/6: The changes to sleep34xx.S in this patch don't look 
    right.  Can you drop them, or write more about the motivation behind
    them?





- Paul
