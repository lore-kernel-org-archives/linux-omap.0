From: Falempe Jocelyn <jocelyn.falempe@motorola.com>
Subject: Re: New feature proposal "quickwakeup"
Date: Mon, 09 Nov 2009 15:20:41 +0100
Message-ID: <1257776441.4904.541.camel@xhp836-11>
References: <1257523241.1318.367.camel@xhp836-11>
	 <20091106170321.GA24312@srcf.ucam.org> <1257529341.2528.21.camel@xhp836-11>
	 <20091106180915.GA25582@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091106180915.GA25582@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2009-11-06 at 18:09 +0000, Matthew Garrett wrote:
> On Fri, Nov 06, 2009 at 06:42:21PM +0100, Falempe Jocelyn wrote:
> 
> > In fact we are doing "retention" in idle and with the suspend path. It's
> > specific to Android, with the global suspend and wakelock framework.
> > When all wakelocks are released (ie screen is black, no running app),
> > the phone goes to suspend, which freeze userspace and also suspend the
> > device driver. This way you can choose the wakeup sources, and stay in
> > suspend during a long time (a few hours). Without this, you have to
> > track down all user space app that wakeup the phone, and it is hard to
> > sleep more than a few second.
> 
> What's triggering the application wakeups? If it's just timeouts, can't 
> you simply adjust the range timer slop so that the timeouts don't fire?

yes that's a good point. I think google chose the suspend way also
because it synchronize filesystem, and some driver can enter deeper
sleep, knowing that the user won't notice the increased latency. it
protects also the phone against a crashed/bad app that would eat 100%
cpu always.

> 
> > The drawback is that when you want to wakeup, it takes a lot of time to
> > unfreeze the userspace, and resume all the device driver. This is what
> > this feature address (for low-level wakeup only).
> > But as this patch is not Android specific, I think other platforms may
> > use it too.
> 
> Yeah, I can certainly see the appeal if you have that constraint.
> 

