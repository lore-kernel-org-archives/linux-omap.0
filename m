From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [linux-pm] [PATCH 0/8]
 Suspend block api (version 8)
Date: Thu, 3 Jun 2010 03:27:46 +0200
Message-ID: <20100603032746.014f5c07@schatten.dmk.lab>
References: <20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
	<AANLkTimISbs4X2YR_Pal9A80mpkNyCy8laWBcOgR2Cl7@mail.gmail.com>
	<20100602210224.6ae2333f@notabene.brown>
	<20100602210521.54b9cd9b@schatten.dmk.lab>
	<20100602233243.GA27666@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100602233243.GA27666@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Neil Brown <neilb@suse.de>, Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-omap@vger.kernel.org

On Wed, 2 Jun 2010 16:32:44 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Wed, Jun 02, 2010 at 09:05:21PM +0200, Florian Mickler wrote:
> > On Wed, 2 Jun 2010 21:02:24 +1000
> > Neil Brown <neilb@suse.de> wrote:
> > > 
> > > And this decision (to block suspend) really needs to be made in the driver,
> > > not in userspace?
> > 
> > Well, it fits. The requirement is a direct consequence of the intimate
> > knowledge the driver has about the driven devices.
> 
> That is not really true. A driver does have intimate knowledge of the
> device, however it does not necessarily have an idea about the data read
> from the device. Consider the gpio_matrix driver: Arve says that it has
> to continue scanning matrix once first interrupt arrvies. But it really
> depends on what key has been pressed - if user pressed KEY_SUSPEND or
> KEY_POWER it cmight be better if we did not wait for key release but
> initiated the action right away. The decision on how system reacts to a
> key press does not belong to the driver but really to userspace.
>  

I can't follow the gpio_matrix_driver example, but your point is
obviously true. 
A device should never register a constraint because of the data it
handles. That belongs into userspace. Or wherever the data is
consumed. 

I'm obviously not trying to say that a network driver should block
suspend while I'm on facebook. Or unblock when visiting m$.com. That
would be absurd. 

But, there are of course places in the kernel, where some kernel code
listens to data. For example the packet-filtering. Or sysrq-keys.
But I don't know how that relates to suspend_blockers now... ? 

Mind if I rephrase the quote?
From: "Well, it fits. The requirement is a direct consequence of the
intimate knowledge the driver has about the driven devices." 
To: "It fits, when the requirement is a direct consequence of the
intimate knowledge the driver has about the driven devices."

Cheers,
Flo

p.s.: tsss.... language... what a broken concept. And yet we have to
work with it.
