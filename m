From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Camera Interface VS/HS Issue
Date: Mon, 27 Jul 2009 11:08:08 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A16ECD1@dlee02.ent.ti.com>
References: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16E999@dlee02.ent.ti.com>
	 <a187869d0907270609k5ef0d699tbd22d43602709588@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16E9C6@dlee02.ent.ti.com>
	 <a187869d0907270632p5fbc9ffcp6538692675a4175@mail.gmail.com>
	 <a187869d0907270725n7fce759bs6bcaeed70bd7f872@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16EC65@dlee02.ent.ti.com>
 <a187869d0907270859l313b86d3nea833c7a019d35be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34330 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbZG0QEe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 12:04:34 -0400
In-Reply-To: <a187869d0907270859l313b86d3nea833c7a019d35be@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: matthias schwarz <matthias.schw@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: matthias schwarz [mailto:matthias.schw@googlemail.com]
> Sent: Monday, July 27, 2009 10:59 AM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Camera Interface VS/HS Issue
>=20
> 2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>:
> > Matthias,
> >
> > Please avoid top-posting, because its prohibited by the mailing lis=
t
> rules. I'm readjusting it for you below
>=20
> Oh, i am sorry about that, it is not going to happen again, promise.
> And thank you for readjusting.

Anytime :)
>=20
> >
> > From: matthias schwarz [mailto:matthias.schw@googlemail.com]
> >> 2009/7/27 matthias schwarz <matthias.schw@googlemail.com>:
> >> > 2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>:
> >> >> (rearranging mail to avoid top posting..)
> >> >>
> >> >> From: matthias schwarz [mailto:matthias.schw@googlemail.com]
> >> >>> 2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>=
:
> >> >>> >
> >> >>> >
> >> >>> >> -----Original Message-----
> >> >>> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> >>> >> owner@vger.kernel.org] On Behalf Of matthias schwarz
> >> >>> >> Sent: Monday, July 27, 2009 7:47 AM
> >> >>> >> To: linux-omap@vger.kernel.org
> >> >>> >> Subject: Camera Interface VS/HS Issue
> >> >>> >>
> >> >>> >> Hi there,
> >> >>> >>
> >> >>> >> i just recently ran into a problem when trying to let the I=
SP
> >> >>> >> (OMAP3530) generate HS/VS signals in SYNC mode.
> >> >>> >> I am building a module to do so.
> >> >>> >>
> >> >>> >> It basically enables the three clocks (cam_ick, cam_mclk an=
d
> >> >>> >> csi2_96m_fck),
> >> >>> >> then sets
> >> >>> >>
> >> >>> >> ISPCCDC_PIX_LINES_PPLN
> >> >>> >> ISPCCDC_PIX_LINES_HLPRF
> >> >>> >> ISPCCDC_HD_VD_WID_VDW
> >> >>> >> ISPCCDC_HD_VD_WID_HDW
> >> >>> >> ISPCCDC_SYN_MODE_VDHDEN
> >> >>> >> ISPCCDC_SYN_MODE_VDHDOUT
> >> >>> >> ISPCCDC_CFG_VDLC
> >> >>> >> ISPTCTRL_CTRL_DIVA
> >> >>> >> ISPTCTRL_CTRL_DIVB
> >> >>> >> ISPCCDC_PCR
> >> >>> >>
> >> >>> >> via some calls to ioremap and ioread32/iowrite32.
> >> >>> >> My question now is the following:
> >> >>> >> when i hook an oscilloscope to the corresponding pins (CAM_=
VS,
> >> CAM_HS,
> >> >>> >> CAM_XCLKA) i can see that only the CAM_XCLKA is working
> correctly,
> >> >>> >> also at the configured frequency.
> >> >>> >> Both, CAM_VS and CAM_HS remain at low voltage all the time,=
 even
> >> when
> >> >>> >> i switch their polarities (ISPCCDC_SYN_MODE_VDPOL,
> >> >>> >> ISPCCDC_SYN_MODE_HDPOL) that behavior does not change and
> signals
> >> >>> >> always remain at low voltage.
> >> >>> >>
> >> >>> >> Could someone help me out, or give me a hint what i might b=
e
> >> missing
> >> >>> >> to generate those output signals correctly?
> >> >>> >
> >> >>> > Matthias,
> >> >>> >
> >> >>> > Can you please provide a register dump of the above values?
> >> >>> >
> >> >>> > Looks like you're touching the adequate registers though... =
But I
> >> can
> >> >>> help you more looking at the values.
> >> >>> >
> >> >>> Sure i can,
> >> >>> register values are the following:
> >> >>>
> >> >>> ccdc_pix_lines: 0x050005a0
> >> >>>
> >> >>> ccdc_hd_vd_wid: 0x00320064
> >> >>>
> >> >>> ccdc_syn_mode: 0x00050c0c
> >> >>
> >> >> This is wrong, because:
> >> >>
> >> >> Bit0 sets directions of cam_hs and cam_vs signals with this val=
ues:
> >> >> =A0- 0: Input (what you're setting with that values)
> >> >> =A0- 1: Output (Is this what you want?)
> >> >>
> >> >> Bit1 Sets direction of cam_fld pin, which follows the same logi=
c as
> the
> >> Bit0.
> >> >>
> >> >> Others could be wrong or bad, depending on your exact usecase a=
nd
> >> config intention.
> >> >>
> >> >> Hope this helps.
> >> >>
> >> > Hmm,
> >> > so now i have:
> >> >
> >> > ccdc_syn_mode: 0x00050c0f
> >> >
> >> > but that does not change the behavior i am experiencing, both pi=
ns
> >> > (CAM_VS, CAM_HS) remain at low voltage at all times.
> >> >
> >> > I don't have to do anything but enabling the corresponding clock=
s to
> >> > make sure the CCDC is working?
> >> I also set,
> >>
> >> ISPCTRL_CCDC_CLK_EN
> >> ISPCTRL_CCDC_RAM_EN
> >>
> >> but those also won't change the always low voltage pins.
> >
> > Are you having a valid Pixel clock input to the CCDC?
>=20
> Actually, i did not check that. And that signal also is not provided.
> Just to confirm: pixelclock refers to the clocking signal coming back
> from the sensor?

Yeah, you normally provide the XCLK to the sensor, and the sensor respo=
nds with a PCLK (Pixelclock) to make the ISP aware on when to latch the=
 values coming from the port, and increase the counters for the timing =
generator to generate HS/VS in your case.
>=20
> >
> > I just confirmed with our internal TI HW support, and you need a va=
lid
> pixel input clock to assert/deassert the signals.
>=20
> So it is an issue with the sensor itself,

Looks like...

> Thank you very much,
> Matthias
>=20
> >
> > Regards,
> > Sergio
> >> >
> >> > Thank you,
> >> > Matthias
> >> >> Regards,
> >> >> Sergio
> >> >>>
> >> >>> ccdc_cfg: 0x00008000
> >> >>>
> >> >>> tctrl_ctrl_cfg: 0x80000463
> >> >>>
> >> >>> ccdc_pcr: 0x00000001
> >> >>>
> >> >>> Thank you,
> >> >>> Matthias
> >> >>> > Regards,
> >> >>> > Sergio
> >> >>> >>
> >> >>> >> Thank you very much,
> >> >>> >> Matthias
> >> >>> >> --
> >> >>> >> To unsubscribe from this list: send the line "unsubscribe l=
inux-
> >> omap"
> >> >>> in
> >> >>> >> the body of a message to majordomo@vger.kernel.org
> >> >>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-
> info.html
> >> >>> >
> >> >>> >
> >> >>
> >> >>
> >> >
> >
> >

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
