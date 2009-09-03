From: "HU TAO-TGHK48" <taohu@motorola.com>
Subject: RE: [RFC][PATCH]: Adding support for omap-serail driver
Date: Thu, 3 Sep 2009 13:46:43 +0800
Message-ID: <F12CE1A68F023D498A2691C7B53931150397CE86@ZMY16EXM66.ds.mot.com>
References: <ce9ab5790908280649n77765dedm9161316a181b6a07@mail.gmail.com> <F12CE1A68F023D498A2691C7B539311503935B24@ZMY16EXM66.ds.mot.com> <d6a0f7aa0909010013n2c9334cdt56afa642e2a0617@mail.gmail.com> <FCCFB4CDC6E5564B9182F639FC35608702F9AF18DC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9AF18DC@dbde02.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, Govindraj <govindraj.ti@gmail.com>
Cc: vimal singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, "Ye Yuan.Bo-A22116" <yuan-bo.ye@motorola.com>, Chen Xiaolong-A21785 <A21785@motorola.com>
List-Id: linux-omap@vger.kernel.org


I don't  see much added value to use omap_uart_idle_timer() in serial.c=
 since it will be called anyway after timeout.

Is it more simple to do it in omap_uart_prepare_idle()?
Hence omap_uart_prepare_idle() can be move into driver/serial/omap_seri=
al.c eventually.

> =20
> +extern int are_driveromap_uarts_active(int *);
> +
>  static void omap_uart_idle_timer(unsigned long data)
>  {
>  	struct omap_uart_state *uart =3D (struct omap_uart_state *)data;
> +	int dummy;
> +
> +	if (are_driveromap_uarts_active(&dummy)){
> +		/* Keep UART on NoIdle when DMA channel is=20
> enabled in omap
> +		 * serial: do not allow UART to goto Smart-idle=20
> till its done
> +		 * dma'ing
> +		 */
> +		omap_uart_block_sleep(uart);
> +		return;
> +	}
> =20
>  	omap_uart_allow_sleep(uart);
>  }
>=20

=20

