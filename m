From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH resend] video: omap24xxcam: Fix compilation
Date: Tue, 15 Feb 2011 13:53:49 +0200
Message-ID: <20110215115349.GQ2570@legolas.emea.dhcp.ti.com>
References: <1297068547-10635-1-git-send-email-weber@corscience.de>
 <4D5A6353.7040907@maxwell.research.nokia.com>
 <20110215113717.GN2570@legolas.emea.dhcp.ti.com>
 <4D5A672A.7040000@samsung.com>
 <4D5A6874.1080705@corscience.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D5A6874.1080705@corscience.de>
Sender: linux-media-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, balbi@ti.com, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, linux-omap@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Hans Verkuil <hverkuil@xs4all.nl>, Tejun Heo <tj@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Feb 15, 2011 at 12:50:12PM +0100, Thomas Weber wrote:
> Hello Felipe,
> 
> in include/linux/wait.h
> 
> #define wake_up(x)            __wake_up(x, TASK_NORMAL, 1, NULL)

aha, now I get it, so shouldn't the real fix be including <linux/sched.h>
on <linux/wait.h>, I mean, it's <linuux/wait.h> who uses a symbol
defined in <linux/sched.h>, right ?

-- 
balbi
