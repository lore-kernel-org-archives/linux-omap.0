From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/4] Fix OMAP4 barrier support
Date: Wed, 15 Jul 2015 18:46:47 +0100
Message-ID: <20150715174647.GA7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Barry Song <baohua@kernel.org>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

OMAP4 (and other TI CPUs) allow for weak ordering of writes through
different buses in their interconnects.  In order to ensure that
accesses are performed in the correct order, we need to extend some
of the kernel barriers to ensure that the bus interconnects are
correctly ordered.

As an example, it is possible for the following code sequence:

	cpu = dma_alloc_coherent(dev, ..., &dma);

	*cpu = 1;
	writel(dma, dev_addr);

Normal kernel semantics ensures that the write to "*cpu" will become
visible at the ARM domain boundary before the write to dev_addr.

However, because of the TI interconnects, it is possible for the
write to dev_addr to hit the peripheral before the write to "*cpu"
hits memory.  Thus, if the write to the device causes the device to
attempt to read from "*cpu" (which could be via a different path)
the device won't see that write.

Hence, we need to extend the barriers to ensure proper ordering
further down the bus chain than we do already to the L2 cache.

 arch/arm/include/asm/barrier.h              |  13 ++-
 arch/arm/include/asm/outercache.h           |  17 ----
 arch/arm/kernel/irq.c                       |   1 +
 arch/arm/mach-omap2/Kconfig                 |   7 ++
 arch/arm/mach-omap2/common.c                |   1 +
 arch/arm/mach-omap2/common.h                |   9 +++
 arch/arm/mach-omap2/include/mach/barriers.h |  33 --------
 arch/arm/mach-omap2/io.c                    |   2 +
 arch/arm/mach-omap2/omap4-common.c          | 121 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sleep44xx.S             |   8 +-
 arch/arm/mach-prima2/pm.c                   |   1 +
 arch/arm/mach-ux500/cache-l2x0.c            |   1 +
 arch/arm/mm/Kconfig                         |   4 +
 arch/arm/mm/flush.c                         |  15 ++++
 14 files changed, 175 insertions(+), 58 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
