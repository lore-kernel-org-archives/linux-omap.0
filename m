From: "Aguilar Pena, Leed" <x0082440@ti.com>
Subject: RE: About the status of USB support on OMAP2430 SDP
Date: Thu, 1 Nov 2007 13:21:47 -0500
Message-ID: <FB5B108DCADA024D9B1BACAD8EC4CAF501FC7580@dlee11.ent.ti.com>
References: <47274B8B.1080802@gmail.com>	<1E65310C3C9FCC4AAE66BA8952B9842D0215D7C9@dlee11.ent.ti.com>
	<FB5B108DCADA024D9B1BACAD8EC4CAF501FC757A@dlee11.ent.ti.com>
	<4727DC4F.5040208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: DAMWID <damwid@gmail.com>
Cc: "Castaneda Gonzalez, Axel" <x0055901@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Damwid,
=20
Sorry for the late response.
=20
The functionality you are looking for is not yet merged in the GIT tree, =
but you can find the pin mux code in arch/arm/plat-omap/usb.c in the =
2.6.14 tarball (http://linux.omap.com).
=20
Best Regards!
=20
Leed Salim

________________________________

From: DAMWID [mailto:damwid@gmail.com]
Sent: Tue 10/30/2007 8:37 PM
To: Aguilar Pena, Leed
Cc: linux-omap-open-source@linux.omap.com; Castaneda Gonzalez, Axel
Subject: Re: About the status of USB support on OMAP2430 SDP



Hi Leed,

Thanks for your comment, but I can find any port and pin mux related
settings in the linux-omap git tree, is there any patch for it?

Thanks,
Damwid

Aguilar Pena, Leed ??:
> Hi Damwid,
>=20
> Please try the following:
>=20
> To activate both, FS and HS ports:  =20
>=20
> On V2 and V4 you need  a Connectivity Board (750-2003-003 (C)) (I have =
not test USB on SDP2430 V3)
>=20
> Switch on Main Board
> S6 [6-ON, 7-OFF]
>=20
> Linux Kernel configuration --->
>                 Device Drivers ----->
>                               I2C support ---->
>                                        Miscellaneous I2C Chip support =
---->
>                                                                   ....
>                                                                   ....
>                                                                   <*> =
Philips ISP1301 with OMAP OTG
>                                                                   ....
>=20
> Linux Kernel configuration --->
>                 Device Drivers ----->
>                           USB support --->
>                                        ....
>                                        ...                             =
                                                                         =
                                             =20
>                                       <*>   OHCI HCD support           =
                                                                         =
                         =20
>                                        [*]     Use OMAP's full-speed =
USB Port 1 instead of Port 0                                             =
      |                         =20
>                                                                    Pin =
mux selection (USB1 signals muxed with UART2)  --->    -------->   |    =
To test on SDP4.0:
>                                                                        =
                                                                         =
                                                |     Select "USB1 =
signals muxed with UART1", and use UART2 for console.
>                                                                        =
                                                                         =
                                                |    To test on SDP5.0:
>                                                                        =
                                                                         =
                                                |     Select "USB1 =
signals muxed with UART2" and use the usual UART1 for console            =
                                        =20
>                                       ....
>                                       <*> Inventra Highspeed Dual Role =
Controller (TI, ...)  =20
>                                       ....                             =
                                               =20
>=20
>=20
> To Activate only FS Port:
>=20
> Switch on Main Board
> S6 [6-ON, 7-ON]
> Disable the following:
> < > Inventra Highspeed Dual Role Controller (TI, ...)
> [ ]     Use OMAP's full-speed USB Port 1 instead of Port 0     =20
>=20
>=20
>=20
> Any comment please let me know
>=20
> Regards!
>=20
> Leed Salim
>
> ________________________________
>
> From: linux-omap-open-source-bounces@linux.omap.com on behalf of =
DAMWID
> Sent: Tue 10/30/2007 10:19 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: About the status of USB support on OMAP2430 SDP
>
>
>
> Hi all,
>
> I'm working on the USB dirver on my OMAP2430 SDP v3.0 board with
> linux-omap git tree, currently I can make the Inventra controller =
(musb)
> work in host/device/OTG mode, but only for one port on the processor
> board. How can I enable USB host on the other ports? Should I use the
> ohci-omap module? I'm not clear with the relationship between musb and
> ohci-omap, are they separate controllers?
>
> I can't get the ohci-omap work on my board, and I was confused by the
> kernel configs in "USB support" section. Is it enough to get ohci-omap
> work by just enable USB_OHCI_HCD? I notice there is a ISP1301
> transceiver on the main borad, so is the isp1301_omap driver needed? I
> found it depends on OMAP_OTG, which is not selected by ARCH_OMAP2430,
> does this mean isp1301_omap dirver is not necessary for ohci-omap?
>
> Does anyone get the ohci-omap work? Can you give some help?
>
> Thanks,
> Damwid
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
> =20
