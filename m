From: Matthew Percival <matthew@capgo.com>
Subject: Using McBSP in kernel...
Date: Wed, 19 Jul 2006 16:56:17 +1000
Message-ID: <1153292177.5167.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

	I have been trying to write a driver that makes use of McBSP2 in SPI
mode recently, but seem to have missed a step or something along the
way.  The following code is included in my drivers __init block:

	struct omap_mcbsp_spi_cfg mcbsp2_spi_conf;

	if (omap_mcbsp_request(OMAP_MCBSP2))
		return -EBUSY;
	omap_mcbsp_stop(OMAP_MCBSP2);

	mcbsp2_spi_conf.spi_mode = OMAP_MCBSP_SPI_MASTER;
	mcbsp2_spi_conf.rx_clock_polarity = OMAP_MCBSP_CLK_RISING;
	mcbsp2_spi_conf.tx_clock_polarity = OMAP_MCBSP_CLK_FALLING;
	mcbsp2_spi_conf.fsx_polarity = OMAP_MCBSP_FS_ACTIVE_LOW;
	mcbsp2_spi_conf.clk_div = 1;
	mcbsp2_spi_conf.clk_stp_mode = OMAP_MCBSP_CLK_STP_MODE_NO_DELAY;
	mcbsp2_spi_conf.word_length = OMAP_MCBSP_WORD_32;
	omap_mcbsp_set_spi_mode(OMAP_MCBSP2, &mcbsp2_spi_conf);

	Then, on open(), I make the following call:

	omap_mcbsp_start(OMAP_MCBSP2);

	On certain events, I also call the following:

	omap_mcbsp_spi_master_recv_word_poll(OMAP_MCBSP2, (u32 *)data)
	omap_mcbsp_spi_master_xmit_word_poll(OMAP_MCBSP2, config);

	When I call these, I would expect to see activity on the McBSP2 pins,
but do not see anything on McBSP2.DX, McBSP2.CLKX or McBSP2.FSX.  I have
verified that I am able to write to the registers, so the module should
be configured correctly.  Is there some kind of an additional operation
I need to perform at some point when making use of the functions already
available in kernel?

	A register dump performed after calling omap_mcbsp_start() returns the
following:
		DRR2:  0x0000
		DRR1:  0x0000
		DXR2:  0x0000
		DXR1:  0x0000
		SPCR2: 0x00c3
		SPCR1: 0x1001
		RCR2:  0x0001
		RCR1:  0x00a0
		XCR2:  0x0001
		XCR1:  0x00a0
		SRGR2: 0x2000
		SRGR1: 0x0000
		PCR0:  0x0a0b
These look about right to me, leaving me at a loss to what could be
wrong.  My initial suspicion was that this were simply a clock issue,
but since McBSP2 only uses ARM_PER, that seems improbable.

	-- Matthew
