From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 4/5] tsc2101 mixer fixes.
Date: Fri, 18 Aug 2006 04:16:30 +0300
Message-ID: <44E514EE.7000108@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090602050909020105060201"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090602050909020105060201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

tsc2101 mixer fixes. Fix target selection control name and set index to
0 for all controls as the driver uses always same tsc2101 codec.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>



--------------090602050909020105060201
Content-Type: text/x-patch;
 name="0004-tsc2101-mixer-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0004-tsc2101-mixer-fixes.patch"

>From 80a5c954be4b3dc399e98cc35490b892e5f7ad8a Mon Sep 17 00:00:00 2001
From: Mika Laitio <lamikr@cc.jyu.fi>
Date: Fri, 18 Aug 2006 03:04:05 +0300
Subject: [PATCH 4/5] tsc2101 mixer fixes.

tsc2101 mixer fixes. Fix target selection control name and set index to 0 for all controls as the driver uses always same tsc2101 codec.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
---
 sound/arm/omap/omap-alsa-tsc2101-mixer.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.c b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
index 0fc31ef..1c7627f 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
@@ -728,7 +728,7 @@ static int __handset_playback_switch_put
 
 static snd_kcontrol_new_t tsc2101_control[] __devinitdata = {
 	{
-		.name  = "Playback Playback Route",
+		.name  = "Target Playback Route",
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.index = 0,
 		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -754,7 +754,7 @@ static snd_kcontrol_new_t tsc2101_contro
 	}, {
 		.name  = "Headset Playback Volume",
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index = 1,
+		.index = 0,
 		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
 		.info  = __headset_playback_volume_info,
 		.get   = __headset_playback_volume_get,
@@ -762,7 +762,7 @@ static snd_kcontrol_new_t tsc2101_contro
 	}, {
 		.name  = "Headset Playback Switch",
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index = 1,
+		.index = 0,
 		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
 		.info  = __headset_playback_switch_info,
 		.get   = __headset_playback_switch_get,
@@ -770,7 +770,7 @@ static snd_kcontrol_new_t tsc2101_contro
 	}, {
 		.name  = "Handset Playback Volume",
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index = 2,
+		.index = 0,
 		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
 		.info  = __handset_playback_volume_info,
 		.get   = __handset_playback_volume_get,
@@ -778,7 +778,7 @@ static snd_kcontrol_new_t tsc2101_contro
 	}, {
 		.name  = "Handset Playback Switch",
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index = 2,
+		.index = 0,
 		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
 		.info  = __handset_playback_switch_info,
 		.get   = __handset_playback_switch_get,
-- 
1.4.2


--------------090602050909020105060201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090602050909020105060201--
