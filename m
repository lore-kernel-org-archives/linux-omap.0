From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH resend] video: omap24xxcam: Fix compilation
Date: Mon, 7 Feb 2011 08:15:13 -0800
Message-ID: <20110207081513.90c299ed.rdunlap@xenotime.net>
References: <1297068547-10635-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297068547-10635-1-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Hans Verkuil <hverkuil@xs4all.nl>, Tejun Heo <tj@kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon,  7 Feb 2011 09:49:07 +0100 Thomas Weber wrote:

> Add linux/sched.h because of missing declaration of TASK_NORMAL.
> 
> This patch fixes the following error:
> 
> drivers/media/video/omap24xxcam.c: In function
> 'omap24xxcam_vbq_complete':
> drivers/media/video/omap24xxcam.c:415: error: 'TASK_NORMAL' undeclared
> (first use in this function)
> drivers/media/video/omap24xxcam.c:415: error: (Each undeclared
> identifier is reported only once
> drivers/media/video/omap24xxcam.c:415: error: for each function it
> appears in.)
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  drivers/media/video/omap24xxcam.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Hi,

Please use media: or multimedia: or media/video: in the subject line,
not just video:.  video: traditionally is used for drivers/video/,
not drivers/media/video.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