> -----Original Message-----
> From: Pandita, Vikram [mailto:vikram.pandita@ti.com]=20
> Sent: Tuesday, September 01, 2009 10:58 PM
> To: Govindraj; HU TAO-TGHK48
> Cc: vimal singh; linux-omap@vger.kernel.org; LKML;=20
> linux-serial@vger.kernel.org; Ye Yuan.Bo-A22116; Chen Xiaolong-A21785
> Subject: RE: [RFC][PATCH]: Adding support for omap-serail driver
>=20
> govindraj
>=20
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org=20
> >[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Govindraj
> >Sent: Tuesday, September 01, 2009 2:14 AM
> >To: HU TAO-TGHK48
> >Cc: vimal singh; linux-omap@vger.kernel.org; LKML;=20
> >linux-serial@vger.kernel.org; Ye Yuan.Bo-A22116; Chen Xiaolong-A2178=
5
> >Subject: Re: [RFC][PATCH]: Adding support for omap-serail driver
> >
> >On Mon, Aug 31, 2009 at 5:20 PM, HU=20
> TAO-TGHK48<taohu@motorola.com> wrote:
> >>
> >> 1. Shall we cleanup PM related stuff in=20
> arch/arm/mach-omap2/serial.c=20
> >> as well?
> >> =A0 =A0Originally serail.c register UART IRQ =A0to decide if=20
> UART idle for=20
> >> a while and is able to enter low power mode (e.g. retention).
> >> =A0 =A0To work with original 8250 driver, it is probably the only =
way=20
> >> since 8250 is not aware of OMAP PM.
> >>
> >> =A0 =A0However =A0it would be more reasonable to merge PM stuff to=
=20
> >> omap-serial.c. since the new driver is already OMAP specific
> >>
> >> 2. There is an issue for DMA =A0with current implementation=20
> in serial.c
> >> =A0 =A0When Rx DMA is active NO Rx IRQ will be generated.
> >> =A0 =A0So serial.c will easily set uart->can_sleep with "1"=20
> even there is=20
> >> Rx DMA ongoing
> >> =A0 =A0+ =A0 if ((iir & 0x4) && up->use_dma) {
> >> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 up->ier &=3D ~UART_IER_RDI;
> >> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier
> >>
> >> =A0 In my view, the best way is to do the idle detection in=20
> >> omap_serial.c.
> >
> >Yes I understand that we cannot adapt 8250 PM model for omap-serial=20
> >driver in DMA mode I am currently working on that adaption with dma=20
> >mode and will be posting a separate patch for changes on serial.c.
> >
> >Wouldn't it be cleaner to inherit and adapt the Serial-PM framework=20
> >from serial.c rather than redefining the PM changes in the driver.
> >
> >As Serial-PM framework already has support for interrupt mode and we=
=20
> >have to adapt the same for DMA  mode.
> >
> >Also defining PM changes in omap-serial would need changes=20
> in PM framework.
> >As PM framework calls functions from serail.c file if we are=20
> defining=20
> >PM framework in our driver then we may need to redefine the=20
> functions=20
> >as in serial.c or modify the PM-framework for uart-activity check.
> >I feel adapting the existing serial-PM framework for DMA=20
> mode would be=20
> >better rather than doing these changes.
>=20
> You can take reference of how to integrate omap-serial driver=20
> PM with mach-omap2/serial.c as follows, for reference ---=20
>=20
>=20
> ---
> From 69112426bd6009cb11e104b9aafcc65429d662f0 Mon Sep 17 00:00:00 200=
1
> From: Vikram Pandita <vikram.pandita@ti.com>
> Date: Fri, 21 Aug 2009 11:15:58 -0500
> Subject: [RFC PATCH] OMAP: Serial: Keep uart in no idle mode=20
> when DMA ongoing
>=20
> Keep UART in NoIdle mode when DMA is going on.
>=20
> Only once UART transfers are complete, switch to smart idle and
> allow OsIdle to kick in
>=20
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   12 ++++++++++++
>  drivers/serial/omap-serial.c |    2 +-
>  2 files changed, 13 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/serial.c=20
> b/arch/arm/mach-omap2/serial.c
> index ff9beb7..a6ee6ab 100755
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -359,9 +359,21 @@ static void omap_uart_allow_sleep(struct=20
> omap_uart_state *uart)
>  	del_timer(&uart->timer);
>  }
> =20
> +extern int are_driveromap_uarts_active(int *);
> +
>  static void omap_uart_idle_timer(unsigned long data)
>  {
>  	struct omap_uart_state *uart =3D (struct omap_uart_state *)data;
> +	int dummy;
> +
> +	if (are_driveromap_uarts_active(&dummy)){
> +		/* Keep UART on NoIdle when DMA channel is=20
> enabled in omap
> +		 * serial: do not allow UART to goto Smart-idle=20
> till its done
> +		 * dma'ing
> +		 */
> +		omap_uart_block_sleep(uart);
> +		return;
> +	}
> =20
>  	omap_uart_allow_sleep(uart);
>  }
> diff --git a/drivers/serial/omap-serial.c=20
> b/drivers/serial/omap-serial.c
> index 938f29f..f105e24 100644
> --- a/drivers/serial/omap-serial.c
> +++ b/drivers/serial/omap-serial.c
> @@ -1641,6 +1641,7 @@ int omap24xx_uart_cts_wakeup(int=20
> uart_no, int state)
>  	return 0;
>  }
>  EXPORT_SYMBOL(omap24xx_uart_cts_wakeup);
> +#endif
>  /**
>   * are_driver8250_uarts_active() - Check if any ports managed by thi=
s
>   * driver are currently busy.  This should be called with interrupts
> @@ -1709,7 +1710,6 @@ int are_driveromap_uarts_active(int=20
> *driver8250_managed)
>  }
>  EXPORT_SYMBOL(are_driveromap_uarts_active);
> =20
> -#endif
> =20
>  static void serial_omap_display_reg(struct uart_port *port)
>  {
> --=20
> 1.6.3.3.334.g916e1
>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
