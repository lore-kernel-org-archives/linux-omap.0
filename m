From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 7/9] ARM: omap1_defconfig: Do not select ASoC by
	default
Date: Thu, 8 Nov 2018 10:37:52 +0200
Message-ID: <20181108083754.1746-8-peter.ujfalusi@ti.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181108083754.1746-1-peter.ujfalusi@ti.com>
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

No audio support is enabled by default via ASoC, disable the code as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/configs/omap1_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 72f4bc83f467..cfc00b0961ec 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -175,8 +175,6 @@ CONFIG_SND_PCM_OSS=y
 # CONFIG_SND_VERBOSE_PROCFS is not set
 CONFIG_SND_DUMMY=y
 CONFIG_SND_USB_AUDIO=y
-CONFIG_SND_SOC=y
-CONFIG_SND_OMAP_SOC=y
 # CONFIG_USB_HID is not set
 CONFIG_USB=y
 CONFIG_USB_PHY=y
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
