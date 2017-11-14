From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 02/16] ARM: dts: OMAP2+: Add compatible property to
 onenand node
Date: Tue, 14 Nov 2017 13:39:02 -0800
Message-ID: <20171114213902.GD28152@atomide.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111211735.2a3q5lw4itsltjrw@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171111211735.2a3q5lw4itsltjrw@lenoch>
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

* Ladislav Michl <ladis@linux-mips.org> [171111 21:19]:
> OMAP onenand nodes are missing compatible property, add it.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Best to merge this one with the MTD patches, otherwise it will be a
layered mess of merges:

Acked-by: Tony Lindgren <tony@atomide.com>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
