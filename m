From: matthias schwarz <matthias.schw@googlemail.com>
Subject: Re: Camera Interface VS/HS Issue
Date: Mon, 27 Jul 2009 17:59:03 +0200
Message-ID: <a187869d0907270859l313b86d3nea833c7a019d35be@mail.gmail.com>
References: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16E999@dlee02.ent.ti.com>
	 <a187869d0907270609k5ef0d699tbd22d43602709588@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16E9C6@dlee02.ent.ti.com>
	 <a187869d0907270632p5fbc9ffcp6538692675a4175@mail.gmail.com>
	 <a187869d0907270725n7fce759bs6bcaeed70bd7f872@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444A16EC65@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35134 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZG0P7F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 11:59:05 -0400
Received: by fxm18 with SMTP id 18so2692186fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2009 08:59:03 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE89444A16EC65@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org

2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>:
> Matthias,
>
> Please avoid top-posting, because its prohibited by the mailing list =
rules. I'm readjusting it for you below

Oh, i am sorry about that, it is not going to happen again, promise.
And thank you for readjusting.

>
> From: matthias schwarz [mailto:matthias.schw@googlemail.com]
>> 2009/7/27 matthias schwarz <matthias.schw@googlemail.com>:
>> > 2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>:
>> >> (rearranging mail to avoid top posting..)
>> >>
>> >> From: matthias schwarz [mailto:matthias.schw@googlemail.com]
>> >>> 2009/7/27 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>:
>> >>> >
>> >>> >
>> >>> >> -----Original Message-----
>> >>> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> >>> >> owner@vger.kernel.org] On Behalf Of matthias schwarz
>> >>> >> Sent: Monday, July 27, 2009 7:47 AM
>> >>> >> To: linux-omap@vger.kernel.org
>> >>> >> Subject: Camera Interface VS/HS Issue
>> >>> >>
>> >>> >> Hi there,
>> >>> >>
>> >>> >> i just recently ran into a problem when trying to let the ISP
>> >>> >> (OMAP3530) generate HS/VS signals in SYNC mode.
>> >>> >> I am building a module to do so.
>> >>> >>
>> >>> >> It basically enables the three clocks (cam_ick, cam_mclk and
>> >>> >> csi2_96m_fck),
>> >>> >> then sets
>> >>> >>
>> >>> >> ISPCCDC_PIX_LINES_PPLN
>> >>> >> ISPCCDC_PIX_LINES_HLPRF
>> >>> >> ISPCCDC_HD_VD_WID_VDW
>> >>> >> ISPCCDC_HD_VD_WID_HDW
>> >>> >> ISPCCDC_SYN_MODE_VDHDEN
>> >>> >> ISPCCDC_SYN_MODE_VDHDOUT
>> >>> >> ISPCCDC_CFG_VDLC
>> >>> >> ISPTCTRL_CTRL_DIVA
>> >>> >> ISPTCTRL_CTRL_DIVB
>> >>> >> ISPCCDC_PCR
>> >>> >>
>> >>> >> via some calls to ioremap and ioread32/iowrite32.
>> >>> >> My question now is the following:
>> >>> >> when i hook an oscilloscope to the corresponding pins (CAM_VS=
,
>> CAM_HS,
>> >>> >> CAM_XCLKA) i can see that only the CAM_XCLKA is working corre=
ctly,
>> >>> >> also at the configured frequency.
>> >>> >> Both, CAM_VS and CAM_HS remain at low voltage all the time, e=
ven
>> when
>> >>> >> i switch their polarities (ISPCCDC_SYN_MODE_VDPOL,
>> >>> >> ISPCCDC_SYN_MODE_HDPOL) that behavior does not change and sig=
nals
>> >>> >> always remain at low voltage.
>> >>> >>
>> >>> >> Could someone help me out, or give me a hint what i might be
>> missing
>> >>> >> to generate those output signals correctly?
>> >>> >
>> >>> > Matthias,
>> >>> >
>> >>> > Can you please provide a register dump of the above values?
>> >>> >
>> >>> > Looks like you're touching the adequate registers though... Bu=
t I
>> can
>> >>> help you more looking at the values.
>> >>> >
>> >>> Sure i can,
>> >>> register values are the following:
>> >>>
>> >>> ccdc_pix_lines: 0x050005a0
>> >>>
>> >>> ccdc_hd_vd_wid: 0x00320064
>> >>>
>> >>> ccdc_syn_mode: 0x00050c0c
>> >>
>> >> This is wrong, because:
>> >>
>> >> Bit0 sets directions of cam_hs and cam_vs signals with this value=
s:
>> >> =A0- 0: Input (what you're setting with that values)
>> >> =A0- 1: Output (Is this what you want?)
>> >>
>> >> Bit1 Sets direction of cam_fld pin, which follows the same logic =
as the
>> Bit0.
>> >>
>> >> Others could be wrong or bad, depending on your exact usecase and
>> config intention.
>> >>
>> >> Hope this helps.
>> >>
>> > Hmm,
>> > so now i have:
>> >
>> > ccdc_syn_mode: 0x00050c0f
>> >
>> > but that does not change the behavior i am experiencing, both pins
>> > (CAM_VS, CAM_HS) remain at low voltage at all times.
>> >
>> > I don't have to do anything but enabling the corresponding clocks =
to
>> > make sure the CCDC is working?
>> I also set,
>>
>> ISPCTRL_CCDC_CLK_EN
>> ISPCTRL_CCDC_RAM_EN
>>
>> but those also won't change the always low voltage pins.
>
> Are you having a valid Pixel clock input to the CCDC?

Actually, i did not check that. And that signal also is not provided.
Just to confirm: pixelclock refers to the clocking signal coming back
from the sensor?

>
> I just confirmed with our internal TI HW support, and you need a vali=
d pixel input clock to assert/deassert the signals.

So it is an issue with the sensor itself,
Thank you very much,
Matthias

>
> Regards,
> Sergio
>> >
>> > Thank you,
>> > Matthias
>> >> Regards,
>> >> Sergio
>> >>>
>> >>> ccdc_cfg: 0x00008000
>> >>>
>> >>> tctrl_ctrl_cfg: 0x80000463
>> >>>
>> >>> ccdc_pcr: 0x00000001
>> >>>
>> >>> Thank you,
>> >>> Matthias
>> >>> > Regards,
>> >>> > Sergio
>> >>> >>
>> >>> >> Thank you very much,
>> >>> >> Matthias
>> >>> >> --
>> >>> >> To unsubscribe from this list: send the line "unsubscribe lin=
ux-
>> omap"
>> >>> in
>> >>> >> the body of a message to majordomo@vger.kernel.org
>> >>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-in=
fo.html
>> >>> >
>> >>> >
>> >>
>> >>
>> >
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
