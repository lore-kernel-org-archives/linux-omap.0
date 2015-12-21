From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] OMAPDSS: fix omapfb build error due missing feat functions declaration
Date: Mon, 21 Dec 2015 15:26:24 -0300
Message-ID: <1450722384-4606-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-fbdev@vger.kernel.org, Dave Airlie <airlied@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The omapfb is failing to build in -next due missing declarations for
dss_feat_get_supported_displays() and dss_feat_get_supported_outputs():

 CC [M]  drivers/video/fbdev/omap2//omapfb/dss/dss.o
drivers/video/fbdev/omap2//omapfb/dss/dss.c: In function 'dss_save_context':
drivers/video/fbdev/omap2//omapfb/dss/dss.c:144:2: error: implicit declaration of function 'dss_feat_get_supported_displays' [-Werror=implicit-function-declaration]

Add the declaration for these functions in the dss_features.h header
file to fix this compile error.

Also, remove the functions export since are not used outside the driver.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Hello Tomi,

This seems to be caused by a wrong order in which some commits from
the omapdss tree [0] were merged, or rather a wrong base used for
the dss-drm-merge (4.4.0-rc4) and the for-next (4.4.0-rc5) branches.

The problem is that commit 2ea164a9af9c ("drm/omap: move omapdss &
displays under omapdrm") moves the dss_features.h header from the
drivers/video/fbdev/omap2/dss/ dir to drivers/gpu/drm/omapdrm}/dss.

And then commit 8b987a111b1a ("omapfb: copy omapdss & displays for
omapfb" copies the hader from the omapdrm dir to the omapfb one.

Now, since commit 66c78ddd7a2e ("OMAPDSS: make a two dss feat funcs
internal to omapdss") is the one that moves the function declaration
from the public include/video/omapdss.h header to the internal one,
this means that git will be smart enough to identify that the header
that was drivers/video/fbdev/omap2/dss/dss_features.h now is the one
in the omapdrm directory but that means that the omapfb files won't
get the changes since the move & copy happened before.

This happens AFAIU because dss-drm-merge having an older base so the
patches in for-next are rebased on top of dss-drm-merge when merging.

The issue can easily be avoided by first merging the patch that does
the feat funcs declaration move and then merging the ones that do the
per driver omapdss refactoring.

But I'm posting this patch anyways in case you can't redo your branches
and need a fix to apply on top of your current for-next.

[0]: git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git

Best regards,
Javier

 drivers/video/fbdev/omap2/omapfb/dss/dss_features.c | 2 --
 drivers/video/fbdev/omap2/omapfb/dss/dss_features.h | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss_features.c b/drivers/video/fbdev/omap2/omapfb/dss/dss_features.c
index b0b6dfd657bf..a2e26b8d6ded 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss_features.c
@@ -844,13 +844,11 @@ enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel
 {
 	return omap_current_dss_features->supported_displays[channel];
 }
-EXPORT_SYMBOL(dss_feat_get_supported_displays);
 
 enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel)
 {
 	return omap_current_dss_features->supported_outputs[channel];
 }
-EXPORT_SYMBOL(dss_feat_get_supported_outputs);
 
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane)
 {
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss_features.h b/drivers/video/fbdev/omap2/omapfb/dss/dss_features.h
index 100f7a2d0638..4474ebff8607 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss_features.h
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss_features.h
@@ -102,4 +102,7 @@ bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type);
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
 void dss_features_init(enum omapdss_version version);
+
+enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
+enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel);
 #endif
-- 
2.4.3
