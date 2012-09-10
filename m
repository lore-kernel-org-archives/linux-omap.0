From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 05/14] MFD: twl4030-audio: Get audio MCLK
	via twl-core API instead of pdata
Date: Mon, 10 Sep 2012 13:46:23 +0300
Message-ID: <1347273992-9107-6-git-send-email-peter.ujfalusi@ti.com>
References: <1347273992-9107-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1347273992-9107-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

twl-core has API to get the boot time configured HFCLK rate which has the
same rate as the audio MCLK.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl4030-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index ca2d669..a48bf3a 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -175,7 +175,7 @@ static int __devinit twl4030_audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mutex_init(&audio->mutex);
-	audio->audio_mclk = pdata->audio_mclk;
+	audio->audio_mclk = twl_get_hfclk_rate();
 
 	/* Configure APLL_INFREQ and disable APLL if enabled */
 	switch (audio->audio_mclk) {
-- 
1.7.12
