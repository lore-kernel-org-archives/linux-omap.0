From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: [Fwd: Re: [PATCH] i2c: omap: highspeed only over 1000mhz]
Date: Mon, 20 Oct 2008 08:27:50 -0500
Message-ID: <48FC8756.8060807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:9872 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbYJTN1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 09:27:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so87021and.103
        for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 06:27:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dist- Linux-OMAP-vger <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

Looping in list. my html mail bounced :(

-------- Original Message --------
Subject: 	Re: [PATCH] i2c: omap: highspeed only over 1000mhz
Date: 	Mon, 20 Oct 2008 08:18:20 -0500
=46rom: 	Nishanth Menon <menon.nishanth@gmail.com>
To: 	felipe.balbi@nokia.com
CC: 	linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Tony
Lindgren <tony@atomide.com>
References: 	<1224277795-17143-1-git-send-email-felipe.balbi@nokia.com>
<20081020102659.GA31599@gandalf.research.nokia.com>
<48FC7CA9.4040102@gmail.com>
<20081020125355.GC31599@gandalf.research.nokia.com>



=46elipe Balbi said the following on 10/20/2008 07:53 AM:
> On Mon, Oct 20, 2008 at 07:42:17AM -0500, ext Nishanth Menon wrote:
>  =20
>> Felipe,
>> Felipe Balbi said the following on 10/20/2008 05:26 AM:
>>    =20
>>> up to 1000khz it's Fast Mode+, not highspeed.
>>>
>>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>>> ---
>>>  drivers/i2c/busses/i2c-omap.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c=
-omap.c
>>> index a999606..53d6244 100644
>>> --- a/drivers/i2c/busses/i2c-omap.c
>>> +++ b/drivers/i2c/busses/i2c-omap.c
>>> @@ -296,7 +296,7 @@ static int omap_i2c_init(struct omap_i2c_dev *d=
ev)
>>>  		psc =3D psc - 1;
>>> =20
>>>  		/* If configured for High Speed */
>>> -		if (dev->speed > 400) {
>>> +		if (dev->speed > 1000) {
>>>  =20
>>>      =20
>> Ref: http://www.nxp.com/acrobat_download/literature/9398/39340011.pd=
f
>> Page 4:
>> "Serial, 8-bit oriented, bi-directional data transfers can be
>> made at *up to* 100 kbit/s in the Standard-mode, *up to*
>> 400 kbit/s in the Fast-mode, or *up to* 3.4 Mbit/s in the
>> High-speed mode"
>>
>> Why do say high speed is >1000khz?
>>    =20
>
> http://www.standardics.nxp.com/support/documents/i2c/pdf/i2c.bus.spec=
ification.pdf
>
> section 5.2:
>
> "Fast-mode Plus (Fm+) devices offer an increase in I2C-bus transfer s=
peeds and total bus
> capacitance. Fm+ devices can transfer information at bit rates of up =
to 1 Mbit/s, yet they
> remain fully downward compatible with Fast- or Standard-mode devices =
for bidirectional
> communication in a mixed-speed bus system. The same serial bus protoc=
ol and data
> format is maintained as with the Fast- or Standard-mode system. Fm+ d=
evices also offer
> increased drive current over Fast- or Standard-mode devices allowing =
them to drive
> longer and/or more heavily loaded buses so that bus buffers do not ne=
ed
> to be used"
>
>  =20
Aaah, rev 3 of the spec! However, OMAP TRM says:
"  three multimaster HS I2C controllers have the following features:
=E2=80=A2 Compliance with Philips I2C specification version 2.1
"

So does this change make sense? FM+ devices might actually be confusing
the OMAP3430?
Regards,
Nishanth Menon

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
