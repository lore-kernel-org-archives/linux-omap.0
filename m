From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: n770 alsa build broken
Date: Thu, 06 Apr 2006 02:18:04 +0300
Message-ID: <4434502C.3050206@cc.jyu.fi>
References: <20060404161825.67622.qmail@web32901.mail.mud.yahoo.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060404161825.67622.qmail@web32901.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Komal Shah wrote:

>Please supply the patch.
>
>#make n770_defconfig
>#make
>
>sound/arm/omap/omap-alsa-dma.c: In function `omap_sound_dma_link_lch':
>sound/arm/omap/omap-alsa-dma.c:143: error: `FN_IN' undeclared (first
>use in this function)
>  
>
In which kernel version you got this? I tried to use your method instead
of opening xconfig but I could not reproduce this neither with
2.6.16-omap2 or
with the linux-omap-git head. With the code in head I the build stopped
however already earlier to some MMC build problems. The 2.6.16-omap2
compiled just fine.

One thing I noticed however. As 770 uses also alsa driver, it needs alsa
platform driver initialization stuff. For that I will send a patch in a
separate mail.

Mika
