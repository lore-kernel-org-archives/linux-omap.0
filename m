From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 15/16] ARM: OMAP2+: Remove gpmc-onenand
Date: Tue, 14 Nov 2017 13:41:24 -0800
Message-ID: <20171114214124.GF28152@atomide.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212904.2qti2txasbsmmjw7@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171111212904.2qti2txasbsmmjw7@lenoch>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [171111 21:31]:
> As OneNAND driver is now using devicetree gpmc-onenand and its
> platform data is unused and can be removed.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

And nobody's going to touch this file, so it's safe to merge
also via MTD tree:

Acked-by: Tony Lindgren <tony@atomide.com>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
