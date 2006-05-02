From: "Unger Rico" <Rico.Unger@schwarzer.net>
Subject: Ti 16C754 external UART
Date: Tue, 2 May 2006 13:29:26 +0200
Message-ID: <D137F4C077C1C64C8894732917787DACA5C4A7@exchangeserver.schwarzer2002.network>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
content-class: urn:content-classes:message
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
=20
we have a customized OSK-based board with external TI 16C754 quad UART.
I found some discussions ( approximately one year ago ) at linux.arm and =
at linux.omap
mailing lists about adding external UART support. Ladislav Michl has =
done this for
voiceblue boards.
I tried to do this in the same way for my OSK-based board. I modified =
board-osk.c to
register my own serial8250 platform device. But on this way i get =
following error message:
=20
    Serial: 8250/16550 driver $Revision: 1.90 $ 3 ports, IRQ sharing =
disabled
    ttyS0 at MMIO 0xfffb0000 (irq =3D 46) is a ST16654
    ttyS1 at MMIO 0xfffb0800 (irq =3D 47) is a ST16654
    ttyS2 at MMIO 0xfffb9800 (irq =3D 15) is a ST16654
=20
    serial8250 serial8250.1: unable to register port at index 0 (IO0 =
MEMa000000 IRQ166): -28
    serial8250 serial8250.1: unable to register port at index 1 (IO0 =
MEMa800000 IRQ167): -28
    serial8250 serial8250.1: unable to register port at index 2 (IO0 =
MEMb000000 IRQ168): -28
    serial8250 serial8250.1: unable to register port at index 3 (IO0 =
MEMb800000 IRQ171): -28
=20
I'm using Chip select CS2B, which is spitted to provide 4 Chip selects =
for external uart.
I'm able to access the 16C754, read/write all internal registers without =
any problems.
(outside board-osk.c) I defined the Chip selects as follows:
    #define OMAP_CS2B_1_PHYS (OMAP_CS2B_PHYS)
    #define OMAP_CS2B_2_PHYS (OMAP_CS2B_PHYS + SZ_8M)
    #define OMAP_CS2B_3_PHYS (OMAP_CS2B_PHYS + SZ_16M)
    #define OMAP_CS2B_4_PHYS (OMAP_CS2B_PHYS + SZ_24M) =20
=20
My changes at board-osk.c are attached below. What is going wrong at the =
registration-process?
Did i miss some important initialisation routines..?
Any ideas or anybody else has done this for osk-boards?
=20
Thanks,
    Rico

    static struct plat_serial8250_port cic_ports[] =3D {
     [0] =3D {
     .mapbase =3D (unsigned long) OMAP_CS2B_1_PHYS,
     .irq  =3D OMAP_GPIO_IRQ(6),
     .flags  =3D UPF_BOOT_AUTOCONF | UPF_IOREMAP,
     .iotype  =3D UPIO_MEM,
     .regshift =3D 1,
     .uartclk =3D 3686400, =20
     },
     [1] =3D {
      .mapbase =3D (unsigned long) OMAP_CS2B_2_PHYS,
     .irq  =3D OMAP_GPIO_IRQ(7),
     .flags  =3D UPF_BOOT_AUTOCONF | UPF_IOREMAP,
     .iotype  =3D UPIO_MEM,
     .regshift =3D 1,
     .uartclk =3D 3686400,
     },
     [2] =3D {
     .mapbase =3D (unsigned long) OMAP_CS2B_3_PHYS,
     .irq  =3D OMAP_GPIO_IRQ(8),
     .flags  =3D UPF_BOOT_AUTOCONF | UPF_IOREMAP,
     .iotype  =3D UPIO_MEM,
     .regshift =3D 1,
     .uartclk =3D 3686400,
     },
     [3] =3D {
     .mapbase =3D (unsigned long) OMAP_CS2B_4_PHYS,
     .irq  =3D OMAP_GPIO_IRQ(11),
     .flags  =3D UPF_BOOT_AUTOCONF | UPF_IOREMAP,
     .iotype  =3D UPIO_MEM,
     .regshift =3D 1,
     .uartclk =3D 3686400,
     },
     {},
    };
=20
    static struct platform_device serial_device =3D {
     .name   =3D "serial8250",
      .id    =3D PLAT8250_DEV_PLATFORM1,
     .dev   =3D {
     .platform_data =3D cic_ports,
     },
    };
   =20
    static int __init ext_uart_init(void)
    {
     return platform_device_register(&serial_device);
    }
    arch_initcall(ext_uart_init);

<<<<<<<<
