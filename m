From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Naming convention used in mux.c
Date: Thu, 29 Jan 2009 22:29:13 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA7901AE@dbde02.ent.ti.com>
References: <1f11a5490901290745i6791571sdf905d26ba666c64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53913 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbZA2Q7T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 11:59:19 -0500
In-Reply-To: <1f11a5490901290745i6791571sdf905d26ba666c64@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks Ashwin, I got it.

But I would recommend to have some kind of comment in mux.c which will =
mention this.

Thanks,
Vaibhav Hiremath
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927
________________________________________
=46rom: Ashwin Bihari [mailto:abihari@gmail.com]=20
Sent: Thursday, January 29, 2009 9:16 PM
To: Hiremath, Vaibhav
Cc: linux-omap@vger.kernel.org
Subject: Re: Naming convention used in mux.c

Vaibhav,

I was also confused by that when I began playing with the OMAP and only=
 found those references to make sense when I looked at the schematics o=
f the board I'm working on. If you look at the Terminal Pin documents f=
or your specific OMAP you will see the alphabet and numbers make sense.=
 But you need to know which alphabet/number specifically is designated =
to a particular function and this is something the hardware engineer wo=
uld do while connecting the OMAP to the rest of the peripherals on the =
board.

Regards

-- Ashwin

On Thu, Jan 29, 2009 at 10:34 AM, Hiremath, Vaibhav <hvaibhav@ti.com> w=
rote:
Hi,

Can anybody tell me the meaning of naming convention used in mux.c file=
, e.g. -

MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)

What the suffix "AH8_" and "J25_" means here? I looked into TRM and cou=
ld not able to co-relate with any meaningful?

Thanks,
Vaibhav Hiremath
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
