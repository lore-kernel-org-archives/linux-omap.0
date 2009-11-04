From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/4 v2] MFD: TWL4030: Add audio_mclk to the
	codec platform data
Date: Wed,  4 Nov 2009 09:58:17 +0200
Message-ID: <1257321500-27049-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1257321500-27049-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1257321500-27049-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, sameo@linux.intel.com
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add audio_mclk to the platform data struct for the
twl4030-codec MFD driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/linux/i2c/twl4030.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 42d6c72..c188961 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -414,6 +414,7 @@ struct twl4030_codec_vibra_data {
 };

 struct twl4030_codec_data {
+	unsigned int	audio_mclk;
 	struct twl4030_codec_audio_data		*audio;
 	struct twl4030_codec_vibra_data		*vibra;
 };
--
1.6.5.2
