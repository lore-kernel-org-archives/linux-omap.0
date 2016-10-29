From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 10/15] ASoC: omap-mcbsp: use permission-specific DEVICE_ATTR variants
Date: Sat, 29 Oct 2016 21:37:04 +0200
Message-ID: <1477769829-22230-11-git-send-email-Julia.Lawall@lip6.fr>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: kernel-janitors@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use DEVICE_ATTR_RW for read-write attributes.  This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@rw@
declarer name DEVICE_ATTR;
identifier x,x_show,x_store;
@@

DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);

@script:ocaml@
x << rw.x;
x_show << rw.x_show;
x_store << rw.x_store;
@@

if not (x^"_show" = x_show && x^"_store" = x_store)
then Coccilib.include_match false

@@
declarer name DEVICE_ATTR_RW;
identifier rw.x,rw.x_show,rw.x_store;
@@

- DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
+ DEVICE_ATTR_RW(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/omap/mcbsp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 06fec56..0b363d1 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -858,7 +858,7 @@ static ssize_t dma_op_mode_store(struct device *dev,
 	return size;
 }
 
-static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_mode_store);
+static DEVICE_ATTR_RW(dma_op_mode);
 
 static const struct attribute *additional_attrs[] = {
 	&dev_attr_max_tx_thres.attr,
@@ -927,7 +927,7 @@ static ssize_t st_taps_store(struct device *dev,
 	return size;
 }
 
-static DEVICE_ATTR(st_taps, 0644, st_taps_show, st_taps_store);
+static DEVICE_ATTR_RW(st_taps);
 
 static const struct attribute *sidetone_attrs[] = {
 	&dev_attr_st_taps.attr,
