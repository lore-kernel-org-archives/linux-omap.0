From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/2] drm/panel-simple: Add panel parameters for ortustech-com37h3m05dtc/99dtc and sharp-lq070y3dg3b
Date: Wed,  5 Jun 2019 07:07:01 +0200
Message-ID: <cover.1559711222.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com, imirkin@alum.mit.edu, marek.belisko@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

V2:
* fix typo in 99dtc panel compatible string (reported by imirkin@alum.mit.edu)

V1:

Since v5.2-rc1 OMAP is no longer using a special display driver architecture
for DPI panels, but uses the general drm/panel/panel-simple.

So we finally can add SoC independent panel definitions for two panel models
which we already had worked on quite a while ago (before device tree was
introduced):

	https://patchwork.kernel.org/patch/2851295/



H. Nikolaus Schaller (2):
  drm/panel: simple: Add Sharp LQ070Y3DG3B panel support
  drm/panel: simple: Add Ortustech COM37H3M panel support

 drivers/gpu/drm/panel/panel-simple.c | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

-- 
2.19.1
