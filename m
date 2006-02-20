From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 0/7
Date: Mon, 20 Feb 2006 20:45:59 +0100
Message-ID: <43FA1C77.5010500@gmail.com>
References: <9268368b0602200933s41905c2bp254749b1e6eff9c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080807050803030602090203"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602200933s41905c2bp254749b1e6eff9c7@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>, lamikr <lamikr@cc.jyu.fi>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080807050803030602090203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Petrini wrote:
> This series of patches adds modularisation in alsa files for omap 

> Comments and tests are welcome.

Module configuration seems to be missing in two files.

Dirk


--------------080807050803030602090203
Content-Type: text/plain;
 name="alsa_module_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_module_patch.txt"

--- ./arch/arm/mach-omap1/omap-alsa-aic23.c_orig	2006-02-20 20:35:45.000000000 +0100
+++ ./arch/arm/mach-omap1/omap-alsa-aic23.c	2006-02-20 20:36:26.000000000 +0100
@@ -22,7 +22,7 @@
  * 				  are now in the aic23_samplerate_reg_info structure.
  */
 
-#ifdef CONFIG_SND
+#if defined( CONFIG_SND) || defined(CONFIG_SND_MODULE)
 
 #include <sound/driver.h>
 #include <sound/core.h>
--- ./arch/arm/mach-omap1/omap-alsa-tsc2101.c_orig	2006-02-20 20:40:17.000000000 +0100
+++ ./arch/arm/mach-omap1/omap-alsa-tsc2101.c	2006-02-20 20:40:51.000000000 +0100
@@ -28,7 +28,7 @@
 /* routines extracted from file oss/omap-audio-tsc2101.c
  * or called from drivers/ssi/omap-tsc2101.c */
 
-#ifdef CONFIG_SND
+#if defined( CONFIG_SND) || defined(CONFIG_SND_MODULE)
 
 #include <linux/delay.h>
 #include <linux/soundcard.h>


--------------080807050803030602090203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080807050803030602090203--
