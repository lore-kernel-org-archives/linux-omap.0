From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 0/2] OMAPDSS: Couple of HDMI audio fixes
Date: Wed, 26 Aug 2015 16:11:38 +0300
Message-ID: <cover.1440594174.git.jsarha@ti.com>
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
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

The first fix is a hairy one, but I think the locking is fool proof
now. It is needed because there is no telling in which order user
space starts an audio and video stream playback. If the audio is
started first and the video mode is changed when video playback starts
the audio setup needs to survive display turning off and back on
again. After this patch the audio streams should survive a
suspend-resume cycle too.
 
The second one is a trivial work-around to a problem in ALSA constraint
resolver code.

The two fixes are totally independent and the video and audio side
patches applied separately trough their own trees.

Jyri Sarha (2):
  OMAPDSS: hdmi: Reconfigure and restart audio when display is enabled
  ASoC: omap-hdmi-audio: Set buffer bytes step constraint to 128

 drivers/video/fbdev/omap2/dss/hdmi.h  | 10 +++-
 drivers/video/fbdev/omap2/dss/hdmi4.c | 65 ++++++++++++++++++++-----
 drivers/video/fbdev/omap2/dss/hdmi5.c | 89 +++++++++++++++++++++++++++++------
 sound/soc/omap/omap-hdmi-audio.c      | 10 +++-
 4 files changed, 146 insertions(+), 28 deletions(-)

-- 
1.9.1
