From: Florian Mickler <florian@mickler.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 23:52:57 +0200
Message-ID: <20100605235257.7d1329ec@schatten.dmk.lab>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<1275149418.4503.128.camel@mulgrave.site>
	<1275156734.1645.496.camel@laptop>
	<201005312314.12391.rjw@sisk.pl>
	<AANLkTil4DLUciWMVmCiiygS2Y1vLZu0Lnfys-w4q3L7W@mail.gmail.com>
	<20100605214939.49dd0ee0@schatten.dmk.lab>
	<AANLkTikp1Z9mGOaLf_oE_3qCL7U4oeHaPSp6zkp4eEfL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikp1Z9mGOaLf_oE_3qCL7U4oeHaPSp6zkp4eEfL@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>, tytso@mit.edu, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Sat, 5 Jun 2010 22:56:45 +0300
Felipe Contreras <felipe.contreras@gmail.com> wrote:

> On Sat, Jun 5, 2010 at 10:49 PM, Florian Mickler <florian@mickler.org> wrote:
> > On Sat, 5 Jun 2010 20:16:33 +0300
> > Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >> New users will see it has low score; they will not install it. That's
> >> a network effect.
> >>
> >> Having users is the quintessential reason people write code.
> >
> > That is nice. But how does it impact the problem that suspend blockers
> > solve? And why do suspend blockers interfere with that?
> 
> It doesn't, I don't know why people keep bringing this argument, I
> just though it should not be left open as a valid one.
> 
> I should have mentioned that this is indeed irrelevant.
> 

Uh! I found out how this is relevant to the suspend blockers case.
Because not having users means that the bugs don't get fixed.
Whereas in the suspend blockers case the users can use the app and get
the bugs fixed. 

Cheers,
Flo

p.s.: I really wished you would focus more on solving the
problem and not on dismissing it.
