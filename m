From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] omap: headers: Move mtd-xip.h to be mach-omap1 specific
Date: Wed, 14 Oct 2009 14:49:36 -0700
Message-ID: <20091014214936.30227.98582.stgit@kaulin.muru.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091014213748.30227.71513.stgit@kaulin.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

These registers are omap1 specific.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

 arch/arm/mach-omap1/include/mach/mtd-xip.h |   61 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mtd-xip.h  |   61 ----------------------------
 2 files changed, 61 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/mtd-xip.h
 delete mode 100644 arch/arm/plat-omap/include/mach/mtd-xip.h

diff --git a/arch/arm/plat-omap/include/mach/mtd-xip.h b/arch/arm/mach-omap1/include/mach/mtd-xip.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/mtd-xip.h
rename to arch/arm/mach-omap1/include/mach/mtd-xip.h
