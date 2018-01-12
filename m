From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 12/14] mtd: onenand: omap2: Decouple DMA enabling from
 INT pin availability
Date: Fri, 12 Jan 2018 15:46:43 +0200
Message-ID: <7d2a452b-3f0e-0ffb-5636-a26d1a903e88@ti.com>
References: <20180112131105.GA13810@lenoch> <20180112131657.GM13810@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180112131657.GM13810@lenoch>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On 12/01/18 15:16, Ladislav Michl wrote:
> INT pin (gpio_irq) is not really needed for DMA but only for notification
> when a command that needs wait has completed. DMA memcpy can be still used
> even without gpio_irq available, so enable it unconditionally.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Tony Lindgren <tony@atomide.com>

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
