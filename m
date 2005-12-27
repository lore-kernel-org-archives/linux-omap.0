From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Pending patches
Date: Tue, 27 Dec 2005 10:51:14 +0100
Message-ID: <43B10E92.4060203@de.bosch.com>
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

Hello,

find below a list of pending patches from last weeks.

Feel free to update, correct, extend etc.

Hth,

Dirk


List of pending patches for OMAP Linux.

Last modified: 2005/12/27

Pending patches (ready for inclusion):
======================================

1) Fix OMAP audio miscompile
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005830.html

2) Fix miscompile if CONFIG_FB_OMAP_LCDC_INTERNAL=n
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005831.html

3) Fix omap keypad
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005833.html

4) Convert touchscreen to input_allocate_device
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005837.html
(input_allocate_device & timer fix)

_or_ (timer fix only!)

OMAP touchscreen timer BUG
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005899.html

5) Fix warning in pm.c
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005838.html

6) USB clock changes from Juha
http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004818.html
(http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005846.html)
(http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/006027.html)

7) OSS Audio L/R Channel Interchanges fix
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005890.html

8) omap1510 MPU interupt BUG
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005894.html

9) LDM wakeup flags for OMAP keypad
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005897.html

10) Add MMC password protection (lock/unlock) support
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005911.html
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005912.html
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005913.html
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005914.html
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005915.html
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005916.html

Note: Still in discussion with RMK?

11) MMC - CONFIG_HOTPLUG support
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005963.html

Note: Still in discussion with RMK?

12) ALSA Audio L/R Channel Interchanges fix
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005971.html

13) Disable DEBUG_LL in omap_h3_1710_defconfig
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005997.html

14) I2C: Use struct platform_driver
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/006025.html


Experimental & test (do not apply yet):
=======================================

1) omap24xx vout and dispc library
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005932.html

2) omap24xx spi + touchscreen
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005980.html

3) keypad: platform_data and 24xx support -exp
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005889.html

4) omap24xx IrDA update
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005992.html


Already applied (by Juha, nothing to do):
=========================================

1) Omapfb: panel enable/disable reordering
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005844.html

2) H3 LCD clocking changes suggested by the driver
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005898.html

3) fix watchdog
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005969.html
