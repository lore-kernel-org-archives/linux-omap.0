From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/7] memory: omap-gpmc: Refactor OneNAND support
Date: Thu, 9 Nov 2017 09:56:26 -0800
Message-ID: <20171109175626.GD28152@atomide.com>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091253.lvrzi5kbaykkxlcb@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171109091253.lvrzi5kbaykkxlcb@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Ladislav Michl <ladis@linux-mips.org> [171109 09:14]:
> Use generic probe function to deal with OneNAND node and remove now useless
> gpmc_probe_onenand_child function.
> Import sync mode timing calculation function from mach-omap2/gpmc-onenand.c
> and prepare for MTD driver DTfication.

I tried giving this series a try on n900, but looks like onenand is no longer
seen on n900 after this first patch.

Regards,

Tony

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
