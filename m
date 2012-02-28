From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: help: BeagleBoard xM RevC ethernet port
Date: Tue, 28 Feb 2012 09:37:07 -0600
Message-ID: <CAOCHtYjVhbmi1=S6TZLQTUAb=cf0e5xSzZWyt3sSd0=ANhh_LA@mail.gmail.com>
References: <4F3E0EB7.9060803@ti.com>
	<874nuizfyf.fsf@ti.com>
	<4F4613B7.8010601@kynesim.co.uk>
	<4F4B9405.9070702@ti.com>
	<CAAL8m4x=6--5irPBPdW4n0dtYuMm_UThqWEuCSyTtsm+cEx4jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42869 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab2B1PhJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 10:37:09 -0500
Received: by wejx9 with SMTP id x9so1055339wej.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 07:37:07 -0800 (PST)
In-Reply-To: <CAAL8m4x=6--5irPBPdW4n0dtYuMm_UThqWEuCSyTtsm+cEx4jQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Watts <rrw@kynesim.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com

On Tue, Feb 28, 2012 at 8:04 AM, Govindraj <govindraj.ti@gmail.com> wro=
te:
> Hi Peter,
>
> On Mon, Feb 27, 2012 at 8:02 PM, Peter Ujfalusi <peter.ujfalusi@ti.co=
m> wrote:
>> Hi,
>>
>> On 02/23/2012 12:23 PM, Richard Watts wrote:
>>> On 22/02/12 22:00, Kevin Hilman wrote:
>>>> The first thing I try when I see these regulator failures is to ad=
d
>>>> CONFIG_REGULATOR_DUMMY=3Dy to the .config to see if that helps. =A0=
If so,
>>>> then the board file needs some help configuring the right regulato=
rs.
>>
>> Thanks for the hint Kevin
>>
>>> =A0Apologies for the malformed patch, but I don't have time to clea=
n it up
>>> this morning (or test it in its cleaned state); however, the follow=
ing
>>> fixes the problem for me.
>>>
>>> =A0It used to be masked because u-boot turns the regulator on to ac=
tivate
>>> ethernet on Beagle xM and no-one ever turns it off again, but some =
versions
>>> of u-boot don't identify xM rev C correctly, so never turn it on ..
>>>
>>> =A0Anyway, it's neater for the kernel to know what it's doing. And =
removes
>>> a whole two lines of kernel startup output :-)
>>
>> I have did similar thing as well, but it did not helped. The two lin=
e
>> complaining about the regulator was gone, but still neither the ethe=
rnet
>> nor the USB ports were working.
>> The LED between the USB ports are lit, shich indicates that the LAN9=
514
>> should have the needed power.
>> With the REGULATOR_DUMMY enabled I have this in the kernel log:
>>
>> beagle-gentoo ~ # dmesg | grep ehci-omap
>> [ =A0 =A01.443420] _regulator_get: ehci-omap.0 supply hsusb0 not fou=
nd,
>> using dummy regulator
>> [ =A0 =A01.452026] _regulator_get: ehci-omap.0 supply hsusb1 not fou=
nd,
>> using dummy regulator
>> [ =A0 =A02.465637] ehci-omap ehci-omap.0: phy reset operation timed =
out
>> [ =A0 =A03.473449] ehci-omap ehci-omap.0: phy reset operation timed =
out
>> [ =A0 =A03.479766] ehci-omap ehci-omap.0: reset hcs_params 0x1313 db=
g=3D0 cc=3D1
>> pcc=3D3 ordered ports=3D3
>> [ =A0 =A03.488586] ehci-omap ehci-omap.0: reset hcc_params 0016 thre=
sh 1
>> uframes 256/512/1024 park
>> [ =A0 =A03.497436] ehci-omap ehci-omap.0: reset command 0080b02 =A0p=
ark=3D3
>> ithresh=3D8 period=3D1024 Reset HALT
>> [ =A0 =A03.506774] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
>> [ =A0 =A03.524871] ehci-omap ehci-omap.0: new USB bus registered, as=
signed
>> bus number 1
>> [ =A0 =A03.532806] ehci-omap ehci-omap.0: park 0
>> [ =A0 =A03.537139] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
>> [ =A0 =A03.543121] ehci-omap ehci-omap.0: init command 0010005 (park=
)=3D0
>> ithresh=3D1 period=3D512 RUN
>> [ =A0 =A03.567260] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
>> [ =A0 =A03.609771] usb usb1: SerialNumber: ehci-omap.0
>> [ =A0 =A03.690460] ehci-omap ehci-omap.0: ...powerup ports...
>>
>> I have a faint recollection that the ethernet port along with the US=
B
>> ports were working in some ancient kernel (2.6.3x) - I think it was =
the
>> distro which come with board...
>>
>> It might be that I have everything built into the kernel?
>> Will debug this further when time allows...
>
> The issue seems to a mux conflict issue, uart2_rx mux is been taken
> by uart init and gpio_147 needed for usb phy init is not in mux mode4
> as set by bootloader.
>
> On beagle I see no other uarts being used other than uart3 as console=
_uart.
> So I think it should be okay to init only uart3 from beagle board dat=
a.
> Here is the patch [1] to do the same. (Tested on Beagle Xm Rev.C)
>
> (Any other approach is welcome)

