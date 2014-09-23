From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 2/2] tty: omap-serial: fix a division by zero
Date: Tue, 23 Sep 2014 21:54:40 +0200
Message-ID: <1411502080-19769-3-git-send-email-frans.klaver@xsens.com>
References: <1411502080-19769-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411502080-19769-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

If the chosen baud rate is large enough (e.g. 3.5 megabaud), the
calculated n values in calculate_baud_abs_diff may become 0. This causes
a division by zero when calculating the difference between calculated
and desired baud rates. To prevent this, cap n on 1.

Division by zero in kernel.
[<c00132e0>] (unwind_backtrace) from [<c00112ec>] (show_stack+0x10/0x14)
[<c00112ec>] (show_stack) from [<c01ed7bc>] (Ldiv0+0x8/0x10)
[<c01ed7bc>] (Ldiv0) from [<c023805c>] (serial_omap_baud_is_mode16+0x4c/0x68)
[<c023805c>] (serial_omap_baud_is_mode16) from [<c02396b4>] (serial_omap_set_termios+0x90/0x8d8)
[<c02396b4>] (serial_omap_set_termios) from [<c0230a0c>] (uart_change_speed+0xa4/0xa8)
[<c0230a0c>] (uart_change_speed) from [<c0231798>] (uart_set_termios+0xa0/0x1fc)
[<c0231798>] (uart_set_termios) from [<c022bb44>] (tty_set_termios+0x248/0x2c0)
[<c022bb44>] (tty_set_termios) from [<c022c17c>] (set_termios+0x248/0x29c)
[<c022c17c>] (set_termios) from [<c022c3e4>] (tty_mode_ioctl+0x1c8/0x4e8)
[<c022c3e4>] (tty_mode_ioctl) from [<c0227e70>] (tty_ioctl+0xa94/0xb18)
[<c0227e70>] (tty_ioctl) from [<c00cf45c>] (do_vfs_ioctl+0x4a0/0x560)
[<c00cf45c>] (do_vfs_ioctl) from [<c00cf568>] (SyS_ioctl+0x4c/0x74)
[<c00cf568>] (SyS_ioctl) from [<c000e480>] (ret_fast_syscall+0x0/0x30)

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/tty/serial/omap-serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ae935ce..7d3f557 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -246,8 +246,12 @@ static inline int calculate_baud_abs_diff(struct uart_port *port,
 				unsigned int baud, unsigned int mode)
 {
 	unsigned int n = port->uartclk / (mode * baud);
-	int abs_diff = baud - (port->uartclk / (mode * n));
+	int abs_diff;
 
+	if (n == 0)
+		n = 1;
+
+	abs_diff = baud - (port->uartclk / (mode * n));
 	if (abs_diff < 0)
 		abs_diff = -abs_diff;
 
-- 
2.1.0
