From: Komal Shah <komal_shah802003@yahoo.com>
Subject: n770 alsa build broken
Date: Tue, 4 Apr 2006 09:18:25 -0700 (PDT)
Message-ID: <20060404161825.67622.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Please supply the patch.

#make n770_defconfig
#make

sound/arm/omap/omap-alsa-dma.c: In function `omap_sound_dma_link_lch':
sound/arm/omap/omap-alsa-dma.c:143: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c:143: error: (Each undeclared identifier
is reported only once
sound/arm/omap/omap-alsa-dma.c:143: error: for each function it appears
in.)
sound/arm/omap/omap-alsa-dma.c:145: warning: implicit declaration of
function `FN_OUT'
sound/arm/omap/omap-alsa-dma.c: In function
`omap_request_alsa_sound_dma':
sound/arm/omap/omap-alsa-dma.c:164: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c: In function
`omap_sound_dma_unlink_lch':
sound/arm/omap/omap-alsa-dma.c:222: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c: In function `omap_free_alsa_sound_dma':
sound/arm/omap/omap-alsa-dma.c:243: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c: In function `omap_stop_alsa_sound_dma':
sound/arm/omap/omap-alsa-dma.c:277: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c: In function
`omap_clear_alsa_sound_dma':
sound/arm/omap/omap-alsa-dma.c:297: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c: In function
`audio_set_dma_params_play':
sound/arm/omap/omap-alsa-dma.c:315: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c: In function
`audio_set_dma_params_capture':
sound/arm/omap/omap-alsa-dma.c:333: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c: In function `audio_start_dma_chain':
sound/arm/omap/omap-alsa-dma.c:346: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c: In function
`omap_start_alsa_sound_dma':
sound/arm/omap/omap-alsa-dma.c:368: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c: In function `sound_dma_irq_handler':
sound/arm/omap/omap-alsa-dma.c:414: error: `FN_IN' undeclared (first
use in this function)
sound/arm/omap/omap-alsa-dma.c:419: warning: implicit declaration of
function `DPRINTK'
make[3]: *** [sound/arm/omap/omap-alsa-dma.o] Error 1
make[2]: *** [sound/arm/omap] Error 2
make[1]: *** [sound/arm] Error 2
make: *** [sound] Error 2


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
