From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Function Profiler broken on today's linux-next
Date: Wed, 16 Jul 2014 12:29:21 -0400
Message-ID: <20140716122921.71b118a9@gandalf.local.home>
References: <20140716162328.GJ1365@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140716162328.GJ1365@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: will.deacon@arm.com, mingo@redhat.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 16 Jul 2014 11:23:28 -0500
Felipe Balbi <balbi@ti.com> wrote:

> Hi folks,
> 
> I was trying to use Kernel Function Profiler to figure out why my
> driver's IRQ handler is taking so much CPU time but to my surprise,
> whenever I try to trace anything, I get a "Unable to handle kernel
> paging request at virtual address XXXX" error.
> 
> Is anybody else seen that or did I screw up my Kernel config ?

No, it's probably my fault. The ftrace infrastructure is going through
an overhaul and some dramatic changes are happening. Although it has
passed all my tests, I can't cover everyone's configs and use cases.

Please send me your config and the steps you did to enable function
profiling. This is x86 correct? Other archs are already known to be
broken and I'm working on fixing them now.

-- Steve



> 
> cheers
> 
> ps: I have tried tracing a few different drivers and they all trigger
> the same problem.
> 
