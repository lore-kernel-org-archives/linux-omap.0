From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/9] MAINTAINERS: Add entry for sound/soc/ti
	and update the OMAP audio support
Date: Mon, 17 Dec 2018 14:21:35 +0200
Message-ID: <20181217122142.6652-3-peter.ujfalusi@ti.com>
References: <20181217122142.6652-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181217122142.6652-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, tony@atomide.com, nsekhar@ti.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, jsarha@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The sound/soc/davinci and omap directories are merged under sound/soc/ti.

Add myself as maintainer and update the OMAP audio support section with the
new path and file names.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66183b24418d..d7c9530accce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10862,7 +10862,10 @@ M:	Jarkko Nikula <jarkko.nikula@bitmer.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-F:	sound/soc/omap/
+F:	sound/soc/ti/omap*
+F:	sound/soc/ti/rx51.c
+F:	sound/soc/ti/n810.c
+F:	sound/soc/ti/sdma-pcm.*
 
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul@pwsan.com>
@@ -14958,6 +14961,12 @@ F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
 F:	drivers/irqchip/irq-ti-sci-inta.c
 
+Texas Instruments ASoC drivers
+M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/ti/
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
