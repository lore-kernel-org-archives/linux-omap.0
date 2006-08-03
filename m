From: Tony Lindgren <tony@atomide.com>
Subject: GPMC timings for smc91x on 24xx (WAS: Pending July patches)
Date: Thu, 3 Aug 2006 16:03:37 +0300
Message-ID: <20060803130336.GA18147@atomide.com>
References: <20060803111721.GH8661@atomide.com>
	<20060803120858.53676.qmail@web37909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060803120858.53676.qmail@web37909.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060803 15:09]:
> --- Tony Lindgren <tony@atomide.com> wrote:
> 
> > 
> > Cool, thanks. I'll start digging through these patches, and then
> > tag 2.6.17-omap2 before we pull from Linus' tree.
> > 
> 
> Also, my patches on using gpmc_* apis for board_h4.c was not on the
> list of upstream patches for 2.6.18 window. So, please consider them
> for 2.6.19 :)

In general we want to have everything in sync with the mainline, and be
able to use the mainline tree for omap boards.

The reason I did not send h4 smc91x gpmc yet is that we should update it
to use gpmc_cs_set_timings() to have a nice example available for others :)

Could you try something like the sample code below for h4? You most likely
need to modify the values, but this is how Juha intended the gpmc being used.

static int __init smc91x_set_async_mode(int cs)
{
	struct gpmc_timings t;
	u32 reg;

	memset(&t, 0, sizeof(t));
	t.sync_clk = 0;
	t.cs_on = 0;
	t.adv_on = gpmc_round_ns_to_ticks(1);

	/* Read */
	t.adv_rd_off = t.adv_on + gpmc_round_ns_to_ticks(7);
	t.oe_on = t.adv_rd_off + gpmc_round_ns_to_ticks(1);
	t.access = t.oe_on + gpmc_round_ns_to_ticks(1);
	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
	t.cs_rd_off = t.oe_off;
	t.rd_cycle = t.cs_rd_off + gpmc_round_ns_to_ticks(1);

	/* Write */
	t.adv_wr_off = t.adv_on + gpmc_round_ns_to_ticks(7);
	t.we_on = t.adv_wr_off + gpmc_round_ns_to_ticks(1);
	t.we_off = t.we_on + gpmc_round_ns_to_ticks(1);
	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(1);
	t.wr_cycle = t.cs_wr_off + gpmc_round_ns_to_ticks(1);

	reg =	GPMC_CONFIG1_PAGE_LEN(2) |
		GPMC_CONFIG1_WAIT_READ_MON |
		GPMC_CONFIG1_WAIT_WRITE_MON |
		GPMC_CONFIG1_WAIT_PIN_SEL(2) |
		GPMC_CONFIG1_READTYPE_ASYNC |
		GPMC_CONFIG1_WRITETYPE_ASYNC |
		GPMC_CONFIG1_DEVICESIZE_16 |
		GPMC_CONFIG1_DEVICETYPE_NOR |
		GPMC_CONFIG1_MUXADDDATA;

	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, reg);

	return gpmc_cs_set_timings(cs, &t);
}

Then just do something like:

ret = smc91x_set_async_mode(SMC91X_CS);
if (ret != 0) {
	printk(KERN_ERR "dklfjdkfjdkfj\n");
	return ret;
}

Also, do you have a patch to improve the 2422 vs 2423 detection? It
would be nice to get rid of this in board-h4.c:

/* FIXME: This function should be moved to some other file, gpmc.c? */

/* H4-2420's always used muxed mode, H4-2422's always use non-muxed
 *
 * Note: OMAP-GIT doesn't correctly do is_cpu_omap2422 and
 * is_cpu_omap2423
 *  correctly.  The macro needs to look at production_id not just
 *  hawkeye.
 */
static u32 is_gpmc_muxed(void)
{
	u32 mux;
	mux = get_sysboot_value();
	if ((mux & 0xF) == 0xd)
		return 1;	/* NAND config (could be either) */
	if (mux & 0x2)		/* if mux'ed */
		return 1;
	else
		return 0;
}

Regards,

Tony
