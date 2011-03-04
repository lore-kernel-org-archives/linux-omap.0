From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be configured
 from board file
Date: Fri, 4 Mar 2011 11:55:45 +0530
Message-ID: <AANLkTimMqQWSi07wf3GNUF7nD4TNnvcULQFYnLqLyVPB@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
 <1298903958-6496-7-git-send-email-govindraj.raja@ti.com> <056ac5e848953fa5c37f7ed7a8cc1050@mail.gmail.com>
 <AANLkTimD9rOC=4P6Vy2jzvcXZ-gZmF42Te4CBjS8AJLT@mail.gmail.com>
 <8ab9882cd92792e9bf2b836c0ec9c7fe@mail.gmail.com> <AANLkTi=MJigLvbJrRJ4CpyDcGd8sZXB7-1nFYup6EeDm@mail.gmail.com>
 <0dac991a1fbbf1d4bccd8fd259a28f35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54765 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab1CDG0G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 01:26:06 -0500
In-Reply-To: <0dac991a1fbbf1d4bccd8fd259a28f35@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Govindraj Raja <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Deepak Kattungal <deepak.k@ti.com>

On Thu, Mar 3, 2011 at 10:38 AM, Sricharan R <r.sricharan@ti.com> wrote=
:
> Hi,
>>-----Original Message-----
>>From: Govindraj [mailto:govindraj.ti@gmail.com]
>>Sent: Wednesday, March 02, 2011 3:37 PM
>>To: Sricharan R
>>Cc: Govindraj.R; linux-omap@vger.kernel.org;
> linux-serial@vger.kernel.org;
>>linux-arm-kernel@lists.infradead.org; Jon Hunter; Tony Lindgren; Beno=
it
>>Cousson; Kevin Hilman; Paul Walmsley; Rajendra Nayak; Deepak Kattunga=
l
>>Subject: Re: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be
>>configured from board file
>>
>>On Wed, Mar 2, 2011 at 1:49 PM, Sricharan R <r.sricharan@ti.com> wrot=
e:
>>> Hi,
>>>>-----Original Message-----
>>>>From: Govindraj [mailto:govindraj.ti@gmail.com]
>>>>Sent: Wednesday, March 02, 2011 1:11 PM
>>>>To: Sricharan R
>>>>Cc: Govindraj.R; linux-omap@vger.kernel.org;
>>> linux-serial@vger.kernel.org;
>>>>linux-arm-kernel@lists.infradead.org; Jon Hunter; Tony Lindgren; Be=
noit
>>>>Cousson; Kevin Hilman; Paul Walmsley; Rajendra Nayak; Deepak Kattun=
gal
>>>>Subject: Re: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be
>>>>configured from board file
>>>>
>>>>On Wed, Mar 2, 2011 at 12:46 AM, Sricharan R <r.sricharan@ti.com>
> wrote:
>>>>> Hi,
>>>>>>diff --git a/arch/arm/mach-omap2/serial.c
>>> b/arch/arm/mach-omap2/serial.c
>>>>>>index 755f4aa..530e9e3 100644
>>>>>>--- a/arch/arm/mach-omap2/serial.c
>>>>>>+++ b/arch/arm/mach-omap2/serial.c
>>>>>>@@ -44,6 +44,15 @@
>>>>>>
>>>>>> static int omap_uart_con_id __initdata =3D -1;
>>>>>>
>>>>>>+static struct omap_uart_port_info omap_serial_default_info[] =3D=
 {
>>>>>>+ =A0 =A0 =A0{
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.dma_enabled =A0 =A0=3D 0,
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.dma_rx_buf_size =3D DEFAULT_RXDMA_B=
UFSIZE,
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.dma_rx_timeout =3D DEFAULT_RXDMA_TI=
MEOUT,
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.idle_timeout =A0 =3D DEFAULT_IDLE_T=
IMEOUT,
>>>>>>+ =A0 =A0 =A0},
>>>>>>+};
>>>>>>+
>>>>>> static int uart_idle_hwmod(struct omap_device *od)
>>>>>> {
>>>>>> =A0 =A0 =A0 omap_hwmod_idle(od->hwmods[0]);
>>>>>>@@ -66,6 +75,54 @@ static struct omap_device_pm_latency
>>>>> omap_uart_latency[]
>>>>>>=3D {
>>>>>> =A0 =A0 =A0 },
>>>>>> };
>>>>>>
>>>>>>+#ifdef CONFIG_OMAP_MUX
>>>>>>+static struct omap_device_pad default_serial0_pads[] __initdata =
=3D {
>>>>>>+ =A0 =A0 =A0{
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "uart1_rx.uart1_rx",
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX =
|
>>> OMAP_DEVICE_PAD_WAKEUP,
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE0,
>>>>>>+ =A0 =A0 =A0},
>>>>>>+};
>>>>>>+
>>>>>>+static struct omap_device_pad default_serial1_pads[] __initdata =
=3D {
>>>>>>+ =A0 =A0 =A0{
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "uart2_rx.uart2_rx",
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX =
|
>>> OMAP_DEVICE_PAD_WAKEUP,
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE0,
>>>>>>+ =A0 =A0 =A0},
>>>>>>+};
>>>>>>+
>>>>>>+static struct omap_device_pad default_serial2_pads[] __initdata =
=3D {
>>>>>>+ =A0 =A0 =A0{
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "uart3_rx_irrx.uart3_r=
x_irrx",
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX =
|
>>> OMAP_DEVICE_PAD_WAKEUP,
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE0,
>>>>>>+ =A0 =A0 =A0},
>>>>>>+};
>>>>>>+
>>>>>>+static struct omap_device_pad default_omap36xx_serial3_pads[]
>>> __initdata
>>>>> =3D
>>>>>>{
>>>>>>+ =A0 =A0 =A0{
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "gpmc_wait3.uart4_rx",
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX =
|
>>> OMAP_DEVICE_PAD_WAKEUP,
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE2,
>>>>>>+ =A0 =A0 =A0},
>>>>>>+};
>>>>>>+
>>>>>>+static struct omap_device_pad default_omap4_serial3_pads[]
> __initdata
>>> =3D
>>>>> {
>>>>>>+ =A0 =A0 =A0{
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "uart4_rx.uart4_rx",
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX =
|
>>> OMAP_DEVICE_PAD_WAKEUP,
>>>>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE0,
>>>>>>+ =A0 =A0 =A0},
>>>>>>+};
>>>>> Here only the UART RX pins are muxed, so what about the cts, rts,=
 tx
