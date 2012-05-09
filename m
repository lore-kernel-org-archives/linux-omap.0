From: Neil Johnson <neilj@procerusuav.com>
Subject: Re: DSS2 DVI output: red screen
Date: Wed, 9 May 2012 10:08:18 -0600
Message-ID: <CAEULaVJzoG_uF7ji+UCSKZN_jhULWaKzZ-HMtH6c8dD7KqM2+g@mail.gmail.com>
References: <CAEULaV+_Ch7T0yA==XC8_xORhN2rcre=W4nbKYq+vxQkdKAeCw@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83EA18990@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36748 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757617Ab2EIQIU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 12:08:20 -0400
Received: by lbbgm6 with SMTP id gm6so336165lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 09:08:18 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA18990@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vaibhav,

Thanks for your help on this.=A0 I was unaware that the Kernel changed
the pin-mux after U-boot did the initial setup.=A0 Applying this fix to
the linux kernel fixed the problem.=A0 Much appreciated,

Neil Johnson



On Mon, May 7, 2012 at 11:21 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
>
> On Tue, May 08, 2012 at 04:41:35, Neil Johnson wrote:
> > Linux OMAP list:
> >
> > We are proving out the DVI output on a DM3730 board that we've
> > designed, and we're seeing something strange: Our output to the vid=
eo
> > window is always red. =A0We see the penguin show up in the corner, =
and
> > text/graphics show up, but the red channel is always on for all pix=
els
> > on the screen.
> >
> > Studying our schematic and comparing with the Beagleboard-xm
> > schematic, it appears that we're hooking everything up the same way=
,
> > with just some subtle differences:
> >
> > We desire to output 1280x720 resolution (720p), and that means we n=
eed
> > to use the alternate configuration for the DSS output pins, as
> > mentioned in the DM3730 TRM:
> >
> > On Page 1564, it states:
> >
> > The DISPC_DATA_LCD[5:0] data multiplexed with the DSI signals on
> > dss_data[5:0] pads is limited to up to 60 MHz pixel clock frequency=
=2E
> > If the parallel 18/24-bit interface in bypass mode with a pixel clo=
ck
> > above 60 MHz is required, the DISPC_DATA_LCD[5:0] multiplexed on
> > dss_data[23:18] pads, and DISPC_DATA_LCD[23:18] multiplexed on
> > sys_boot pads must be used.
> >
> > So, we've mapped DISPC_DATA_LCD[5:0] to dss_data[23:18] pads and
> > routed DISPC_DATA_LCD[23:18] to be multiplexed with the sys_boot pa=
ds.
> >
> > Our sys_boot pads are all pulled up to 1.8 V through 4.7 K-ohm
> > resistors. =A0I'm suspicious that this is causing the red lines to =
be
> > pulled high, generating red pixels all the time. =A0Am I off-base h=
ere?
> > Is there something I'm missing, like the U-boot mux configuration o=
r
> > something? =A0What can I check from a software level to verify that=
 all
> > is correct? =A0According to the Beagle-board-xm manual, the board
> > auto-detects which way things are hooked up, but maybe I haven't
> > grabbed that code from the beagleboard board file? =A0Thanks,
> >
>
>
> Make sure that you have configured the pin mux settings accordingly,
> We have similar interface done on OMAP3EVM, so you can refer to the
> Omap3evm code,
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap.git;a=3D=
blob;f=3Darch/arm/mach-omap2/board-omap3evm.c;h=3Dfd1b481c762c97576f1c9=
cb5503e9bd470a4a528;hb=3D5e136da4f5d9aa5388097afad1f6a0e6fd8572c6#l556
>
> Thanks,
> Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
