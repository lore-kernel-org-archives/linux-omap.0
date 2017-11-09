From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v3 0/7] OMAP2+ OneNAND driver update
Date: Thu, 9 Nov 2017 10:11:55 +0100
Message-ID: <20171109091155.6a6azfvjarwvlfh2@lenoch>
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

Patches 2-6 are intended for 4.15 merge window via mtd-tree as they are
cleanups only.

Patches 1 and 7 are targetted for 4.16 merge window via mtd tree as it seems
nobody tested these changes (on Nokias most importantly) so far.

Please note that unlike previous driver version, which basically ignored
DT specified timings, this one relies on it, so it is important to get
it right in your DT (dumping it from previous kernel version).

In case synchronous timings is requested, it is okay to specify timings
for the slowest chip ever used for you board as it is evetually optimized
after chip probe.

Ladislav Michl (7):
  memory: omap-gpmc: Refactor OneNAND support
  mtd: onenand: omap2: Remove regulator support
  mtd: onenand: omap2: Remove skip initial unlocking support
  mtd: onenand: omap2: Remove partitioning support from platform data
  mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA implementation
  mtd: onenand: omap2: Do not make delay for GPIO OMAP3 specific
  mtd: onenand: omap2: Configure driver from DT

 drivers/memory/omap-gpmc.c  | 158 ++++++++++----
 drivers/mtd/onenand/omap2.c | 512 ++++++++++++++++----------------------------
 include/linux/omap-gpmc.h   |  25 +++
 3 files changed, 330 insertions(+), 365 deletions(-)

-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
