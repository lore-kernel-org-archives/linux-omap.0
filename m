From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] serial: 8250: add IRQ trigger support
Date: Mon, 22 Jun 2009 18:54:45 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F54618F0@dbde02.ent.ti.com>
References: <1244827971-14981-1-git-send-email-vikram.pandita@ti.com>
	<20090612213127.0f03e0c5@taxman.wild-wind.fr.eu.org>
	<20090622124037.GD7352@atomide.com>
 <20090622142402.5e36e7fd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20090622142402.5e36e7fd@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Marc Zyngier <maz@misterjones.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org



>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>Sent: Monday, June 22, 2009 8:24 AM
>To: Tony Lindgren
>Cc: Marc Zyngier; Pandita, Vikram; linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>omap@vger.kernel.org; linux-arm-kernel@lists.arm.linux.org.uk
>Subject: Re: [PATCH] serial: 8250: add IRQ trigger support
>
>> To me it sounds like the it would be better to have unsigned
>> long irqflags in struct uart_port instead of trying to squeeze
>> the irqflags the flags field. We're already not covering all the
>> irqflags currently like Marc pointed out.
>
>Agreed.

I can post a patch with new irqflags in uart_port.
Expect a patch today.

>
>Alan

