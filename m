From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/5] dt: add empty dt helpers for non-dt build
Date: Mon, 10 Oct 2011 21:49:35 +0530
Message-ID: <1318263578-7407-3-git-send-email-rnayak@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1318263578-7407-1-git-send-email-rnayak@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add empty of_device_is_compatible(), of_find_property()
and of_parse_phandle() for non-dt builds to work.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 include/linux/of.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 9180dc5..47ce461 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -263,6 +263,25 @@ static inline const void *of_get_property(const struct device_node *node,
 	return NULL;
 }
 
+static inline int of_device_is_compatible(const struct device_node *device,
+				   const char *name)
+{
+	return 0;
+}
+
+static inline struct property *of_find_property(const struct device_node *np,
+					 const char *name,
+					 int *lenp)
+{
+	return NULL;
+}
+
+static inline struct device_node *of_parse_phandle(struct device_node *np,
+					    const char *phandle_name,
+					    int index)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF */
 
 static inline int of_property_read_u32(const struct device_node *np,
-- 
1.7.1
