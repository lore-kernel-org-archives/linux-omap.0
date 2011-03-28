From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or missing MAC
 addresses for eth0 and wlan0
Date: Mon, 28 Mar 2011 08:54:24 -0400
Message-ID: <AANLkTikgyuZaP=MMSYPpGz98CnJNLteEi_P7HsN-qkO7@mail.gmail.com>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>
	<20110324212737.14936.21228.stgit@otae.warmcat.com>
	<78b7faad4cdc37c6b507c008fde18ef3@mail.gmail.com>
	<AANLkTineUsH=Qz83YKJy8YZ1KSE1si-RddQ9eBsPjMdk@mail.gmail.com>
	<alpine.LFD.2.00.1103251615380.11889@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59438 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab1C1My0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 08:54:26 -0400
Received: by vxi39 with SMTP id 39so2222182vxi.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 05:54:25 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1103251615380.11889@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Hema Kalliguddi <hemahk@ti.com>, Andy Green <andy@warmcat.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, arnd@arndb.de, David Anders <x0132446@ti.com>, Sebastien Jan <s-jan@ti.com>, tony@atomide.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Green <andy.green@linaro.org>

On Fri, Mar 25, 2011 at 4:23 PM, Nicolas Pitre <nicolas.pitre@linaro.or=
g> wrote:
> On Fri, 25 Mar 2011, Jason Kridner wrote:
>
>> I very much like this approach. =A0I believed the ability to use the=
 die
>> ID to get a unique code was reasonable approach and that is why I
>> didn't get an EEPROM put onto the BeagleBoard, though Gerald is
>> looking at adding one on a future revision because the lack of one
>> wasn't well received. =A0Minor questions below.
>
> If this code had been available and/or the procedure well documented
> before then I believe the reception would have been better.

Understood.  Live and learn and try not to repeat the same mistakes.
Hopefully others pick up on this one.

>
>> The use of the OMAP die id below makes this OMAP specific and the li=
st
>> referenced below of the devices to be referenced makes it Panda
>> specific. =A0Is there a way to make the list board specific, but to =
make
>> these functions that will be used across many OMAP platforms reusabl=
e?
>> =A0I believe that this current code will result in a lot of
>> cut-and-paste. =A0My preference is that this is accepted and that we
>> make this more general when we add this to other OMAP platforms, but
>> it'd be great to capture your suggestions on how to do so before tho=
se
>> cut-and-paste patch sets start coming in.
>
> It is true that this might get copied. =A0But as I suggested to Andy,=
 it
> is best to wait and see how often this happens before generalizing th=
e
> approach. =A0Consolidation is easier when you can see what is actuall=
y
> common and what is board specific. =A0Otherwise it is easy to
> fall into the over-engineering trap.

Makes sense.  I hope to see this patch accepted for Panda quickly and
we can follow Andy's advice on how to make it more general in the
future as we wee how people use/need it.

>
>
> Nicolas
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
