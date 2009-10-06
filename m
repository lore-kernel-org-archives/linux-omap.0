From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv3 0/7] TWL6030 audio codec initial support
Date: Tue, 6 Oct 2009 02:29:29 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90C2F647@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Following patch series adds initial support for TWL6030 codec
driver.

Changes from v2:
- CODEC now handles scenarios where no platform data is passed
- Removed GPIOLIB dependency of codec driver
- Removed magic values, register reads instead
- Added runtime constraints depending on sysclk
- Added more constraints for switching to low-power mode
- Use request_threaded_irq instead (oneshot support required)
- wait_for_completion with timeout
- Changelog now gives a better explanation of features and
  corresponding changes

Thanks,
-Misa

---

Misael Lopez Cruz (7):
      OMAP4: PMIC: Add support for twl6030 codec
      ASoC: TWL6030: Add twl6030 codec driver
      ASoC: TWL6030: Manual power-up/down sequences
      ASoC: TWL6030: Add support for low-power PLL
      ASoC: TWL6030: Add restrictions for low-power playback mode
      ASoC: TWL6030: Enable audio interrupt
      ASoC: TWL6030: Detect power-up sequence completion

 drivers/mfd/twl-core.c     |   15 +
 include/linux/i2c/twl.h    |    7 +
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/twl6030.c | 1242 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl6030.h |  141 +++++
 6 files changed, 1411 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/twl6030.c
 create mode 100644 sound/soc/codecs/twl6030.h
