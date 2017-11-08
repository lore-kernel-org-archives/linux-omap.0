From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v2 0/6] OMAP2+ OneNAND driver update
Date: Wed, 8 Nov 2017 08:40:24 +0100
Message-ID: <20171108074024.vwcfnqizvd7jajnh@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi there,

this patch serie updates OMAP2+ OneNAND driver to the present times, making
it fully DT configurable.

Patch 1 can be applied any time, it shows onenand node example and support
for onenand is currently broken on igeps - hence this patches.

Patches 3, 4 and 5 and intended for 4.15 merge window via mtd-tree as they
are cleanups only.

Patches 2 and 6 are targetted for 4.16 merge window via mtd tree as it seems
nobody tested these changes (on Nokias most importantly) so far.

Please note that unlike previous driver version, which basically ignored
DT specified timings, this one relies on it, so it is important to get
it right in your DT (dumping it from previous kernel version).

In case synchronous timings is requested, it is okay to specify timings
for the slowest chip ever used for you board as it is evetually optimized
after chip probe.

        ladis

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
