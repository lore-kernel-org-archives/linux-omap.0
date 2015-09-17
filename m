From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2] ASoC: soc-core: Fix sparse warning in
	be32_to_cpup() call
Date: Thu, 17 Sep 2015 12:48:10 +0300
Message-ID: <1442483290-30470-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1929f0e..af4999c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3294,7 +3294,7 @@ static int snd_soc_of_get_slot_mask(struct device_node *np,
 				    unsigned int *mask)
 {
 	u32 val;
-	const u32 *of_slot_mask = of_get_property(np, prop_name, &val);
+	const __be32 *of_slot_mask = of_get_property(np, prop_name, &val);
 	int i;
 
 	if (!of_slot_mask)
-- 
1.9.1
