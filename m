From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
Date: Tue, 17 Jan 2012 15:45:48 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1201171536470.2722@xanadu.home>
References: <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <20120117162720.GG11475@arm.com>
 <CAMQu2gyCcGYk0tC_g2R9+OBYCvwupcjuUkRC5JxJ7maAVTs1YA@mail.gmail.com>
 <alpine.LFD.2.02.1201171425060.2722@xanadu.home>
 <CAMQu2gwjOuGadqsGqcpHvdH-Jhhj6cchyoZJMMsOQ20SXsKDOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_pszbcbtKw0KjB2t0x3nGWg)"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:36799 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab2AQUpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jan 2012 15:45:49 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LXY007EDN01SJ40@VL-VM-MR005.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 17 Jan 2012 15:45:37 -0500 (EST)
In-reply-to: <CAMQu2gwjOuGadqsGqcpHvdH-Jhhj6cchyoZJMMsOQ20SXsKDOw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_pszbcbtKw0KjB2t0x3nGWg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 17 Jan 2012, Shilimkar, Santosh wrote:

> On Tue, Jan 17, 2012 at 8:39 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 17 Jan 2012, Shilimkar, Santosh wrote:
> >
> >> How about allowing platform hooks for single SOC builds. I mean having
> >> this code under !single_zImage or something like that. That way we don't
> >> impact the single zImage efforts and also allow socs to have all those
> >> critical, vital bits enabled for the SOC specific builds.
> >
> > Absolutely not!  Because if we start doing that, people will get lazy
> > and no platform will ever work in a multi-SOC kernel.
> >
> > If your SOC require some fancy setup that is not shared by other
> > platforms then please abstract that into the bootloader, or make sure it
> > can be deferred later on.
> >
> There is nothing fancy here. It's an ARM security architecture feature which
> OMAP implements. Have given enough reason about boot-loaders issues.

I was not convinced by those reasons. Just push harder on the bootloader 
side.  There is _no_ reason for the bootloader not to take care of this 
very platform specific issue.  You can even do it into a standalone 
uImage that returns to u-Boot after it is done with its magic.

> Is OMAP getting beaten up here just because it uses ARM security
> feature and implements it's mechanics?

I don't care if this is OMAP, UX500 or i.MX.  There is a line to be 
drawn and this is just too bad if you are trying to cross it.


Nicolas

--Boundary_(ID_pszbcbtKw0KjB2t0x3nGWg)--
