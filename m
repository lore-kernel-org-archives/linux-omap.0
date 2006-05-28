From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch warnings
Date: Sun, 28 May 2006 15:52:04 +0200
Message-ID: <4479AB04.7080501@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030707010704040604010103"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------030707010704040604010103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warnings

WARNING: drivers/pcmcia/omap_cf.o - Section mismatch:
reference to .init.text: from .data between '$d' (at offset
0x80) and 'omap_cf_ops'
WARNING: sound/arm/omap/snd-omap-alsa-aic23.o - Section
mismatch: reference to .init.text: from .data between '$d'
(at offset 0x68) and 'aic23_hw_constraints_rates'

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------030707010704040604010103
Content-Type: text/plain;
 name="sections_mismatch_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sections_mismatch_patch.txt"

--- ./sound/arm/omap/omap-alsa-aic23.c_orig	2006-05-28 15:34:02.000000000 +0200
+++ ./sound/arm/omap/omap-alsa-aic23.c	2006-05-28 15:40:52.000000000 +0200
@@ -271,7 +271,7 @@ int aic23_get_default_samplerate(void)
 	return DEFAULT_SAMPLE_RATE;
 }
 
-static int __init snd_omap_alsa_aic23_probe(struct platform_device *pdev)
+static int __devinit snd_omap_alsa_aic23_probe(struct platform_device *pdev)
 {
 	int	ret;
 	struct	omap_alsa_codec_config *codec_cfg;
--- ./drivers/pcmcia/omap_cf.c_orig	2006-05-28 15:32:25.000000000 +0200
+++ ./drivers/pcmcia/omap_cf.c	2006-05-28 15:40:56.000000000 +0200
@@ -203,7 +203,7 @@ static struct pccard_operations omap_cf_
  * "what chipselect is used".  Boards could want more.
  */
 
-static int __init omap_cf_probe(struct device *dev)
+static int __devinit omap_cf_probe(struct device *dev)
 {
 	unsigned		seg;
 	struct omap_cf_socket	*cf;


--------------030707010704040604010103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030707010704040604010103--
