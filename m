From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 06/14] dt: Add empty of_find_node_by_name()
	function
Date: Tue, 14 Aug 2012 17:22:34 +0300
Message-ID: <1344954162-7985-7-git-send-email-peter.ujfalusi@ti.com>
References: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This commit adds an empty of_find_node_by_name() function for !CONFIG_OF
builds.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/of.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 5919ee3..c90e59a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -308,6 +308,12 @@ static inline const char* of_node_full_name(struct device_node *np)
 	return "<no-node>";
 }
 
+static inline device_node *of_find_node_by_name(struct device_node *from,
+	const char *name)
+{
+	return NULL;
+}
+
 static inline bool of_have_populated_dt(void)
 {
 	return false;
-- 
1.7.8.6
