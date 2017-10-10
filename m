From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH 1/1] cpufreq: ti-cpufreq: add missing of_node_put()
Date: Tue, 10 Oct 2017 21:27:20 +0800
Message-ID: <1507642040-13646-1-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, viresh.kumar@linaro.org, Zumeng Chen <zumeng.chen@gmail.com>, rjw@rjwysocki.net, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

call of_node_put to release the refcount of np.

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
---
 drivers/cpufreq/ti-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index ffcddcd..923317f 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -205,6 +205,7 @@ static int ti_cpufreq_init(void)
 
 	np = of_find_node_by_path("/");
 	match = of_match_node(ti_cpufreq_of_match, np);
+	of_node_put(np);
 	if (!match)
 		return -ENODEV;
 
-- 
2.7.5
