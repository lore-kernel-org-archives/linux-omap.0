From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 10/14] PM / MIPS: Use struct syscore_ops instead of
	sysdevs for PM
Date: Mon, 18 Apr 2011 11:12:18 +0100
Message-ID: <20110418101218.GA25325@linux-mips.org>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
	<201104172312.35060.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201104172312.35060.rjw@sisk.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>, Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch breaks the Alchemy kernel compile; below patch on top of it fixes
that again.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
 arch/mips/alchemy/common/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-mips/arch/mips/alchemy/common/irq.c
===================================================================
--- linux-mips.orig/arch/mips/alchemy/common/irq.c
+++ linux-mips/arch/mips/alchemy/common/irq.c
@@ -619,8 +619,8 @@ static struct syscore_ops alchemy_ic_sys
 
 static int __init alchemy_ic_syscore_init(void)
 {
-	alchemy_ic_data[0].base = ioremap(icbase[IC0_PHYS_ADDR], 0x1000);
-	alchemy_ic_data[1].base = ioremap(icbase[IC1_PHYS_ADDR], 0x1000);
+	alchemy_ic_data[0].base = ioremap(IC0_PHYS_ADDR, 0x1000);
+	alchemy_ic_data[1].base = ioremap(IC1_PHYS_ADDR, 0x1000);
 
 	register_syscore_ops(&alchemy_ic_syscore_ops);
