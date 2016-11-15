From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH 0/2] ASoC: omap-twl4030: remove legacy code
Date: Tue, 15 Nov 2016 10:01:18 +0200
Message-ID: <1479196880-20344-1-git-send-email-Nicolae_Rosia@mentor.com>
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
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

This patch series removes the omap-twl4030 platform data since
all users are now device tree based. 

These patches are based on Tony's omap-for-v4.10/legacy branch [0]
and also on [1].

[0] https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v4.10/legacy
[1] https://patchwork.kernel.org/patch/9424067/

Nicolae Rosia (2):
  ASoC: omap-twl4030: rework probing for device tree only
  mfd: twl4030-audio: make module DT only

 drivers/mfd/twl4030-audio.c                |  46 ++--------
 include/linux/i2c/twl.h                    |  23 -----
 include/linux/platform_data/omap-twl4030.h |  58 -------------
 sound/soc/codecs/twl4030.c                 |   8 ++
 sound/soc/omap/omap-twl4030.c              | 133 ++++++++++-------------------
 5 files changed, 61 insertions(+), 207 deletions(-)
 delete mode 100644 include/linux/platform_data/omap-twl4030.h

-- 
2.7.4
