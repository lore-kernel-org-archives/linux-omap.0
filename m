From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: [help] busy loop at omap_serial_reset()
Date: Wed, 01 Mar 2006 17:57:50 +0900 (JST)
Message-ID: <20060301.175750.92583404.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I'm facing a problem as below:

I'm trying to boot from uncompressed linux kernel.
Kernel image is allocated by boot loader.
When control is moved to kernel (pc is set to .stext of kernel head.S),
it starts fine, until it enters omap_serial_init() -> omap_serial_reset().
Here, value 0x1 is written to UART_OMAP_SYSC, and busy loops until the written
value is read. The target board hangs here, since the written value could 
not be read (or reads the default 0x0 value).

Is there something that have to be set/done by boot loader before entering
kernel for serial config?

I'm kicking kernel from hand-made boot loader command, and 
MMU is turned off, I/D cache disabled, r0 = 0x0, r1 = machine nr.
(From reading arch/arm/kernel/head.S Kernel startup entry point comment)

When I start kernel from (compressed) uImage, it boots fine.

I'm using (a bit old) 2.6.11 kernel, but the routine looks the same as
of 2.6.15 kernel. I'm using omap osk 5912 as target.

Any hint?


Best Regards,

HK.
--
