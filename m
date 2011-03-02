From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be configured
 from board file
Date: Wed, 2 Mar 2011 13:10:58 +0530
Message-ID: <AANLkTimD9rOC=4P6Vy2jzvcXZ-gZmF42Te4CBjS8AJLT@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
 <1298903958-6496-7-git-send-email-govindraj.raja@ti.com> <056ac5e848953fa5c37f7ed7a8cc1050@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <056ac5e848953fa5c37f7ed7a8cc1050@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Deepak Kattungal <deepak.k@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 2, 2011 at 12:46 AM, Sricharan R <r.sricharan@ti.com> wrote=
:
> Hi,
>>diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seria=
l.c
>>index 755f4aa..530e9e3 100644
>>--- a/arch/arm/mach-omap2/serial.c
>>+++ b/arch/arm/mach-omap2/serial.c
>>@@ -44,6 +44,15 @@
>>
>> static int omap_uart_con_id __initdata =3D -1;
>>
>>+static struct omap_uart_port_info omap_serial_default_info[] =3D {
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.dma_enabled =A0 =A0=3D 0,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.dma_rx_buf_size =3D DEFAULT_RXDMA_BUFSI=
ZE,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.dma_rx_timeout =3D DEFAULT_RXDMA_TIMEOU=
T,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.idle_timeout =A0 =3D DEFAULT_IDLE_TIMEO=
UT,
>>+ =A0 =A0 =A0},
>>+};
>>+
>> static int uart_idle_hwmod(struct omap_device *od)
>> {
>> =A0 =A0 =A0 omap_hwmod_idle(od->hwmods[0]);
>>@@ -66,6 +75,54 @@ static struct omap_device_pm_latency
> omap_uart_latency[]
>>=3D {
>> =A0 =A0 =A0 },
>> };
>>
>>+#ifdef CONFIG_OMAP_MUX
>>+static struct omap_device_pad default_serial0_pads[] __initdata =3D =
{
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "uart1_rx.uart1_rx",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX | OM=
AP_DEVICE_PAD_WAKEUP,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE0,
>>+ =A0 =A0 =A0},
>>+};
>>+
>>+static struct omap_device_pad default_serial1_pads[] __initdata =3D =
{
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "uart2_rx.uart2_rx",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX | OM=
AP_DEVICE_PAD_WAKEUP,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE0,
>>+ =A0 =A0 =A0},
>>+};
>>+
>>+static struct omap_device_pad default_serial2_pads[] __initdata =3D =
{
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "uart3_rx_irrx.uart3_rx_ir=
rx",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX | OM=
AP_DEVICE_PAD_WAKEUP,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE0,
>>+ =A0 =A0 =A0},
>>+};
>>+
>>+static struct omap_device_pad default_omap36xx_serial3_pads[] __init=
data
> =3D
>>{
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "gpmc_wait3.uart4_rx",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX | OM=
AP_DEVICE_PAD_WAKEUP,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE2,
>>+ =A0 =A0 =A0},
>>+};
>>+
>>+static struct omap_device_pad default_omap4_serial3_pads[] __initdat=
a =3D
> {
>>+ =A0 =A0 =A0{
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "uart4_rx.uart4_rx",
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX | OM=
AP_DEVICE_PAD_WAKEUP,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE0,
>>+ =A0 =A0 =A0},
>>+};
> Here only the UART RX pins are muxed, so what about the cts, rts, tx =
pins?

The intention here is to enable wakeup capabilities for uart rx pad.

AFAIK most of the boards are currently dependent on bootloader for
uart-muxing if any board is not dependent on bootloader then we
can use omap_serial_init_port along with board_mux_info from board.

Prior to this change uart wakeup is based on rx_pad and we were populat=
ing
offset and using omap_ctrl api's to read/write which is cleaned up now.
Most of boards are dependent on uart-rx wakeup to avoid breaking any
board support we
are using omap_serial_init by filling default values, which provides
us with same
environment but with right approach towards handling mux data with a
handshake with
hwmod framework.

So if any board needs specific mux they can go ahead and add required
mux data in
board file and use map_serial_init_port instead of current omap_serial_=
init.


> Is it consistent that across all socs that only UART3 would have UART=
/IRDA
> functions capability so that serial2 pads can always be called "rx_ir=
xx"
> ?.

Yes from OMAP2420 to OMAP4430 uart3 can used as irda.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
