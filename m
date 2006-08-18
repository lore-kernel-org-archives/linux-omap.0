From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH 1/4] TSC2102 main SPI driver
Date: Fri, 18 Aug 2006 06:27:53 -0700 (PDT)
Message-ID: <20060818132753.31468.qmail@web37908.mail.mud.yahoo.com>
References: <fb249edb0608180301u113ae66fg7be0b7a001c1cc46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0608180301u113ae66fg7be0b7a001c1cc46@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com, Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- andrzej zaborowski <balrog@zabor.org> wrote:

> This adds a driver for the TSC2102 chip by Texas Instruments. This
> driver is responsible for all communication with the chip and doesn't
> export anything for user-space, but for other drivers controlling
> devices connected to the chip.
> 

Quick review comments, will come later with more detailed review.

+	spi->transfer = kzalloc(sizeof(struct spi_transfer) * numregs,
+			GFP_KERNEL);

How about checking return value here?

+	set_irq_type(spi->irq, IRQT_FALLING);
+	if (request_irq(spi->irq, tsc2102_handler,
+				SA_SAMPLE_RANDOM, "tsc2102", &tsc)) {
+		printk(KERN_ERR "Could not allocate touchscreen IRQ!\n");
+		err = -EINVAL;
+		goto err_clk;
+	}

You should use new flags as per genirq patches, and I think
set_irq_type may not be required. 

+#define TSC2102_TS_X			0, 0x00
+#define TSC2102_TS_Y			0, 0x01

I think better/clean way could be, having defines taking page and addr
as argument. e.g

#define tsc2102_reg(page, addr) /* your code here as per pg and addr
needs to be shifted and ORed as needed*/
#define tsc2102_ts_x       tsc2102_reg(0, 0x0)

and may be conversion macros from reg_to_page and page_to_reg as
required.


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
