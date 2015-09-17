From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: soc-core: Fix sparse warning in
	be32_to_cpup() call
Date: Thu, 17 Sep 2015 11:02:57 +0300
Message-ID: <1442476977-4284-1-git-send-email-jsarha@ti.com>
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
index 1929f0e..614b831 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3301,7 +3301,7 @@ static int snd_soc_of_get_slot_mask(struct device_node *np,
 		return 0;
 	val /= sizeof(u32);
 	for (i = 0; i < val; i++)
-		if (be32_to_cpup(&of_slot_mask[i]))
+		if (be32_to_cpup((__be32 *)&of_slot_mask[i]))
 			*mask |= (1 << i);
 
 	return val;
-- 
1.9.1
