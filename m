From: "Haylock, Scott" <haylock@ti.com>
Subject: RE: How to change console to UART3?
Date: Mon, 12 Jun 2006 14:43:11 -0500
Message-ID: <EC50B43D0A6B4C45B1D22B54351DC41A04C0A93A@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: xuxian <lsfdxuxian@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


You may need to modify the inittab file.  In the root file system the
etc/inittab needs to be modified so that the prompts go to the correct
serial port.  Go to the inittab file and look for a line such as
below...

tts/0::askfirst:-/bin/sh

The tts/0 device node is the "devfs" version of ttyS0.  So, this would
need to be "tts/1::askfirst:-/bin/sh" if ttyS1 was used.

Scott

-----Original Message-----
From: linux-omap-open-source-bounces+haylock=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+haylock=3Dti.com@linux.omap.com] =
On
Behalf Of xuxian
Sent: Saturday, June 10, 2006 10:42 AM
To: linux-omap-open-source@linux.omap.com
Subject: How to change console to UART3?

Hi all,

I am facing a problem to make UART3 as the console. I have a board like
OSK,
but the serial port is connected to the UART3. U-BOOT had been changed
to
UART3 and it work fine. And also, I made some change in kernel, changing
the
following code:
static struct omap_uart_config osk_uart_config __initdata =3D {
	.enabled_uarts =3D (1 << 0),
};
to
static struct omap_uart_config osk_uart_config __initdata =3D {
	.enabled_uarts =3D (1 << 2),
};
in board-osk.c in /arch/arm/mach-omap1.
When I booting the kernel, it can mount the root filesystem. But it
doesn't
have any response to the keyboard. When gives the following information
on
the console, it has no action though I pressing enter.

VFS: Mounted root (nfs filesystem).
Freeing init memory: 116K

******************************************
Starting System Init for OMAP5912OSK
******************************************=20
Press enter to active this console.

It seems that the date output is correct, but there is no date input. Do
I
miss something to change in the kernel? Here is the information output
when
starting the kernel:
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
ttyS0 at MMIO 0xfffb9800 (irq =3D 15) is a ST16654
and I have ttyS0 c 4 64 in /dev in filesystem.
Any help will be appreciated. Thank in advance.

Best Regards,
xuxian

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
