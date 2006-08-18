From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH 4/4] TSC2102 OMAP audio driver
Date: Fri, 18 Aug 2006 05:39:28 -0700 (PDT)
Message-ID: <20060818123928.63792.qmail@web37901.mail.mud.yahoo.com>
References: <fb249edb0608180329k519d3355x7707fcadbddeefee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0608180329k519d3355x7707fcadbddeefee@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com, Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- andrzej zaborowski <balrog@zabor.org> wrote:

> ALSA driver for OMAP boards with a TSC2102 chip. It is based on the
> TSC2101 and AIC23 drivers. The chip has only one audio playback
> output
> and no inputs. It can play stereo sound with 16-bit samples (only)
> and
> supports different sampling rates between 8 and 48 kHz. The patch
> also
> includes an ALSA mixer. The mixer controlls two volume levels, for
> left and right channels, each with 128 steps. It can also toggle the
> analog de-emphasis filter and bass boost filter which are
> incorporated
> in the chip.

Driver looks very clean. But just two cosmetic changes if you like.

+#ifndef OMAP_ALSA_TSC2102_H_
+#define OMAP_ALSA_TSC2102_H_
+
+#include <linux/types.h>
 
Why you are including types.h here?


+		err = clk_set_rate(tsc2102_bclk, CODEC_CLOCK);
+		if (err) {
+			printk(KERN_WARNING "Cannot set BCLK clock rate "
+				"for TSC2102 codec, error code = %d\n", err);
+		}

You can remove curly braces here.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
