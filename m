From: "xuxian" <lsfdxuxian@gmail.com>
Subject: How to change console to UART3?
Date: Sat, 10 Jun 2006 23:42:08 +0800
Message-ID: <448ae865.4abdf852.60cc.6267@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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

Hi all,

I am facing a problem to make UART3 as the console. I have a board like OSK,
but the serial port is connected to the UART3. U-BOOT had been changed to
UART3 and it work fine. And also, I made some change in kernel, changing the
following code:
static struct omap_uart_config osk_uart_config __initdata = {
	.enabled_uarts = (1 << 0),
};
to
static struct omap_uart_config osk_uart_config __initdata = {
	.enabled_uarts = (1 << 2),
};
in board-osk.c in /arch/arm/mach-omap1.
When I booting the kernel, it can mount the root filesystem. But it doesn't
have any response to the keyboard. When gives the following information on
the console, it has no action though I pressing enter.

VFS: Mounted root (nfs filesystem).
Freeing init memory: 116K

******************************************
Starting System Init for OMAP5912OSK
****************************************** 
Press enter to active this console.

It seems that the date output is correct, but there is no date input. Do I
miss something to change in the kernel? Here is the information output when
starting the kernel:
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0xfffb9800 (irq = 15) is a ST16654
and I have ttyS0 c 4 64 in /dev in filesystem.
Any help will be appreciated. Thank in advance.

Best Regards,
xuxian
