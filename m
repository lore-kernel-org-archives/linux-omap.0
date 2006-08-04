From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: Pending July patches
Date: Fri, 04 Aug 2006 17:40:28 +0300
Message-ID: <44D35C5C.8060602@cc.jyu.fi>
References: <20060803111721.GH8661@atomide.com>	<20060803120858.53676.qmail@web37909.mail.mud.yahoo.com>
	<20060804110530.GC26416@atomide.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060804110530.GC26416@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

It would be nice if somebody could test the functionality of usbnet and
mmc/sd with omap1 devices (omap1510)
before tagging. I got the lcd working by using the fixes now already
applied to OMAP kernel but both the MMC/SD
and usbnet failed to work at least for me & h6300.
(2.6.16 kernel worked ok.)

I can also try to test again these but for me it will go over the weekend...

Mika

Tony Lindgren wrote:
> Hi all,
>
> I've pushed some patches. Does anybody else have patches that should go in
> before I tag 2.6.17-omap2?
>
>  Here's the current status:
>
> 1. [PATCH] fix PWL macro names
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007503.html
>
> Pushed.
>
> 2. [PATCH] ARM: OMAP: Fix missing channel using
> omap_set_dma_priority()
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007508.html
>
> Note: Needs check if channel 0 is really okay for OMAP24xx.
>
> This gets only called for omap1, channel does not matter. Pushed.
>
> 3. ARM: OMAP: omapfb: Fix 444 mode after recent LCD changes
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007525.html
>
> Pushed.
>
> 4. [PATCH] ARM: OMAP: omapfb: Add Amstrad Delta LCD driver
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007526.html
>
> Pushed.
>
> 5. 2420 boot BUG(): failure to map SRAM
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007578.html
>
> Pushed.
>
> 6.[PATCH] ARM: OMAP: mux: add config for 16xx SPI pins
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007596.html
>
> Pushed.
>
> 7. [PATCH] ARM: OMAP: Apollon MMC support using OMAP2 MMC interface
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-June/007373.html
>
> Pushed.
>
> 8. [PATCH] ARM: OMAP: LEDs dirver support
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-June/007478.html
>
> Pushed.
>
> 9. [PATCH] USB device support on OMAP2
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-June/007471.html
>
> Not pushed yet, need to leave out MMC code out of the patch and test
> first.
>
> Regards,
>
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>   
