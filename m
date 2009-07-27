From: matthias schwarz <matthias.schw@googlemail.com>
Subject: Re: Camera Interface VS/HS Issue
Date: Mon, 27 Jul 2009 20:46:24 +0200
Message-ID: <a187869d0907271146q66112fc8l85aa37c8b1512d68@mail.gmail.com>
References: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>
	 <a187869d0907270725n7fce759bs6bcaeed70bd7f872@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16EC65@dlee02.ent.ti.com>
	 <a187869d0907270859l313b86d3nea833c7a019d35be@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16ECD1@dlee02.ent.ti.com>
	 <a187869d0907270911j74ee55b9nc872687eb32aecce@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16ED18@dlee02.ent.ti.com>
	 <a187869d0907271036meb56ce9r32c5f5e823465e87@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16EE88@dlee02.ent.ti.com>
	 <a187869d0907271145i177dcf52jb75aee758300878@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f221.google.com ([209.85.218.221]:56564 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbZG0SqZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 14:46:25 -0400
Received: by bwz21 with SMTP id 21so425078bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2009 11:46:24 -0700 (PDT)
In-Reply-To: <a187869d0907271145i177dcf52jb75aee758300878@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org

---------- Forwarded message ----------
=46rom: matthias schwarz <matthias.schw@googlemail.com>
Date: 2009/7/27
Subject: Re: Camera Interface VS/HS Issue
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>


2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>:
>
>
>> -----Original Message-----
>> From: matthias schwarz [mailto:matthias.schw@googlemail.com]
>> Sent: Monday, July 27, 2009 12:37 PM
>> To: Aguirre Rodriguez, Sergio Alberto
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: Camera Interface VS/HS Issue
>>
>> 2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>:
>> >
>> >
>> >> -----Original Message-----
>> >> From: matthias schwarz [mailto:matthias.schw@googlemail.com]
>> >> Sent: Monday, July 27, 2009 11:12 AM
>> >> To: Aguirre Rodriguez, Sergio Alberto
>> >> Cc: linux-omap@vger.kernel.org
>> >> Subject: Re: Camera Interface VS/HS Issue
>> >>
>> >> 2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>:
>> >> >
>> >> >
>> >> >> -----Original Message-----
>> >> >> From: matthias schwarz [mailto:matthias.schw@googlemail.com]
>> >> >> Sent: Monday, July 27, 2009 10:59 AM
>> >> >> To: Aguirre Rodriguez, Sergio Alberto
>> >> >> Cc: linux-omap@vger.kernel.org
>> >> >> Subject: Re: Camera Interface VS/HS Issue
>> >> >>
>> >> >> 2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>=
:
>> >> >> > Matthias,
>> >> >> >
>> >> >> > Please avoid top-posting, because its prohibited by the mail=
ing
>> list
>> >> >> rules. I'm readjusting it for you below
>> >> >>
>> >> >> Oh, i am sorry about that, it is not going to happen again, pr=
omise.
>> >> >> And thank you for readjusting.
>> >> >
>> >> > Anytime :)
>> >> >>
>> >> >> >
>> >> >> > From: matthias schwarz [mailto:matthias.schw@googlemail.com]
>> >> >> >> 2009/7/27 matthias schwarz <matthias.schw@googlemail.com>:
>> >> >> >> > 2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti=
=2Ecom>:
>> >> >> >> >> (rearranging mail to avoid top posting..)
>> >> >> >> >>
>> >> >> >> >> From: matthias schwarz [mailto:matthias.schw@googlemail.=
com]
>> >> >> >> >>> 2009/7/27 Aguirre Rodriguez, Sergio Alberto
>> <saaguirre@ti.com>:
>> >> >> >> >>> >
>> >> >> >> >>> >
>> >> >> >> >>> >> -----Original Message-----
>> >> >> >> >>> >> From: linux-omap-owner@vger.kernel.org [mailto:linux=
-omap-
>> >> >> >> >>> >> owner@vger.kernel.org] On Behalf Of matthias schwarz
>> >> >> >> >>> >> Sent: Monday, July 27, 2009 7:47 AM
>> >> >> >> >>> >> To: linux-omap@vger.kernel.org
>> >> >> >> >>> >> Subject: Camera Interface VS/HS Issue
>> >> >> >> >>> >>
>> >> >> >> >>> >> Hi there,
>> >> >> >> >>> >>
>> >> >> >> >>> >> i just recently ran into a problem when trying to le=
t the
>> ISP
>> >> >> >> >>> >> (OMAP3530) generate HS/VS signals in SYNC mode.
>> >> >> >> >>> >> I am building a module to do so.
>> >> >> >> >>> >>
>> >> >> >> >>> >> It basically enables the three clocks (cam_ick, cam_=
mclk
>> and
>> >> >> >> >>> >> csi2_96m_fck),
>> >> >> >> >>> >> then sets
>> >> >> >> >>> >>
>> >> >> >> >>> >> ISPCCDC_PIX_LINES_PPLN
>> >> >> >> >>> >> ISPCCDC_PIX_LINES_HLPRF
>> >> >> >> >>> >> ISPCCDC_HD_VD_WID_VDW
>> >> >> >> >>> >> ISPCCDC_HD_VD_WID_HDW
>> >> >> >> >>> >> ISPCCDC_SYN_MODE_VDHDEN
>> >> >> >> >>> >> ISPCCDC_SYN_MODE_VDHDOUT
>> >> >> >> >>> >> ISPCCDC_CFG_VDLC
>> >> >> >> >>> >> ISPTCTRL_CTRL_DIVA
>> >> >> >> >>> >> ISPTCTRL_CTRL_DIVB
>> >> >> >> >>> >> ISPCCDC_PCR
>> >> >> >> >>> >>
>> >> >> >> >>> >> via some calls to ioremap and ioread32/iowrite32.
>> >> >> >> >>> >> My question now is the following:
>> >> >> >> >>> >> when i hook an oscilloscope to the corresponding pin=
s
>> >> (CAM_VS,
>> >> >> >> CAM_HS,
>> >> >> >> >>> >> CAM_XCLKA) i can see that only the CAM_XCLKA is work=
ing
>> >> >> correctly,
>> >> >> >> >>> >> also at the configured frequency.
>> >> >> >> >>> >> Both, CAM_VS and CAM_HS remain at low voltage all th=
e
>> time,
>> >> even
>> >> >> >> when
>> >> >> >> >>> >> i switch their polarities (ISPCCDC_SYN_MODE_VDPOL,
>> >> >> >> >>> >> ISPCCDC_SYN_MODE_HDPOL) that behavior does not chang=
e and
>> >> >> signals
>> >> >> >> >>> >> always remain at low voltage.
>> >> >> >> >>> >>
>> >> >> >> >>> >> Could someone help me out, or give me a hint what i =
might
>> be
>> >> >> >> missing
>> >> >> >> >>> >> to generate those output signals correctly?
>> >> >> >> >>> >
>> >> >> >> >>> > Matthias,
>> >> >> >> >>> >
>> >> >> >> >>> > Can you please provide a register dump of the above v=
alues?
>> >> >> >> >>> >
>> >> >> >> >>> > Looks like you're touching the adequate registers tho=
ugh...
>> >> But I
>> >> >> >> can
>> >> >> >> >>> help you more looking at the values.
>> >> >> >> >>> >
>> >> >> >> >>> Sure i can,
>> >> >> >> >>> register values are the following:
>> >> >> >> >>>
>> >> >> >> >>> ccdc_pix_lines: 0x050005a0
>> >> >> >> >>>
>> >> >> >> >>> ccdc_hd_vd_wid: 0x00320064
>> >> >> >> >>>
>> >> >> >> >>> ccdc_syn_mode: 0x00050c0c
>> >> >> >> >>
>> >> >> >> >> This is wrong, because:
>> >> >> >> >>
>> >> >> >> >> Bit0 sets directions of cam_hs and cam_vs signals with t=
his
>> >> values:
>> >> >> >> >> =A0- 0: Input (what you're setting with that values)
>> >> >> >> >> =A0- 1: Output (Is this what you want?)
>> >> >> >> >>
>> >> >> >> >> Bit1 Sets direction of cam_fld pin, which follows the sa=
me
>> logic
>> >> as
>> >> >> the
>> >> >> >> Bit0.
>> >> >> >> >>
>> >> >> >> >> Others could be wrong or bad, depending on your exact us=
ecase
>> and
>> >> >> >> config intention.
>> >> >> >> >>
>> >> >> >> >> Hope this helps.
>> >> >> >> >>
>> >> >> >> > Hmm,
>> >> >> >> > so now i have:
>> >> >> >> >
>> >> >> >> > ccdc_syn_mode: 0x00050c0f
>> >> >> >> >
>> >> >> >> > but that does not change the behavior i am experiencing, =
both
>> pins
>> >> >> >> > (CAM_VS, CAM_HS) remain at low voltage at all times.
>> >> >> >> >
>> >> >> >> > I don't have to do anything but enabling the correspondin=
g
>> clocks
>> >> to
>> >> >> >> > make sure the CCDC is working?
>> >> >> >> I also set,
>> >> >> >>
>> >> >> >> ISPCTRL_CCDC_CLK_EN
>> >> >> >> ISPCTRL_CCDC_RAM_EN
>> >> >> >>
>> >> >> >> but those also won't change the always low voltage pins.
>> >> >> >
>> >> >> > Are you having a valid Pixel clock input to the CCDC?
>> >> >>
>> >> >> Actually, i did not check that. And that signal also is not
>> provided.
>> >> >> Just to confirm: pixelclock refers to the clocking signal comi=
ng
>> back
>> >> >> from the sensor?
>> >> >
>> >> > Yeah, you normally provide the XCLK to the sensor, and the sens=
or
>> >> responds with a PCLK (Pixelclock) to make the ISP aware on when t=
o
>> latch
>> >> the values coming from the port, and increase the counters for th=
e
>> timing
>> >> generator to generate HS/VS in your case.
>> >>
>> >> I know its dirty, but since the sensor won't give me a pixelclock
>> >> without fiddling with its config, i just connected XCLK to PCLK (=
which
>> >> should provide a PCLK to CCDC then).
>> >> What i experience now is still the same issue, meaning low voltag=
e on
>> >> both CAM_VS and CAM_HS...
>> >
>> > Hmm,
>> >
>> > I'm sorry, but I'm a bit confused on what are you trying to do
>> exactly...
>> >
>> > Is it possible to elaborate on your usecase publicly?
>>
>> I am trying to attach an image-sensor which won't generate a
>> pixelclock without further configuration.
>> And since i need a valid PCLK to generate H- and V-Sync signals
>> correctly i am just trying to connect the correspondig pins (so XCLK
>> is looped back to PCLK) to see if the CCDC will generate those
>> signals. Later on i will surely configure the sensor correctly to
>> generate its own PCLK signal.
>> But apparently it does not work, which should mean that there is sti=
ll
>> some other issue, doesn't it?
>
> Well, yeah...
>
> But one thing I'm still confused about is why you need sync signals w=
ithout a valid sensor config?

Was just to try out if pixelclock was the only thing going wrong.
Anything else would have taken more time, will look into the config
tomorrow though.

>
> Normally it is just a matter of providing a valid XCLK to the sensor =
for it to start working, so the sensor can be configured through I2C wi=
thout problem, and then at the last, turn on CCDC->PREV->RSZ just after=
 the sensor is properly configured.
>
> Are you using Omap3 camera driver posted by both Sakari Ailus and mys=
elf?

I just wrote that module together myself, but will look into your code
of course.

>
> Sakari's tree is located on:
>
> =A0 =A0 =A0 =A0http://www.gitorious.org/projects/omap3camera
>
> And mine is located on:
>
> =A0 =A0 =A0 =A0http://dev.omapzoom.org/?p=3Dsaaguirre/linux-omap-came=
ra.git;a=3Dshortlog;h=3Drefs/heads/devel
>
> Mine is based on Sakari's, but rebased with a newer kernel and with s=
ome sensors interfaced with the 3430SDP, MT9P012 (5MP Parallel interfac=
e) and OV3640 (3MP CSI2 Interface).
>
> Are you doing this from scratch?

Like i said before, yes i am currently doing this from scratch, but
will look into that.
Thank you,
Matthias

>
> Regards,
> Sergio
>>
>> Thank you,
>> Matthias
>>
>>
>> >
>> > Regards,
>> > Sergio
>> >>
>> >> >>
>> >> >> >
>> >> >> > I just confirmed with our internal TI HW support, and you ne=
ed a
>> >> valid
>> >> >> pixel input clock to assert/deassert the signals.
>> >> >>
>> >> >> So it is an issue with the sensor itself,
>> >> >
>> >> > Looks like...
>> >> >
>> >> >> Thank you very much,
>> >> >> Matthias
>> >> >>
>> >> >> >
>> >> >> > Regards,
>> >> >> > Sergio
>> >> >> >> >
>> >> >> >> > Thank you,
>> >> >> >> > Matthias
>> >> >> >> >> Regards,
>> >> >> >> >> Sergio
>> >> >> >> >>>
>> >> >> >> >>> ccdc_cfg: 0x00008000
>> >> >> >> >>>
>> >> >> >> >>> tctrl_ctrl_cfg: 0x80000463
>> >> >> >> >>>
>> >> >> >> >>> ccdc_pcr: 0x00000001
>> >> >> >> >>>
>> >> >> >> >>> Thank you,
>> >> >> >> >>> Matthias
>> >> >> >> >>> > Regards,
>> >> >> >> >>> > Sergio
>> >> >> >> >>> >>
>> >> >> >> >>> >> Thank you very much,
>> >> >> >> >>> >> Matthias
>> >> >> >> >>> >> --
>> >> >> >> >>> >> To unsubscribe from this list: send the line "unsubs=
cribe
>> >> linux-
>> >> >> >> omap"
>> >> >> >> >>> in
>> >> >> >> >>> >> the body of a message to majordomo@vger.kernel.org
>> >> >> >> >>> >> More majordomo info at =A0http://vger.kernel.org/maj=
ordomo-
>> >> >> info.html
>> >> >> >> >>> >
>> >> >> >> >>> >
>> >> >> >> >>
>> >> >> >> >>
>> >> >> >> >
>> >> >> >
>> >> >> >
>> >> >
>> >> >
>> >
>> >
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
