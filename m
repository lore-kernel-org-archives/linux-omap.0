From: Paul Walmsley <paul@pwsan.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Mon, 30 Jan 2012 18:49:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201301848480.10061@utopia.booyaka.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com> <87obtlrniz.fsf@ti.com> <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com> <87obtkpyna.fsf@ti.com> <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
 <CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39228 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab2AaBtW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 20:49:22 -0500
In-Reply-To: <CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Tue, 31 Jan 2012, Grazvydas Ignotas wrote:

> On Tue, Jan 31, 2012 at 1:34 AM, Paul Walmsley <paul@pwsan.com> wrote:
> 
> > So apparently, looking at these references, the following registers should
> > be configured:
> >
> > 1. at least one of GPIO_LEVELDETECT{0,1} or GPIO_{RISING,FALLING}DETECT
> >
> > 2. GPIO_WAKEUPENABLE
> >
> > 3. GPIO_IRQENABLE1
> 
> According to some /dev/mem hacking, all these have corresponding bits
> set.

OK so that's good, something in the GPIO driver is setting those 
WAKEUPENABLE bits then :-)


- Paul
