From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PM][PATCH v2 2/4] OMAP3: Serial: Errata i202: fix for MDR1
	access
Date: Mon, 12 Apr 2010 13:16:45 +0530
Message-ID: <j2gd6a0f7aa1004120046g65150c24z16011e5eaadedb45@mail.gmail.com>
References: <1270845107-6236-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:59898 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0DLHqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 03:46:46 -0400
Received: by qyk9 with SMTP id 9so3548089qyk.1
        for <linux-omap@vger.kernel.org>; Mon, 12 Apr 2010 00:46:46 -0700 (PDT)
In-Reply-To: <1270845107-6236-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Deepak K <deepak.k@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

On Sat, Apr 10, 2010 at 2:01 AM, Nishanth Menon <nm@ti.com> wrote:
> From: Deepak K <deepak.k@ti.com>
>
> Original patch:
> http://git.omapzoom.org/?p=3Dkernel/omap.git;a=3Dcommitdiff;h=3D42d4a=
342c009bd9727c100abc8a4bc3063c22f0c
>
> Errata i202 (OMAP3430 - 1.12, OMAP3630 - 1.6):
> UART module MDR1 register access can cause a dummy underrun
> condition which could result in a freeze in the case of IrDA
> communication or if used as UART, corrupted data.
>
> Workaround is as follows for everytime MDR1 register is changed:
> * setup all required UART registers
> * setup MDR1.MODE_SELECT bit field
> * Wait 5 L4 clk cycles + 5 UART functional clock cycles
> * Clear the Tx and RX fifo using FCR register
>
> Note: The following step is not done as I am assuming it is not
> needed due to reconfiguration being done and there is no halted
> operation perse.
> * Read if required, the RESUME register to resume halted operation
>
> Cc: Govindraj R <govindraj.raja@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tero Kristo <tero.kristo@nokia.com>
>
> Signed-off-by: Deepak K <deepak.k@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Note: original patch was done for android kernel, ported and sanity
> tested
> Changes from V1:
> =A0* Added check for LSR to ensure that FIFO is indeed empty.
> =A0* Paranoid check to ensure that we can atleast timeout while waiti=
ng
> =A0 for FIFO empty.
> =A0* Due to additional code, isolated the errata implementation to a
> =A0 function instead of duplicating it.
>
> Ref:
> v1: http://marc.info/?t=3D127074933100005&r=3D1&w=3D2
>
> =A0arch/arm/mach-omap2/serial.c | =A0 40 ++++++++++++++++++++++++++++=
+++++++++---
> =A01 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seria=
l.c
> index a7c45b5..78091e4 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -185,6 +185,41 @@ static inline void __init omap_uart_reset(struct=
 omap_uart_state *uart)
>
> =A0#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
>
> +/*
> + * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
> + * The access to uart register after MDR1 Access
> + * causes UART to corrupt data.
> + *
> + * Need a delay =3D
> + * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz =3D ~0.=
2uS)
> + * give 10 times as much
> + */
> +static void omap_uart_mdr1_errataset(struct omap_uart_state *uart, u=
8 mdr1_val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 fcr_val)
> +{
> + =A0 =A0 =A0 struct plat_serial8250_port *p =3D uart->p;
> + =A0 =A0 =A0 u8 timeout =3D 255;
> +
> + =A0 =A0 =A0 serial_write_reg(p, UART_OMAP_MDR1, mdr1_val);
> + =A0 =A0 =A0 udelay(2);
> + =A0 =A0 =A0 /* Add TX and RX FIFO Clear */
> + =A0 =A0 =A0 serial_write_reg(p, UART_FCR, fcr_val | 0x06);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Wait for FIFO to empty: when empty, RX_FIFO_E bit =
is 0 and
> + =A0 =A0 =A0 =A0* TX_FIFO_E bit is 1. So, we check for 0x20 being re=
ad.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 while (0x20 !=3D (serial_read_reg(p, UART_LSR) & 0x21))=
 {

macros available for LSR

while (UART_LSR_THRE !=3D (serial_read_reg(p, UART_LSR) &
			(UART_LSR_THRE | UART_LSR_DR)))

Rest looks fine.

Regards,
Govindraj.R

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!timeout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Should *never* happe=
n. we warn and carry on */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_crit(&uart->pdev.de=
v, "Errata i202: timedout %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_=
read_reg(p, UART_LSR));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 }
> +}
> +
> =A0static void omap_uart_save_context(struct omap_uart_state *uart)
> =A0{
> =A0 =A0 =A0 =A0u16 lcr =3D 0;
> @@ -222,7 +257,7 @@ static void omap_uart_restore_context(struct omap=
_uart_state *uart)
>
> =A0 =A0 =A0 =A0uart->context_valid =3D 0;
>
> - =A0 =A0 =A0 serial_write_reg(p, UART_OMAP_MDR1, 0x7);
> + =A0 =A0 =A0 omap_uart_mdr1_errataset(uart, 0x07, 0xA0);
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode =
*/
> =A0 =A0 =A0 =A0efr =3D serial_read_reg(p, UART_EFR);
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_EFR, UART_EFR_ECB);
> @@ -235,14 +270,13 @@ static void omap_uart_restore_context(struct om=
ap_uart_state *uart)
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_IER, uart->ier);
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_LCR, 0x80);
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_MCR, uart->mcr);
> - =A0 =A0 =A0 serial_write_reg(p, UART_FCR, 0xA1);
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode =
*/
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_EFR, efr);
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_OMAP_SCR, uart->scr);
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_OMAP_WER, uart->wer);
> =A0 =A0 =A0 =A0serial_write_reg(p, UART_OMAP_SYSC, uart->sysc);
> - =A0 =A0 =A0 serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x =
mode */
> + =A0 =A0 =A0 omap_uart_mdr1_errataset(uart, 0x00, 0xA1);
> =A0}
> =A0#else
> =A0static inline void omap_uart_save_context(struct omap_uart_state *=
uart) {}
> --
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
