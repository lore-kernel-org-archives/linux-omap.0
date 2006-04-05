From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Convert OSS aic23 to mutex
Date: Wed, 05 Apr 2006 20:10:03 +0200
Message-ID: <443407FB.2060304@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070109070400000605080801"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070109070400000605080801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Convert OSS aic23 to mutex.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------070109070400000605080801
Content-Type: text/plain;
 name="omap-audio-aic23_mutex_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap-audio-aic23_mutex_patch.txt"

--- ./sound/oss/omap-audio-aic23.c_orig	2006-04-05 20:02:22.000000000 +0200
+++ ./sound/oss/omap-audio-aic23.c	2006-04-05 20:03:05.000000000 +0200
@@ -243,7 +243,7 @@ static audio_state_t aic23_state = {
         .hw_remove      =  __exit_p(omap_aic23_remove),
         .hw_suspend     = omap_aic23_suspend,
         .hw_resume      = omap_aic23_resume,
-	.sem	    = __SEMAPHORE_INIT(aic23_state.sem, 1),
+	.mutex	    = __MUTEX_INITIALIZER(aic23_state.mutex),
 };
 
 /* This will be defined in the audio.h */


--------------070109070400000605080801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070109070400000605080801--
