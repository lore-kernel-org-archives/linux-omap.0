From: Paul Walmsley <paul@pwsan.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Tue, 31 Jan 2012 23:58:33 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201312324470.10061@utopia.booyaka.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com> <87obtlrniz.fsf@ti.com> <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com> <87obtkpyna.fsf@ti.com> <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
 <CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com> <alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com> <CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com> <alpine.DEB.2.00.1201312237410.10061@utopia.booyaka.com>
 <20120201172100.0e958f8a@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57348 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab2BAG6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 01:58:34 -0500
In-Reply-To: <20120201172100.0e958f8a@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Wed, 1 Feb 2012, NeilBrown wrote:

> On Tue, 31 Jan 2012 22:47:32 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> > Let me also answer the question from the MPU's perspective.  Suppose the 
> > MPU powerdomain has entered a low power state.  That means that the MPU 
> > INTC -- part of the MPU powerdomain -- is also in a low power state. 
> 
> My TRM says - in section 12.3.1.3 Power Management
> 
>     The MPU subsystem INTC belongs to the CORE power domain.
> 
> This is:
> 
>       AM/DM37x Multimedia Device
>       Silicon Revision 1.x
>       Version N
> 
> Is it wrong, are you wrong, or am I confused?

Hmm.  Since section 3.3.2.1 "Power Domains" mentions this too, and refers 
to CORE_RST, I suspect you and the TRM are right.  

So, for the moment, let's strike that second paragraph that I wrote about 
MPU wakeups.  I need to doublecheck with some other sources about exactly 
where the MPU INTC's clock comes from when the MPU clockdomain is idle.


- Paul
