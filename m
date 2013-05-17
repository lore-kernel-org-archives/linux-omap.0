From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: 3.9 regression : CAM_XCLKA wrong frequency setting.
Date: Fri, 17 May 2013 13:20:20 +0200
Message-ID: <CAGGh5h3BNV7fE3jC0KSmA+2K6zKwVyHdeo8AW0gvmhgQsy8ZEg@mail.gmail.com>
References: <CAGGh5h2RB7OEOpGOe52eE8+LgdSmvDK5rPLueMzQMfVfOCuYHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:49935 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3EQLUV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 07:20:21 -0400
Received: by mail-qc0-f177.google.com with SMTP id e1so1569773qcy.8
        for <linux-omap@vger.kernel.org>; Fri, 17 May 2013 04:20:20 -0700 (PDT)
In-Reply-To: <CAGGh5h2RB7OEOpGOe52eE8+LgdSmvDK5rPLueMzQMfVfOCuYHg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org

2013/5/17 jean-philippe francois <jp.francois@cynove.com>:
> Hi,
>
> Laurent, you are on the recipient list because the symptom is visible
> throug your driver. I found the other name looking in the clock
> related files. Please apologize if you are not concerned by this mail=
=2E
>
> Symptom :
> External clock CAM_XCLKA frequency is wrong with 3.9, it was ok until
> 3.6. Everything else is working fine, except the fps are higher, and
> the image quality sucks because the input clock is out of spec.
> Oscilloscope measured freq is around 30 MHz instead of the 24 MHz the
> sensor is asking for.
>
> Hardware :
> dm3730, with 19.2 MHz crystal, running at OPP100
>
> The register frequency settings seems to be ok, and they are the same
> as in 3.6.11 :
> CM_CLKSEL2_PLL : 0x04816807
>         19, 2 * 360 / 8 =3D 864 MHz
>          this value is already set when I look at it in u-boot
>
> CM_CLKSEL_CAM : 0x5
>         864 / 5 =3D 172,8 MHz
>         this value is set through the clock framework by the omap3isp
> driver code
>
> ISP.TCTRL_CTRL : 0x7
>         172,8 / 7 =3D 24,685... MHz
>          this value is set by the omap3isp driver code
>
> However, as stated before, the actual output frequency is NOT 24 MHz
> but around 30.
>
> If dpll4 frequency is wrong, what other clock would be affected ?

As usual, writing a mail brings up new idea. Sorry to use the lists
as rubber duck debug partner, but I still need your help.

Obviously, dpll4 frequency is correct, because it sources the 96 and
48 MHz clock.
I can check it measuring bit time on uart3tx : 8.6usec for 115200 =3D> =
Ok

30 MHz is 1.25 * 24 MHz
CM_CLKSEL_CAM reset value is 4, programmed value is 5,
So I did the following, while looking at CAM_XCLKA on scope :

# devmem 0x48004f40
0x00000005
# devmem 0x48004f40 32 5  -> freq =3D 30 MHz
# devmem 0x48004f40 32 4  -> freq =3D 30 MHz
# devmem 0x48004f40 32 5  -> freq =3D 24 MHz

So there is something nasty in the setup sequence of cam_mclk and dpll4=
_m5ckx2
that prevents the new divisor value to be used by the hardware.
I will dive into the code to see where things went wrong, but I am a
bit lost here.

> What can I do to debug this ?
> Laurent, I believe you have a camera add-on board for the beagle xm,
> could you test and report wether you can reproduce this bug ?
>
> Attached is the boot log with 3.9, with some debugging messages activ=
ated.
>
> Thank you for your help,
> Regards,
>
> Jean-Philippe Fran=C3=A7ois
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
