From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: ARM: OMAP5/DRA7: Fix counter frequency drift for AM572x errata
 i856
Date: Fri, 12 Dec 2014 15:42:19 -0500
Message-ID: <20141212204219.GZ24110@csclub.uwaterloo.ca>
References: <20141211204116.GT24110@csclub.uwaterloo.ca>
 <20141211204308.GU24110@csclub.uwaterloo.ca>
 <548B27E5.4090108@ti.com>
 <20141212192303.GY24110@csclub.uwaterloo.ca>
 <20141212194001.GA30966@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141212194001.GA30966@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 12, 2014 at 01:40:01PM -0600, Nishanth Menon wrote:
> we try and avoid soc_is or cpu_is as much as possible and depend usually
> on compatible to mark the change..

Well you can't use the dtb really, since it depends on the chip revision
and how it started at power on.  After all if you purposely don't connect
a 32KHz crystal to save board space and cost, then you will also need this
"fix" to make time work properly, which is in fact what we will now be doing.

> k, thanks. lets go through your next rev to see if we can improve on the
> same. btw, nice catch :) - thanks for proposing a fix.

Well we have been trying to get the system time to run well and have ntp
happy for a few months now and it took the die designers quite a while
to track down the power on problem with the 32KHz crystal.  Unfortunately
the emulation using 20000000/610 is close enough that you don't notice
it unless you are looking at time keeping issues.  Of course if you try
any of the other SYSCLK1 options for the CPU then time goes totally wrong.
With a 19.2MHz crystal it was running almost 5% too slow which was
very noticeable.

-- 
Len Sorensen
