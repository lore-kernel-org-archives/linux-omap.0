From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 0/8] omapdss/omapdrm: Misc fixes and improvements
Date: Tue, 26 Mar 2013 19:15:17 +0530
Message-ID: <1364305525-28496-1-git-send-email-archit@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1362493070-17706-1-git-send-email-archit@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: tomi.valkeinen@ti.com, robdclark@gmail.com, andy.gross@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

These are misc fixes and improvements within omapdrm and omapdss. The fixes do the
following:

- Make omapdrm smarter to choose the right overlay managers as it's crtcs. This
  makes sure that omapdrm is functional for OMAP platforms with different
  combinations of panels connected to it.

- Fix certain areas in omapdrm which allow fixed resolution panels to work.

- Fix functional and pixel clock limits for DISPC, this ensures we don't try
  to try a mode that the hardware can't support.

- Some changes that came in OMAP5 ES2 silicon.

Note: The branch is based on the DSS misc series and dsi video mode calc series
posted by Tomi. Reference branch:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git for-3.10/misc_drm_dss

Archit Taneja (8):
  drm/omap: Don't return from modeset_init if a panel doesn't satisfy
    omapdrm requirements
  drm/omap: Fix and improve crtc and overlay manager correlation
  drm/omap: Make fixed resolution panels work
  omapdss: features: fixed supported outputs for OMAP4
  omapdss: DISPC: add max pixel clock limits for LCD and TV managers
  omapdss: Features: Fix some parameter ranges
  OMAPDSS: DISPC: Configure doublestride for NV12 when using 2D Tiler
    buffers
  OMAPDSS: DISPC: Revert to older DISPC Smart Standby mechanism for
    OMAP5

 drivers/gpu/drm/omapdrm/omap_connector.c |   27 ++++-
 drivers/gpu/drm/omapdrm/omap_crtc.c      |   21 ++--
 drivers/gpu/drm/omapdrm/omap_drv.c       |  161 ++++++++++++++++++++++++------
 drivers/gpu/drm/omapdrm/omap_drv.h       |   38 +------
 drivers/gpu/drm/omapdrm/omap_encoder.c   |   24 ++++-
 drivers/gpu/drm/omapdrm/omap_irq.c       |   17 ++--
 drivers/video/omap2/dss/dispc.c          |   52 ++++++++--
 drivers/video/omap2/dss/dispc.h          |    1 +
 drivers/video/omap2/dss/dss_features.c   |   14 ++-
 9 files changed, 260 insertions(+), 95 deletions(-)

-- 
1.7.10.4
