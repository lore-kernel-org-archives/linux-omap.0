From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv1 1/3] OMAP UART: Adds omap-serial driver support.
Date: Tue, 13 Oct 2009 13:56:57 -0700
Message-ID: <20091013205657.GD12700@atomide.com>
References: <65168.192.168.10.89.1253788033.squirrel@dbdmail.itg.ti.com> <20091007215116.GB29320@atomide.com> <d6a0f7aa0910072314h77383e31r2330725b614ba472@mail.gmail.com> <E0D41E29EB0DAC4E9F3FF173962E9E940253C6C560@dbde02.ent.ti.com> <20091009174635.GH25892@atomide.com> <7f9d1ffb0910122354o64b5aa01l3fe33ab78dfb5f23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63880 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760558AbZJMU5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 16:57:43 -0400
Content-Disposition: inline
In-Reply-To: <7f9d1ffb0910122354o64b5aa01l3fe33ab78dfb5f23@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishore kadiyala <kishorek.kadiyala@gmail.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Govindraj <govindraj.ti@gmail.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

* kishore kadiyala <kishorek.kadiyala@gmail.com> [091012 23:54]:
> Tony,
>=20
> On Fri, Oct 9, 2009 at 11:16 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * G, Manjunath Kondaiah <manjugk@ti.com> [091008 00:41]:
> >>
> >> Govind,
> >> > -----Original Message-----
> >> > From: linux-omap-owner@vger.kernel.org
> >> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Govindraj
> >> > Sent: Thursday, October 08, 2009 11:44 AM
> >> > To: Tony Lindgren
> >> > Cc: Raja, Govindraj; linux-omap@vger.kernel.org;
> >> > linux-kernel@vger.kernel.org; linux-serial@vger.kernel.org
> >> > Subject: Re: [PATCHv1 1/3] OMAP UART: Adds omap-serial driver su=
pport.
> >> >
> >> > On Thu, Oct 8, 2009 at 3:21 AM, Tony Lindgren
> >> > <tony@atomide.com> wrote:
> >> > > * Govindraj.R <govindraj.raja@ti.com> [090924 03:29]:
> >> > >> From: Govindraj R <govindraj.raja@ti.com>
> >> > >>
> >> > >> This patch adds support for OMAP3430-HIGH SPEED UART Controll=
er.
> >> > >>
> >> > >> Signed-off-by: =A0 =A0 =A0 =A0Govindraj R <govindraj.raja@ti.=
com>
> >> > >> Reviewed-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >> > >> Reviewed-by: Tony Lindgren <tony@atomide.com>
> >> > >
> >> > > You should only add Reviewed-by if Alan or me have replied wit=
h it.
> >> > >
> >> > > So far I've only replied with some comments that have not yet
> >> > > been fixed, so we're few more steps from being Reviewd-by.
> >> > >
> >> > > <snip>
> >> > >
> >> > >> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> >> > >> index 6553833..67a7129 100644
> >> > >> --- a/drivers/serial/Kconfig
> >> > >> +++ b/drivers/serial/Kconfig
> >> > >> @@ -1359,6 +1359,53 @@ config SERIAL_OF_PLATFORM
> >> > >> =A0 =A0 =A0 =A0 Currently, only 8250 compatible ports are sup=
ported, but
> >> > >> =A0 =A0 =A0 =A0 others can easily be added.
> >> > >>
> >> > >> +config SERIAL_OMAP
> >> > >> + =A0 =A0 bool "OMAP serial port support"
> >> > >> + =A0 =A0 depends on ARM && ARCH_OMAP
> >> > >> + =A0 =A0 select SERIAL_CORE
> >> > >> + =A0 =A0 help
> >> > >> + =A0 =A0 If you have a machine based on an Texas Instruments
> >> > OMAP CPU you
> >> > >> + =A0 =A0 can enable its onboard serial ports by enabling thi=
s option.
> >> > >> +
> >> > >> +config SERIAL_OMAP_CONSOLE
> >> > >> + =A0 =A0 bool "Console on OMAP serial port"
> >> > >> + =A0 =A0 depends on SERIAL_OMAP
> >> > >> + =A0 =A0 select SERIAL_CORE_CONSOLE
> >> > >> + =A0 =A0 help
> >> > >> + =A0 =A0 If you have enabled the serial port on the Texas
> >> > Instruments OMAP
> >> > >> + =A0 =A0 CPU you can make it the console by answering Y to
> >> > this option.
> >> > >> +
> >> > >> + =A0 =A0 Even if you say Y here, the currently visible virtu=
al console
> >> > >> + =A0 =A0 (/dev/tty0) will still be used as the system consol=
e
> >> > by default, but
> >> > >> + =A0 =A0 you can alter that using a kernel command line opti=
on such as
> >> > >> + =A0 =A0 "console=3DttyS0". (Try "man bootparam" or see the
> >> > documentation of
> >> > >> + =A0 =A0 your boot loader (lilo or loadlin) about how to pas=
s
> >> > options to the
> >> > >> + =A0 =A0 kernel at boot time.)
> >> > >> +
> >> > >> +config SERIAL_OMAP_DMA_UART1
> >> > >> + =A0 =A0 bool "UART1 DMA support"
> >> > >> + =A0 =A0 depends on SERIAL_OMAP
> >> > >> + =A0 =A0 help
> >> > >> + =A0 =A0 If you have enabled the serial port on the Texas
> >> > Instruments OMAP
> >> > >> + =A0 =A0 CPU you can enable the DMA transfer on UART 1 by an=
swering
> >> > >> + =A0 =A0 to this option.
> >> > >> +
> >> > >> +config SERIAL_OMAP_DMA_UART2
> >> > >> + =A0 =A0 bool "UART2 DMA support"
> >> > >> + =A0 =A0 depends on SERIAL_OMAP
> >> > >> + =A0 =A0 help
> >> > >> + =A0 =A0 If you have enabled the serial port on the Texas
> >> > Instruments OMAP
> >> > >> + =A0 =A0 CPU you can enable the DMA transfer on UART 2 by an=
swering
> >> > >> + =A0 =A0 to this option.
> >> > >> +
> >> > >> +config SERIAL_OMAP_DMA_UART3
> >> > >> + =A0 =A0 bool "UART3 DMA support"
> >> > >> + =A0 =A0 depends on SERIAL_OMAP
> >> > >> + =A0 =A0 help
> >> > >> + =A0 =A0 If you have enabled the serial port on the Texas
> >> > Instruments OMAP
> >> > >> + =A0 =A0 CPU you can enable the DMA transfer on UART 3 by an=
swering
> >> > >> + =A0 =A0 to this option.
> >> > >> +
> >> > >> =A0config SERIAL_OF_PLATFORM_NWPSERIAL
> >> > >> =A0 =A0 =A0 tristate "NWP serial port driver"
> >> > >> =A0 =A0 =A0 depends on PPC_OF && PPC_DCR
> >> > >
> >> > > There's absolutely no need for having Kconfig options for the =
DMA
> >> > > support. Please pass that in platform_data from the board-*.c =
files.
> >> > >
> >> > > This is the third time I'm commenting on the same issue!
> >> > >
> >> > > What's the point of posting these patches for review if the is=
sues
> >> > > don't get solved?
> >> >
> >> >
> >> > The omap-serial uart driver is designed to work either in interr=
upt
> >> > mode or in DMA mode,
> >> > We have provided this option so that one can select interrupt mo=
de or
> >> > DMA mode based on the uart usage, if somebody is using uart as c=
onsole
> >> > then interrupt mode will do, else if used with bluetooth which d=
oes
> >> > huge data transfer then DMA mode can be selected.
> >> >
> >> > Don't you think this should be a configurable option using kconf=
ig
> >> > rather than passing as platform data?
> >
> > Nope. I think it should be platform_data and should be possible to =
override
> > vith a kernel cmdline option. That's because we support compiling i=
n and
> > booting many boards the same kernel binary.
> >
> >> > if used as platform data then one has to modify platform data to
> >> > switch between the interrupt and DMA mode.
> >
> > How about set some kernel cmdline options if you want to override t=
he
> > default settings?
>=20
>    Using cmdline options, will make specific UART switch  dynamically
>    between Non-DMA and DMA mode which is not handled in the driver.

Switching between dma transfers and pio should be easy to do, we're
already doing that in various omap drivers like mmc, musb/tusb
and onenand.

So I would recommend making that change, it is quite trivial
to do and will make the code much cleaner. And also gets rid
of the issue with Kconfig settings breaking booting for other
boards.
=20
>    how abt using bootargs to share this Mode info ?

The bootargs should override what is passed from platform_data.

Regards,

Tony

>=20
> >
> >> Usage of UART is board dependent. It's usage will not change dynam=
ically for
> >> a given board. This can be removed from Kconfig and move it to res=
pective
> >> board file-> board-*.c
> >
> > Or can be changed from kernel cmdline if necessary.
> >
> > Regards,
> >
> > Tony
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
