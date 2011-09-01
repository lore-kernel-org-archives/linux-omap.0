From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 01/13] irq: Add stub for none DT build in irqdomain.h
Date: Thu, 1 Sep 2011 19:21:17 +0200
Message-ID: <1314897689-17791-2-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: manjugk@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add an empty funtion to allow building a file without
adding some #ifdef CONFIG_OF around of APIs.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Grant Likely <grant.likely@secretlab.ca>
---
 include/linux/irqdomain.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e807ad6..6fa08ab 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -84,6 +84,8 @@ extern void irq_domain_add_simple(struct device_node *controller, int irq_base);
 extern void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start);
 #else /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
+static inline void irq_domain_add_simple(struct device_node *controller,
+					 int irq_base) { }
 static inline void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start) { }
 #endif /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
-- 
1.7.0.4
