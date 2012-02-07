From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Tue, 7 Feb 2012 01:13:04 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF734938ED1@DLEE10.ent.ti.com>
References: <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
	<20120203205401.5ddf241d@notabene.brown>
	<CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
	<alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
	<CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
	<20120204163931.GH1275@n2100.arm.linux.org.uk>
	<EF62F09C0797D947AD4180A1043C0DF734934E36@DLEE10.ent.ti.com>
	<20120205160329.GO1275@n2100.arm.linux.org.uk>
	<EF62F09C0797D947AD4180A1043C0DF734934E9D@DLEE10.ent.ti.com>
 <20120207105820.367361c5@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59306 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756548Ab2BGBNR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 20:13:17 -0500
In-Reply-To: <20120207105820.367361c5@notabene.brown>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> From: NeilBrown [mailto:neilb@suse.de]
> Sent: Monday, February 06, 2012 5:58 PM
> To: Woodruff, Richard

Apologies for mangled mails... I am years over due ditching current method.

> I don't think it is really OK to drop chars on the UART-to-Debug console.
> However it is OK to drop the BAUD rate to 57600 where we can wake up in
> time
> for to catch the first bit.  So if you want power saving, drop the console
> buad rate.
> 
> So I would suggest:
>  - remove the autosuspend timeouts
>  - allow runtime_pm to shutdown the device when it is not open, or when
>    rate is 57600 or below, or when 'CREAD' is clear
>  - keep runtime_pm active whenever there are bytes in the output queue or
>    fifo

Yes slower baud + use of flow control should help. OMAP4 is like 10x better than OMAP2 with OMAP3 in middle.

> The only case that wouldn't support is when a device will wake up the SOC
> by
> sending a non-break character which it is OK to receive corrupted.  The
> tty
> would have to be in !CREAD for that to happen, and then there would be no
> way
> for the app to know that a non-break character was received.
> Would it be reasonable to treat any input while CREAD is clear as a break?

Others would have to comment on this.  I never took this step as I was ok with degradation on debug console.

If ever I wanted better logs I tended to telnet/ssh in on a network port which was better at retry at higher level.

Regards,
Richard W.



