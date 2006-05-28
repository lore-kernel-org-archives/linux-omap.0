From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Section mismatch
Date: Sun, 28 May 2006 15:51:41 +0200
Message-ID: <4479AAED.3090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

with recent git I get following warnings:

> make modules
...
   Building modules, stage 2.
   MODPOST
WARNING: drivers/pcmcia/omap_cf.o - Section mismatch:
reference to .init.text: from .data between '$d' (at offset
0x80) and 'omap_cf_ops'
WARNING: sound/arm/omap/snd-omap-alsa-aic23.o - Section
mismatch: reference to .init.text: from .data between '$d'
(at offset 0x68) and 'aic23_hw_constraints_rates'
   LD [M]  drivers/pcmcia/omap_cf.ko
   LD [M]  sound/arm/omap/snd-omap-alsa-aic23.ko
>

Seems that with our update to 2.6.17-rc5

http://www.ussg.iu.edu/hypermail/linux/kernel/0603.0/1343.html

was enabled.

Will send patch for this in seperate mail. Please check, I'm
not sure what's wrong here and if the patch is really correct.

Best regards

Dirk
