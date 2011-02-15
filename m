From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: [PATCH resend] video: omap24xxcam: Fix compilation
Date: Tue, 15 Feb 2011 13:28:19 +0200
Message-ID: <4D5A6353.7040907@maxwell.research.nokia.com>
References: <1297068547-10635-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297068547-10635-1-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Hans Verkuil <hverkuil@xs4all.nl>, Tejun Heo <tj@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Thomas Weber wrote:
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

Thanks, Thomas!

Acked-by: Sakari Ailus <sakari.ailus@iki.fi>

> ---
>  drivers/media/video/omap24xxcam.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
> index 0175527..f6626e8 100644
> --- a/drivers/media/video/omap24xxcam.c
> +++ b/drivers/media/video/omap24xxcam.c
> @@ -36,6 +36,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/sched.h>
>  
>  #include <media/v4l2-common.h>
>  #include <media/v4l2-ioctl.h>


-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
