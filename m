From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 02/13] tty: serial: 8250: make serial8250_console_setup()
 non _init
Date: Tue, 30 Sep 2014 16:27:46 -0400
Message-ID: <542B1242.1010609@hurleysoftware.com>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de> <1412014009-13315-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1412014009-13315-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

On 09/29/2014 02:06 PM, Sebastian Andrzej Siewior wrote:
> if I boot with console=3DttyS0 and the omap driver is module I end up=
 with
>=20
> | console [ttyS0] disabled

Note to self: make ISA config optional.

> | omap8250 44e09000.serial: ttyS0 at MMIO 0x44e09000 (irq =3D 88, bas=
e_baud =3D 3000000) is a 8250
> | Unable to handle kernel paging request at virtual address c07a9de0
> | Modules linked in: 8250_omap(+)
> | CPU: 0 PID: 908 Comm: modprobe Not tainted 3.17.0-rc5+ #1593
> | PC is at serial8250_console_setup+0x0/0xc8
> | LR is at register_console+0x13c/0x3a4
> | [<c0078788>] (register_console) from [<c02d0340>] (uart_add_one_por=
t+0x3cc/0x420)
> | [<c02d0340>] (uart_add_one_port) from [<c02d38a4>] (serial8250_regi=
ster_8250_port+0x298/0x39c)
> | [<c02d38a4>] (serial8250_register_8250_port) from [<bf006274>] (oma=
p8250_probe+0x218/0x3dc [8250_omap])
> | [<bf006274>] (omap8250_probe [8250_omap]) from [<c02e3424>] (platfo=
rm_drv_probe+0x2c/0x5c)
> | [<c02e3424>] (platform_drv_probe) from [<c02e1eac>] (driver_probe_d=
evice+0x104/0x228)
> =E2=80=A6
> | [<c009fa48>] (SyS_init_module) from [<c000e6e0>] (ret_fast_syscall+=
0x0/0x30)
> | Code: 7823603b f8314620 051b3013 491ed416 (44792204)
>=20
> because serial8250_console_setup() is already gone.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
