From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: New feature proposal "quickwakeup"
Date: Fri, 6 Nov 2009 18:09:15 +0000
Message-ID: <20091106180915.GA25582@srcf.ucam.org>
References: <1257523241.1318.367.camel@xhp836-11> <20091106170321.GA24312@srcf.ucam.org> <1257529341.2528.21.camel@xhp836-11>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1257529341.2528.21.camel@xhp836-11>
Sender: linux-acpi-owner@vger.kernel.org
To: Falempe Jocelyn <jocelyn.falempe@motorola.com>
Cc: linux-acpi@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 06, 2009 at 06:42:21PM +0100, Falempe Jocelyn wrote:

> In fact we are doing "retention" in idle and with the suspend path. It's
> specific to Android, with the global suspend and wakelock framework.
> When all wakelocks are released (ie screen is black, no running app),
> the phone goes to suspend, which freeze userspace and also suspend the
> device driver. This way you can choose the wakeup sources, and stay in
> suspend during a long time (a few hours). Without this, you have to
> track down all user space app that wakeup the phone, and it is hard to
> sleep more than a few second.

What's triggering the application wakeups? If it's just timeouts, can't 
you simply adjust the range timer slop so that the timeouts don't fire?

> The drawback is that when you want to wakeup, it takes a lot of time to
> unfreeze the userspace, and resume all the device driver. This is what
> this feature address (for low-level wakeup only).
> But as this patch is not Android specific, I think other platforms may
> use it too.

Yeah, I can certainly see the appeal if you have that constraint.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
