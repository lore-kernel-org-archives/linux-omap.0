From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: drivers that require headers in mach-omap
Date: Fri, 31 Jul 2009 10:42:50 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F58507F8@dbde02.ent.ti.com>
References: <8bb80c380907281849i1cd271f3n64a391327cd8bb5e@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F58506D2@dbde02.ent.ti.com>
 <8bb80c380907301620g5761ae36j55bec6747e32657a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55373 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbZGaFNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 01:13:04 -0400
In-Reply-To: <8bb80c380907301620g5761ae36j55bec6747e32657a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Mike Chan [mailto:mike@android.com]
>Sent: Thursday, July 30, 2009 6:20 PM
>To: Pandita, Vikram
>Cc: Kevin Hilman; linux-omap@vger.kernel.org
>Subject: Re: drivers that require headers in mach-omap
>
>On Thu, Jul 30, 2009 at 8:44 AM, Pandita, Vikram<vikram.pandita@ti.com=
> wrote:
>>
>>>-----Original Message-----
>>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger=
=2Ekernel.org] On Behalf Of Mike
>>>Chan
>>>Sent: Tuesday, July 28, 2009 8:49 PM
>>>To: Kevin Hilman; linux-omap@vger.kernel.org
>>>Subject: drivers that require headers in mach-omap
>>>
>>>Omap folks, how are drivers that require access to prm and cm
>>>registers via cm_read_mod_reg() etc... suppose to access these?
>>>
>>>For example if drivers/usb/host/ohci-omap.c wanted to call:
>>>cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_IDLEST);
>>
>> The design was supposed to encapsulate the PRCM API's from drivers.
>> Driver has control over the iclk and fclk and the clock framework wo=
uld take care of any CM/PRM
>register settings.
>>
>> Accessing these registers in drivers would make the driver non-compa=
tible for non-omap platforms.
>>
>
>Are drivers such as
>
>drivers/usb/host/ohci-omap.c
>drivers/usb/musb/omap2430.c
>
>suppose to be compatible for non-omap platforms?

As you put it, no they are not.
All PRM/CM register accesses have been restricted to mach-omap2/plat-om=
ap parts till now.
The question to ask is, what functionality is missing on enabling say t=
he usbhost clock that clock framework is not doing, that driver has a n=
eed to do.

>
>-- Mike
>
>>>
>>>It seems some of the headers in mach-omap2 should be in
>>>plat-omap/include/mach, or is there a more elegant way? The other
>>>alternatives are to register calls in all the board files, or #inclu=
de
>>>../../.. both do not seem very elegant to me.
>>>
>>>-- Mike
>>>--
>>>To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
