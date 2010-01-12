From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Interval value set in RXINTERVAL register of MUSB?
Date: Tue, 12 Jan 2010 18:16:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A398821@dbde02.ent.ti.com>
References: <c27069991001120152h7085aa5cu29121f12791f28aa@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044A3987C7@dbde02.ent.ti.com>
 <c27069991001120441s27b789fdjc91c437473f130ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48676 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab0ALMrF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 07:47:05 -0500
In-Reply-To: <c27069991001120441s27b789fdjc91c437473f130ef@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jung songtan <jungsongtan@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: jung songtan [mailto:jungsongtan@gmail.com]
> Sent: Tuesday, January 12, 2010 6:11 PM
> To: Gupta, Ajay Kumar
> Cc: linux-omap@vger.kernel.org; jungsongtan
> Subject: Re: Interval value set in RXINTERVAL register of MUSB?
> 
> > Interval=2 for a low speed device means Host would issue > one IN tokens
> > to get data on Interrupt IN pipe after every 2-frames
> > (2ms or 16 micro frames).
> 
> So, if the device always NAK, the host will always Tokenning IN ,and
> occupy the End point and if the software did not stop it manually?
> 
> Now, question is if another transaction depending on this Endpoint, it
> will never occur if the Endpoint has been occupied, right? if so, how
> to deal with Two or more interrupt transaction depending on One
> Endpoint, any suggestion?

What data are you using for Interrupt transfer? Do you really
Need the interval to be =2 ? As device is NAKing it means, it's
Not ready with data so you can try some larger interval value
Say, =32 frames etc.

> 
> 
> > We get NAK timeout error interrupt only in BULK transfers > case. Please
> > See the details of RxInterval register.
> 
> Yes, the datasheet shows that.
> 
> 2010/1/12, Gupta, Ajay Kumar <ajay.gupta@ti.com>:
> >> -----Original Message-----
> >> From: jung songtan [mailto:jungsongtan@gmail.com]
> >> Sent: Tuesday, January 12, 2010 3:22 PM
> >> To: Gupta, Ajay Kumar; linux-omap@vger.kernel.org
> >> Subject: Interval value set in RXINTERVAL register of MUSB?
> >>
> >> Hi Ajay and expert,
> >>
> >> Can you correct me if my understanding has something wrong?
> >>
> >>
> >> [Quote from usb 2.0 spec]
> >> For full-/low-speed interrupt endpoints, the value of this field may
> >> be from 1 to 255.
> >> [Quote from usb 2.0 spec]
> >>
> >> So, If a Low speed Interrupt IN endpoint, the endpoint->interval = 0x2.
> >> Now I want to request data from the endpoint, I set RXINTERVAL = 0x2,
> >> and start to request the data.(All the related register set as bellow)
> >
> >> If my understanding is correctly, one NAKTIMEOUT interrupt will happen
> >> if the device responses NAK longer time than 2 frame, rigtht?
> >
> > Interval=2 for a low speed device means Host would issue one IN tokens
> > to get data on Interrupt IN pipe after every 2-frames
> > (2ms or 16 micro frames).
> >
> > We get NAK timeout error interrupt only in BULK transfers case. Please
> > See the details of RxInterval register.
> >
> > -Ajay
> >>
> >> But in my case did not, the host pending on the request for the data,
> >> and no TIMEOUT interrupt happen , can you tell me, where I am missed
> >> or where am I wrong?
> >>
> >> [Registers value ]
> >>
> >>  RXCSR            0x20
> >>  RXFUNCADDR 0x4
> >>  RXHUBADDR   0x2
> >>  RXHUBPORT   0x4
> >>  RXMAXP          0x4
> >>  RXINTERVAL   0x2
> >>
> >> [Registers value ]
> >> Thanks in advance,
> >>
> >>
> >>
> >> --
> >> K T Jung
> >
> 
> 
> --
> K T Jung
