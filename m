From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Function Profiler broken on today's linux-next
Date: Wed, 16 Jul 2014 14:54:42 -0400
Message-ID: <20140716145442.15f25ec3@gandalf.local.home>
References: <20140716162328.GJ1365@saruman.home>
	<20140716122921.71b118a9@gandalf.local.home>
	<20140716164141.GA3016@saruman.home>
	<20140716132413.1ede8e1d@gandalf.local.home>
	<20140716182944.GK3016@saruman.home>
	<20140716184152.GM3016@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140716184152.GM3016@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: will.deacon@arm.com, mingo@redhat.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 16 Jul 2014 13:41:52 -0500
Felipe Balbi <balbi@ti.com> wrote:

> Hi,
> 
> On Wed, Jul 16, 2014 at 01:29:44PM -0500, Felipe Balbi wrote:
> > On Wed, Jul 16, 2014 at 01:24:13PM -0400, Steven Rostedt wrote:
> > > On Wed, 16 Jul 2014 11:41:42 -0500
> > > Felipe Balbi <balbi@ti.com> wrote:
> > > 
> > > 
> > > > .config attached. It's actually an ARM platform, I can help out with
> > > > testing anything you need.
> > > 
> > > In that case, can you see if it works under my repo?
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> > > branch: ftrace/core
> > 
> > works fine, thanks. FWIW
> > 
> > Tested-by: Felipe Balbi <balbi@ti.com>
> 
> Actually it seems like it's not counting time properly if I run my test
> multiple times in a row:
> 
> # /root/testusb -t 1 -c 100000 -s 2048 -a
> # head -3 trace_stat/function0
>   Function                         Hit    Time                Avg           s^2
>   --------                         ---    ----                ---           ---
>   thread_interrupt               174876    166120839 us     949.935 us  3048498 us
> 
> # /root/testusb -t 1 -c 100000 -s 2048 -a
> # head -3 trace_stat/function0
>   Function                           Hit       Time                    Avg          s^2
>   --------                           ---       ----                    ---          ---
>   dwc3_thread_interrupt            286796    967267300 us         4190545199 us     3241109 us 
> 
> # /root/testusb -t 1 -c 100000 -s 2048 -a
> # head -3 trace_stat/function0
>   Function                              Hit      Time                 Avg               s^2
>     --------                            ---       ----                 ---              ---
>   dwc3_thread_interrupt               401346    642632072 us       1601.192 us     1194316 us 
> 
> and so on...
> 

Did it use to work? In other words, is this a regression, or just some
another bug?

-- Steve
