From: Tony Lindgren <tony@atomide.com>
Subject: About to tag 2.6.16-omap1 & current patch status
Date: Tue, 28 Mar 2006 07:35:02 -0800
Message-ID: <20060328153500.GF28751@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi all,

We're about to ready to tag 2.6.16-omap1. Let's do some testing
and try to get few issues fixed. Currently there's at least the MMC
issue with I2C powered sockets that we should fix before tagging
2.6.16-omap1.

Please report any issues that should be fixed for 2.6.16-omap1 to this
thread.

Also following is a summary of the currently applied and pending patches. 

Applied patches

Komal Shah [PATCH] OMAP: KEYPAD: sem2mutex conversion
Komal Shah [PATCH] OMAP: Menelaus: sem2mutex conversion
Komal Shah [PATCH] OMAP: FB: sem2mutex conversion
Komal Shah [PATCH] OMAP: retu-rtc: sem2mutex conversion
Komal Shah [PATCH] retu-user: sem2mutex conversion
Komal Shah [PATCH] OMAP: tahvo usb: sem2mutex conversion
Komal Shah [PATCH] OMAP: tahvo_user: sem2mutex conversion
Komal Shah [PATCH] OMAP: OSS: sem2mutex conversion
Komal Shah [PATCH] OMAP2: Fix H4 keypad
Komal Shah [PATCH] OMAP1: camera core : Use platform driver structure
Komal Shah [PATCH] Fix OV9640 sensor and add h4 sensor power functions 
Jonathan McDowell [PATCH] Add support for Amstrad Delta (E3) Videophone


Pending patches for post 2.6.16-omap1

Komal Shah [PATCH] OMAP2 MCSPI Use resources
Hiroshi DOYU [patch 1/5] MMC BUGFIX TRIVIAL STUFFS
Richard Woodruff [PATCH] : Fix annoying 'too much work for irq72' serial
Richard Woodruff [PATCH] OMAP2: timer+irq fix up
David Cohen [PATCH] omap24xxcamera
Carlos Aguiar [PATCH] fix MMC response types
Komal Shah [PATCH] OMAP2: ov9640 updates for H4
Komal Shah [PATCH] omap24xx camera cleanup
Komal Shah [PATCH] CBUS: various cleanups
Komal Shah [PATCH] OMAP: MMC: Move set_power to platform data
Komal Shah [PATCH] OMAP: FB: Use blocking notifier apis

Regards,

Tony