Thanks,  this patch fixed it on my xM B on v3.3-rc5

Tested-by: Robert Nelson <robertcnelson@gmail.com>

Regards,
>
> [1]:
>
>
> From f1b43f983a2926c637e6bc6ab5d1e5044339ffd3 Mon Sep 17 00:00:00 200=
1
> From: "Govindraj.R" <govindraj.raja@ti.com>
> Date: Tue, 28 Feb 2012 19:16:33 +0530
> Subject: [PATCH] omap3_beagle: Init only uart3 used for console
>
> On beagle some of uart mux lines are used for other
> purpose so init only uart3.
>
> Uart2 rx line clashes with gpio_147 used for usb ehci
> phy reset.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 50 +++++++++++++++++=
+++++++++++++-
> =A01 files changed, 49 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
> b/arch/arm/mach-omap2/board-omap3beagle.c
> index 817be06..a2e0052 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -493,6 +493,54 @@ static const struct usbhs_omap_board_data
> usbhs_bdata __initconst =3D {
> =A0static struct omap_board_mux board_mux[] __initdata =3D {
> =A0 =A0 =A0 =A0{ .reg_offset =3D OMAP_MUX_TERMINATOR },
> =A0};
> +
> +static struct omap_device_pad uart3_pads[] __initdata =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart3_cts_rctx.uart3_cts=
_rctx",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT_PULLUP | OMA=
P_MUX_MODE0,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart3_rts_sd.uart3_rts_s=
d",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_=
MODE0,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart3_tx_irtx.uart3_tx_i=
rtx",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_=
MODE0,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart3_rx_irrx.uart3_rx_i=
rrx",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D OMAP_DEVICE_PAD_REMUX | O=
MAP_DEVICE_PAD_WAKEUP,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT | OMAP_MUX_M=
ODE0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idle =A0 =3D OMAP_PIN_INPUT | OMAP_MUX=
_MODE0,
> + =A0 =A0 =A0 },
> +};
> +
> +static inline void board_serial_init(void)
> +{
> + =A0 =A0 =A0 struct omap_board_data uart3_bdata;
> + =A0 =A0 =A0 uart3_bdata.flags =A0 =A0 =3D 0;
> + =A0 =A0 =A0 uart3_bdata.pads =A0 =A0 =A0=3D uart3_pads;
> + =A0 =A0 =A0 uart3_bdata.pads_cnt =A0=3D ARRAY_SIZE(uart3_pads);
> + =A0 =A0 =A0 uart3_bdata.id =A0 =A0 =A0 =A0=3D 2;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Init only uart3 used as console
> + =A0 =A0 =A0 =A0* don't init other uarts as uart mux lines
> + =A0 =A0 =A0 =A0* might be used for other purpose on beagle board
> + =A0 =A0 =A0 =A0* ex: uart2_rx used by gpio_147 for usb_ehci phy res=
et.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 omap_serial_init_port(&uart3_bdata, NULL);
> +}
> +#else
> +
> +/*
> + * If mux is disabled from kernel probably we
> + * are relying on boot-loaders so we init all uarts
> + */
> +static inline void board_serial_init(void)
> +{
> + =A0 =A0 =A0 omap_serial_init();
> +}
> =A0#endif
>
> =A0static void __init beagle_opp_init(void)
> @@ -549,7 +597,7 @@ static void __init omap3_beagle_init(void)
> =A0 =A0 =A0 =A0platform_add_devices(omap3_beagle_devices,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(omap3_beagl=
e_devices));
> =A0 =A0 =A0 =A0omap_display_init(&beagle_dss_data);
> - =A0 =A0 =A0 omap_serial_init();
> + =A0 =A0 =A0 board_serial_init();
> =A0 =A0 =A0 =A0omap_sdrc_init(mt46h32m32lf6_sdrc_params,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mt=
46h32m32lf6_sdrc_params);
>
> --
> 1.7.5.4



--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
