From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2] Provide interface for audio support in DSS
Date: Thu, 3 May 2012 19:53:52 -0500
Message-ID: <1336092833-1908-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tomi.valkeinen@ti.com
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, lrg@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, s-chereau@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

This patch is proposed as a result of a previous discussion related to
include audio support in the DSS device driver
(http://www.spinics.net/lists/linux-omap/msg64748.html)

At the moment, this is intended to cover display technologies with audio based
on CEA-861 and IEC-60958, such as HDMI and DisplayPort. However, provisions are
made to make it extensible (see below).

These are the changes with respect to v1:

* The audio_enable and audio_start functions were split into enable/disable
  and  start/stop respectively to improve readability.
* Comments were added on whether the DSS audio functions may sleep.
* In order to make the audio configuration parameters extensible, a
  struct omap_dss_audio is defined. This helps to easily add more config
  parameters in the future if/when required (e.g., speaker order configuration).
 
BR,

Ricardo


Ricardo Neri (1):
  OMAPDSS: Provide an interface for audio support in DSS

 Documentation/arm/OMAP/DSS |   38 ++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h    |   25 +++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

-- 
1.7.5.4