>>>>pins?
>>>>
>>>>The intention here is to enable wakeup capabilities for uart rx pad=
=2E
>>>>
>>>>AFAIK most of the boards are currently dependent on bootloader for
>>>>uart-muxing if any board is not dependent on bootloader then we
>>>>can use omap_serial_init_port along with board_mux_info from board.
>>>>
>>> Yes. The idea is to be independent of the bootloaders for mux setti=
ngs.
>>>
>>>>Prior to this change uart wakeup is based on rx_pad and we were
>>> populating
>>>>offset and using omap_ctrl api's to read/write which is cleaned up =
now.
>>>>Most of boards are dependent on uart-rx wakeup to avoid breaking an=
y
>>>>board support we
>>>>are using omap_serial_init by filling default values, which provide=
s
>>>>us with same
>>>>environment but with right approach towards handling mux data with =
a
>>>>handshake with
>>>>hwmod framework.
>>>>
>>> Now, in this change only the RX pin is configured. So if some board
> uses
>>> omap_serial_init then only the RX is going to be configured.
>>> How will they configure the rest of the pins?
>>
>>
>>They should call omap_serial_init_port to configure each individual u=
art
>>with
>>mux_info filled and not use omap_serial_init.
>>
>>If any board is not dependent for mux from u-boot then they use above
> said
>>init_port func.
>>
>>
>>> They cannot call omap_serial_init_port after this just to configure=
 the
>>> rest of the mux pins( cts, rts, tx).
>>
>>No. You need to use either omap_serial_init_port or omap_serial_init
>>you cannot call both apis from board file please refer to both func
>>documentation.
>>
>>Also please note i am not configuring all uart pins for pullups and p=
ull
>>downs
>>with this patch series and its not related to this patch series.
>>I am only enabling wakeup-enable pin for rx as it was done before.
>>
>>> So data which is passed from omap_serial_init should have the
>>> configuration
>>> for all the pins, and this default data should be consistent across
>>> atleast
>>> some boards, so that they can use this. This will reduce the data
>>> duplication across board files.
>>>
>>> If this is not true, then all the pads can be configured from the b=
oard
>>> files itself using omap_serial_init_port and you can set the requir=
ed
>>> RX wakeup capability there as well.
>>>
>>
>>Yes that be done but currently but that is not in my intention here
>>with my patch
>>I just want to retain rx wakeup by default to avoid breaking support
>>for any board.
>>
>>Adding pin mux for each individual pin is a separate activity where I
> also
>>need access to various boards So I am leaving that to developers who
>>want to configure
>>for the corresponding boards using init_port api.
>>
>>Removing mux from u-boot level and adding it to board file is beyond
>>the scope of this
>>patch series and is a separate topic of discussion, as current patch
> series
>>assumes that uarts are muxed from u-boot level and needs to only enab=
le
>>wakeup
>>capability for rx-pin.
>>
>>Hope this clarifies.
>>
> It is true that this patch is not intending to configure the pads.
>
> But my question is, after this patch say
> =A0 1) some board file calls omap_serial_port.
> =A0 2) As a result , all the uarts devices are build and only the Rx =
pad is
> configured for each device.
> =A0 3) After this there will be no way of configuring the rest of the=
 pads
> ??
> =A0 =A0 =A0That should not happen. Also relying that the bootloaders =
are going
> =A0 =A0 =A0to do the configuration is not correct.
>
> =A0 =A0 =A0So if some board calls omap_serial_port then there should =
be default
> values for all pads which a board can use, otherwise the board calls
> omap_serial_init_port for each of the device.

ok I will add default values for all pads and enable rx wakeup for rx p=
ad.

Will incorporate in next version.

--
Thanks,
Govindraj.R



>
>
>>--
>>Thanks,
>>Govindraj.R
>>
>>
>>>>So if any board needs specific mux they can go ahead and add requir=
ed
>>>>mux data in
>>>>board file and use map_serial_init_port instead of current
>>>>omap_serial_init.
>>>>
>>>>
>>>>> Is it consistent that across all socs that only UART3 would have
>>>>UART/IRDA
>>>>> functions capability so that serial2 pads can always be called
>>> "rx_irxx"
>>>>> ?.
>>>>
>>>>Yes from OMAP2420 to OMAP4430 uart3 can used as irda.
>>>>
>>> Ok.
>>>>--
>>>>Thanks,
>>>>Govindraj.R
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
