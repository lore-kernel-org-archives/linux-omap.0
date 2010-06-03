From: mark gross <640e9920@gmail.com>
Subject: Re: [linux-pm] [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
 Suspend block api (version 8)
Date: Thu, 3 Jun 2010 06:36:46 -0700
Message-ID: <20100603133646.GF15595@gvim.org>
References: <20100601113309.609349fd@notabene.brown>
 <alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
 <20100601122012.1edeaf48@notabene.brown>
 <alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
 <20100602153235.340a7852@notabene.brown>
 <AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
 <20100602180614.729246ea@notabene.brown>
 <AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
 <20100603060444.GF11311@gvim.org>
 <AANLkTilml9GM2GmJhlB39oqDk6oPnLSSfiQAinpCpAbt@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:49191 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab0FCNge (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 09:36:34 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilml9GM2GmJhlB39oqDk6oPnLSSfiQAinpCpAbt@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: markgross@thegnar.org, Neil Brown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, Jun 02, 2010 at 11:12:39PM -0700, Brian Swetland wrote:
> On Wed, Jun 2, 2010 at 11:04 PM, mark gross <640e9920@gmail.com> wrote:
> >>
> >> There are many wakeup events possible in a typical system --
> >> keypresses or other input events, network traffic, telephony events,
> >> media events (fill audio buffer, fill video decoder buffer, etc), and
> >> I think requiring that all wakeup event processing bottleneck through
> >> a single userspace process is non-optimal here.
> >
> > Um doesn't the android framework bottleneck the user mode lock
> > processing through the powermanager and any wake up event processing
> > eventually has to grab a lock through this bottleneck anyway?
> 
> For "high level" framework/application level wakelocks, yes, but lower
> level components beneath the java api layer use the kernel interface
> directly.
>
Oh.  I thought everything went through
hardware/libhardware_legacy/power/power.c 
who else is hitting /sys/power/* in the android user mode then? 

I'll have to go hunting for them I guess.

--mgross
 
