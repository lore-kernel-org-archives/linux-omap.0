From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 21:04:05 +0200
Message-ID: <201006052104.05324.rjw@sisk.pl>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk> <20100531224732.2073828d@schatten.dmk.lab> <AANLkTinPUNer7XhAqS4VSWhOxqjEjaHtr76EK5tzYYjJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinPUNer7XhAqS4VSWhOxqjEjaHtr76EK5tzYYjJ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Arve =?utf-8?q?Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, tytso@mit.edu, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Saturday 05 June 2010, Felipe Contreras wrote:
> On Mon, May 31, 2010 at 11:47 PM, Florian Mickler <florian@mickler.org> wrote:
> > On Mon, 31 May 2010 22:12:19 +0200
> > Florian Mickler <florian@mickler.org> wrote:
> >> If I have a simple shell script then I don't wanna jump through
> >> hoops just to please your fragile kernel.
> >
> > Also why should that code on one device kill my uptime and on the
> > other machine (my wall-plugged desktop) work just well? That doesn't
> > sound right.
> 
> Sounds perfectly right to me; one code runs perfectly fine on one
> machine, and on the other doesn't even compile. Well, sure, it wasn't
> written with that use-case in mind.
> 
> > Clearly opportunistic suspend is a workaround for battery-driven devices
> > and no general solution. But it is not specific to android. At least
> > not inherently. It could be useful for any embedded or mobile device
> > where you can clearly distinguish important functions from convenience
> > functions.
> 
> Yes, it could, but why go for the hacky solution when we know how to
> achieve the ideal one?
> 
> > I really can't understand the whole _fundamental_ opposition to this
> > design choice.
> 
> Nobody is using it, except Android. Nobody will use it, except Android.

That's like saying "Android is not a legitimate user of the kernel".  Is that
you wanted to say?

> I have seen recent proposals that don't require changing the whole
> user-space. That might actually be used by other players.

Sure, an approach benefitting more platforms than just Android would be better,
but saying that the kernel shouldn't address the Android's specific needs as a
rule if no one else has those needs too is quite too far reaching to me.

Rafael
