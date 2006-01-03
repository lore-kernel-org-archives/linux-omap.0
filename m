From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending patches mostly pushed, please check
Date: Tue, 3 Jan 2006 11:13:56 -0800
Message-ID: <20060103191356.GR6034@atomide.com>
References: <43B10E92.4060203@de.bosch.com> <20051230222808.GJ4415@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051230222808.GJ4415@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

I've pushed bunch of patches listed. Please check the status of
your patches below.

Also reply to this thread if you know if a patch that you think
should be pushed and has not been pushed yet. 

* Dirk Behme <dirk.behme@de.bosch.com> [051227 01:56]:
> Hello,
> 
> find below a list of pending patches from last weeks.
> 
> Feel free to update, correct, extend etc.
> 
> Hth,
> 
> Dirk
> 
> 
> List of pending patches for OMAP Linux.
> 
> Last modified: 2005/12/27

Last modified: 2006/01/03
 
> Pending patches (ready for inclusion):
> ======================================
> 
> 1) Fix OMAP audio miscompile
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005830.html

Applied.


> 2) Fix miscompile if CONFIG_FB_OMAP_LCDC_INTERNAL=n
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005831.html

Applied.


> 3) Fix omap keypad
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005833.html

Applied.


> 4) Convert touchscreen to input_allocate_device
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005837.html
> (input_allocate_device & timer fix)
> 
> _or_ (timer fix only!)

Dirk, I've only pushed Todd's timer fix below like you suggested. Can you please
update your patch?


> OMAP touchscreen timer BUG
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005899.html

Applied.

 
> 5) Fix warning in pm.c
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005838.html

Applied.


> 6) USB clock changes from Juha
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004818.html
> (http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005846.html)
> (http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/006027.html)

Applied.


> 7) OSS Audio L/R Channel Interchanges fix
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005890.html

Applied. 

> 8) omap1510 MPU interupt BUG
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005894.html

Can't read this patch because of the bad formatting... Can you please repost?


> 9) LDM wakeup flags for OMAP keypad
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005897.html

Let's think about this one a bit more. Maybe we should have u32 device_wakeup in
pm.c, and then various drivers would mask it with OMAP_WAKEUP_KEYPAD etc?

Or maybe device_init_wakeup() should register a callback function in the driver,
and them pm.c just calls all registered wakeup callback functions? That would
move the enable/disable code to drivers.


> 10) Add MMC password protection (lock/unlock) support
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005911.html
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005912.html
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005913.html
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005914.html
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005915.html
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005916.html
> 
> Note: Still in discussion with RMK?

Not applied based on comments from Andersons.


> 11) MMC - CONFIG_HOTPLUG support
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005963.html
> 
> Note: Still in discussion with RMK?

Not applied based on comments from Andersons.

 
> 12) ALSA Audio L/R Channel Interchanges fix
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005971.html

Applied.

 
> 13) Disable DEBUG_LL in omap_h3_1710_defconfig
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005997.html

Applied.


> 14) I2C: Use struct platform_driver
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/006025.html

Applied.


15) Problem on mounting a jffs2 rootfs image
http://linux.omap.com/pipermail/linux-omap-open-source/2006-January/006064.html

Applied.


16) [PATCH] gpio expander debug cleanup 
http://linux.omap.com/pipermail/linux-omap-open-source/2006-January/006061.html

Applied.


> Experimental & test (do not apply yet):
> =======================================
> 
> 1) omap24xx vout and dispc library
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005932.html
> 
> 2) omap24xx spi + touchscreen
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005980.html
> 
> 3) keypad: platform_data and 24xx support -exp
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005889.html
> 
> 4) omap24xx IrDA update
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005992.html
> 
> 
> Already applied (by Juha, nothing to do):
> =========================================
> 
> 1) Omapfb: panel enable/disable reordering
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005844.html
> 
> 2) H3 LCD clocking changes suggested by the driver
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005898.html
> 
> 3) fix watchdog
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005969.html
