From: Imre Deak <imre.deak@solidboot.com>
Subject: Re: TSC2101/2102
Date: Fri, 16 Mar 2007 09:41:57 +0200
Message-ID: <20070316074157.GA1133@bitbox.mine.nu>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com> <20070314170952.GB10230@bitbox.mine.nu>
	<002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070315102325.GA4555@bitbox.mine.nu>
	<004901c76762$06d66bc0$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <004901c76762$06d66bc0$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: 'Linux OMAP ML' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 16, 2007 at 09:28:24AM +0900, Kyungmin Park wrote:
> Hi, 
> 
> > 
> > I needed only the basic register read / write interface to access the
> > TSC2101 GPIO lines. The TS part you wrote is still needed, 
> > it's init function being called from the tsc2101.c probe, as 
> > it's done in tsc2301-core.c.
> > 
> > > The current code only supports 16-bit tsc2101 for OMAP1.
> > > We have to consider OMAP2 tsc2101 for H4 and apollon.
> > 
> > Is the 32-bit interface some alternate interface 
> > configuration for the chip?
> 
> No. it's only needed in SPI protocol.
> 
> I don't know it's possible to use 16-bit mode in OMAP2. but most driver
> which uses tsc2101 on OMAP2 uses 32-bit access.

The following is an example how you setup the transfer for 32-bit
transfer:

+static void tsc2101_ts_setup_spi_xfer(struct tsc2101 *tsc)
+{
+	struct tsc2101_ts *ts = tsc->ts;
+	struct spi_message *m = &ts->read_msg;
+	struct spi_transfer *x = &ts->read_xfer[0];
+
+	ts->address[0] = (0x8000 | TSC2101_REG_X) << 16;
+	ts->address[1] = (0x8000 | TSC2101_REG_Y) << 16;
+	ts->address[2] = (0x8000 | TSC2101_REG_Z1) << 16;
+	ts->address[3] = (0x8000 | TSC2101_REG_Z2) << 16;
+
+	spi_message_init(m);
+
+	x->tx_buf = &ts->address;
+	x->rx_buf = &ts->data;
+	x->len = 16;
+	spi_message_add_tail(x, m);
+
+	m->complete = tsc2101_ts_rx;
+	m->context = tsc;
+}

While this may work, I'm not sure the driver should have support for such
an alternate protocol. What's the benifit of it? The TSC2xxx chips have a
register address auto increment feature, so you need to send only the
starting address and then do a read for each consecutive registers. Did
you try the 16-bit mode in SPI_MODE_0 as it's done in the TSC2301 driver?

--Imre
