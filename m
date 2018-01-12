From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 13/14] mtd: onenand: omap2: Configure driver from DT
Date: Fri, 12 Jan 2018 15:47:44 +0200
Message-ID: <07fd84e9-9df9-bc6f-c8f1-201e088ce807@ti.com>
References: <20180112131105.GA13810@lenoch> <20180112131725.GN13810@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180112131725.GN13810@lenoch>
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

On 12/01/18 15:17, Ladislav Michl wrote:
> Move away from platform data configuration and use pure DT approach.
> 
> Use generic probe function to deal with OneNAND node and remove now useless
> gpmc_probe_onenand_child function. Import sync mode timing calculation
> function from mach-omap2/gpmc-onenand.c
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Roger Quadros <rogerq@ti.com>


-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
