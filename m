From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 7/9] drm/tilcdc: fix double kfree
Date: Sat,  7 Jun 2014 00:02:06 -0300
Message-ID: <1402110128-30471-8-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: stable-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, David Airlie <airlied@linux.ie>, Russell King <linux@arm.linux.org.uk>, Rob Clark <robdclark@gmail.com>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

display_timings_release calls kfree on the display_timings object passe=
d
to it. Calling kfree after it is wrong. SLUB debug showed the following
warning:

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
    BUG kmalloc-64 (Tainted: G        W    ): Object already free
    -------------------------------------------------------------------=
----------

    Disabling lock debugging due to kernel taint
    INFO: Allocated in of_get_display_timings+0x2c/0x214 age=3D601 cpu=3D=
0
    pid=3D884
     __slab_alloc.constprop.79+0x2e0/0x33c
     kmem_cache_alloc+0xac/0xdc
     of_get_display_timings+0x2c/0x214
     panel_probe+0x7c/0x314 [tilcdc]
     platform_drv_probe+0x18/0x48
     [..snip..]
    INFO: Freed in panel_destroy+0x18/0x3c [tilcdc] age=3D0 cpu=3D0 pid=
=3D907
     __slab_free+0x34/0x330
     panel_destroy+0x18/0x3c [tilcdc]
     tilcdc_unload+0xd0/0x118 [tilcdc]
     drm_dev_unregister+0x24/0x98
     [..snip..]

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/ti=
lcdc/tilcdc_panel.c
index 1943b2f..b085dcc 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -286,10 +286,8 @@ static void panel_destroy(struct tilcdc_module *mo=
d)
 {
 	struct panel_module *panel_mod =3D to_panel_module(mod);
=20
-	if (panel_mod->timings) {
+	if (panel_mod->timings)
 		display_timings_release(panel_mod->timings);
-		kfree(panel_mod->timings);
-	}
=20
 	tilcdc_module_cleanup(mod);
 	kfree(panel_mod->info);
--=20
2.0.0.rc2
