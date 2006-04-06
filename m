From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] Convert OSS aic23 to mutex
Date: Thu, 06 Apr 2006 16:45:00 +0200
Message-ID: <4435296C.5040304@gmail.com>
References: <443407FB.2060304@gmail.com> <20060405190013.GA5532@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030906040908080409020604"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060405190013.GA5532@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <paul.mundt@nokia.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------030906040908080409020604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Mundt wrote:
> Are you sure this doesn't need an #include <linux/mutex.h>? All of the
> other conversions so far have..

It compiles without extra linux/mutex.h because
linux/sound.h includes linux/fs.h which includes
linux/mutex.h. But you are right, include linux/mutex.h is
cleaner. Please find updated patch in attachment.

Cheers

Dirk

ARM: OMAP: Convert OSS aic23 to mutex.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------030906040908080409020604
Content-Type: text/plain;
 name="omap-audio-aic23_mutex_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap-audio-aic23_mutex_patch.txt"

--- ./sound/oss/omap-audio-aic23.c_orig	2006-04-05 20:02:22.000000000 +0200
+++ ./sound/oss/omap-audio-aic23.c	2006-04-06 16:23:30.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/sound.h>
 #include <linux/soundcard.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 #include <asm/hardware.h>
@@ -243,7 +244,7 @@ static audio_state_t aic23_state = {
         .hw_remove      =  __exit_p(omap_aic23_remove),
         .hw_suspend     = omap_aic23_suspend,
         .hw_resume      = omap_aic23_resume,
-	.sem	    = __SEMAPHORE_INIT(aic23_state.sem, 1),
+	.mutex	    = __MUTEX_INITIALIZER(aic23_state.mutex),
 };
 
 /* This will be defined in the audio.h */





--------------030906040908080409020604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030906040908080409020604--
