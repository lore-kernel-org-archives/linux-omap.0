From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v4 14/16] mtd: onenand: omap2: Configure driver from DT
Date: Wed, 15 Nov 2017 12:20:28 +0100
Message-ID: <20171115112028.b7sbjkmwnu2uzpey@lenoch>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212742.m5t4rf5k47kikouu@lenoch>
 <27bb610f-b30a-cd4c-ccd5-06c0d9e205b7@ti.com>
 <20171115105357.3jkk5eyxst5limj3@lenoch>
 <d9b85025-4889-106e-e346-115e7d960705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d9b85025-4889-106e-e346-115e7d960705@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 15, 2017 at 01:04:22PM +0200, Roger Quadros wrote:
> On 15/11/17 12:53, Ladislav Michl wrote:
[snip]
> > of_property_read_u32 will fail then, so I do not think it is worth adding
> > explicit test for NULL here.
> > 
> 
> But the error message would be wrong in that case.
> I'm trying to tackle the case where driver was probed using legacy methods
> where device tree/node isn't present.

But how could we ever get there in that case? platform_device_register is
removed just one patch later.

Of course we should add:
depends on (OF && GPIOLIB) || COMPILE_TEST
to the Kconfig

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
