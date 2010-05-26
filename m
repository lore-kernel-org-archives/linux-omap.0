From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 19:22:16 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005261829540.2995@localhost.localdomain>
References: <20100526171106.0e44a736@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100526171106.0e44a736@schatten.dmk.lab>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Florian,

On Wed, 26 May 2010, Florian Mickler wrote:
>
> On the other hand, applications can say, they don't need that much
> power and userspace guaranties and not take a suspend blocker.
> 
> This is an option which they currently don't have.

Wrong. A well coded power aware application is very well able to
express that in various ways already today. Admittedly it's far from
perfect, but that can be fixed by adding interfaces which allow the
power aware coder to express the requirements of his application
actively, not by avoiding it.

suspend blockers are completely backwards as they basically disable
the kernels ability to do resource management.

Also they enforce a black and white scheme (suspend or run) on the
kernel which is stupid, as there are more options to efficiently save
power than those two. While current android devices might not provide
them, later hardware will have it and any atom based device has them
already.

So what the kernel needs to know to make better decisions are things
like:

  - how much slack can timers have (exisiting interface)
  - how much delay of wakeups is tolerated (missing interface)

and probably some others. That information would allow the kernel to
make better decisions versus power states, grouping timers, race to
idle and other things which influence the power consumption based on
the hardware you are running on.

> I don't think opportunistic suspend is a policy decision by the kernel.
> it is something new. Something which currently only the android
> userspace implements / supports. If you don't want to suspend while
> looking at the bouncing-cow, you have to take a suspend blocker and
> make yourself a user-visible power-eater, or don't do 
> 
> echo "opportunistic" > /sys/power/policy 
> 
> in the first place.
> 
> This "optionally being badly written, who cares?" is a new feature the
> kernel can provide to applications. 

It's a misfeature which the kernel should not provide at all. It sends
out the completely wrong message: Hey, we can deal with your crappy
code, keep on coding that way.

While this seems to sound cool to certain people in the mobile space,
it's completely backwards and will backfire in no time. 

The power efficiency of a mobile device is depending on a sane overall
software stack and not on the ability to mitigate crappy software in
some obscure way which is prone to malfunction and disappoint users.

Thanks,

	tglx
