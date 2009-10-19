From: Ameya Palande <2ameya@gmail.com>
Subject: Re: stable kernel version
Date: Mon, 19 Oct 2009 20:28:59 +0300
Message-ID: <269694c00910191028x7e9499cas6e6f51b75fa15710@mail.gmail.com>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com>
	 <4AD60CEE.8000204@tzi.de> <20091014193324.GK12700@atomide.com>
	 <4AD88BBD.9010602@tzi.de> <20091016154051.GE12576@atomide.com>
	 <4ADC7476.9090208@tzi.de>
	 <FCCFB4CDC6E5564B9182F639FC35608702FA174DCE@dbde02.ent.ti.com>
	 <4ADC9470.4080403@tzi.de>
	 <A24693684029E5489D1D202277BE89444CFD937C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:50833 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbZJSR2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 13:28:55 -0400
Received: by gv-out-0910.google.com with SMTP id r4so441776gve.37
        for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 10:28:59 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE89444CFD937C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Maldonado Zambrano, Ivan" <ivan.maldonado@ti.com>
Cc: Janosch Machowinski <scotch@tzi.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Does this commit fixes the issue?

[v2] usb: musb: Warn and check for OTG transceiver misconfiguration

Warn if OTG is selected in Kconfig but not initialized by platform code=
=2E
Add checks to prevent NULL pointer exception in case the
OTG transceiver has not been initialized. i.e. musb->xceiv =3D=3D NULL

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 drivers/usb/musb/musb_core.c |    7 ++++++-
 drivers/usb/musb/omap2430.c  |    3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

Link: http://patchwork.kernel.org/patch/32914/

Cheers,
Ameya.

On Mon, Oct 19, 2009 at 8:19 PM, Maldonado Zambrano, Ivan
<ivan.maldonado@ti.com> wrote:
> Hi Machowinski,
>
> Enabling TWL4030 USB Transceiver Driver on your menuconfig the issue =
that you mentioned on a log file attached on previous mails is correcte=
d. I had the same problem. Like an introduction, my name is Ivan Maldon=
ado Zambrano and I'm working on USB tests for zoom3 and sdp. Attached m=
y log file, if you compare with yours is the same problem.
>
> Regards
> Maldonado Zambrano, Ivan
> x0109876@ti.com
> Project L23x3630.
>
>
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.=
kernel.org] On Behalf Of Janosch Machowinski
> Sent: Monday, October 19, 2009 11:32 AM
> To: linux-omap@vger.kernel.org
> Subject: Re: stable kernel version
>
> Pandita, Vikram schrieb:
>> Here's the problem:
>> <3>HS USB OTG: no transceiver configured
>> <3>musb_hdrc musb_hdrc: musb_init_controller failed with status -19
>>
>> Depending on your board, you will have to define the transceiver for=
 MUSB.
>> It could be TWL4030 or NO-transceiver...
>>
> I got an Gumstix Overo Earth so which one would it be then ?
>
> I tried one kernel, with only NOOP,
> and one with all three options enabled,
> same result any time (crash).
>> Drivers -> USB -> (last options) *** OTG and related infrastructure =
***
>>
>> Or do u want to disable USB to start with !!
>>
> Actually USB is the feature why I started compiling a new kernel
> in the fist place ;-)
>
>
> Regards
> =C2=A0 =C2=A0Janosch
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
