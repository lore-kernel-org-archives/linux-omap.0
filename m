From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Function Profiler broken on today's linux-next
Date: Wed, 16 Jul 2014 13:24:13 -0400
Message-ID: <20140716132413.1ede8e1d@gandalf.local.home>
References: <20140716162328.GJ1365@saruman.home>
	<20140716122921.71b118a9@gandalf.local.home>
	<20140716164141.GA3016@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140716164141.GA3016@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: will.deacon@arm.com, mingo@redhat.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 16 Jul 2014 11:41:42 -0500
Felipe Balbi <balbi@ti.com> wrote:


> .config attached. It's actually an ARM platform, I can help out with
> testing anything you need.

In that case, can you see if it works under my repo?

git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
branch: ftrace/core

Thanks,

-- Steve
