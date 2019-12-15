From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] w1: omap-hdq: Simplify driver with PM runtime
 autosuspend
Date: Sun, 15 Dec 2019 23:03:31 +0100
Message-ID: <20191215230331.645b9064@aktux>
References: <20191215173817.47918-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191215173817.47918-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Evgeniy Polyakov <zbr@ioremap.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, "Andrew F . Davis" <afd@ti.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sun, 15 Dec 2019 09:38:17 -0800
Tony Lindgren <tony@atomide.com> wrote:

> We've had generic code handling module sysconfig and OCP reset registers
> for omap variants for many years now and all the drivers really needs to
> do is just call runtime PM functions.
> 
> Looks like the omap-hdq driver got only partially updated over the years
> to use runtime PM, and still has lots of custom PM code left.
> 
> We can replace all the custom code for sysconfig, OCP reset, and PM with
> just a few lines of runtime PM autosuspend code.
> 
> Note that the earlier driver specific usage count limit of four seems
> completely artificial and should not be an issue in normal use.
> 
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Andreas Kemnade <andreas@kemnade.info>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> 
> Can you guys please review and and test on gta04 and torpedo?
> 
[...]
>  
> -static int _omap_hdq_reset(struct hdq_data *hdq_data)
> -{
> -	int ret;
> -	u8 tmp_status;
> -
> -	hdq_reg_out(hdq_data, OMAP_HDQ_SYSCONFIG,
> -		    OMAP_HDQ_SYSCONFIG_SOFTRESET);
> -	/*
> -	 * Select HDQ/1W mode & enable clocks.
> -	 * It is observed that INT flags can't be cleared via a read and GO/INIT
> -	 * won't return to zero if interrupt is disabled. So we always enable
> -	 * interrupt.
> -	 */

If I remember correctly this thing is critical to get the hwmod out of
reset but I need to examine that again:

> -	hdq_reg_out(hdq_data, OMAP_HDQ_CTRL_STATUS,
> -		OMAP_HDQ_CTRL_STATUS_CLOCKENABLE |
> -		OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK);
> -
> -	/* wait for reset to complete */
> -	ret = hdq_wait_for_flag(hdq_data, OMAP_HDQ_SYSSTATUS,
> -		OMAP_HDQ_SYSSTATUS_RESETDONE, OMAP_HDQ_FLAG_SET, &tmp_status);
> -	if (ret)
> -		dev_dbg(hdq_data->dev, "timeout waiting HDQ reset, %x",
> -				tmp_status);
> -	else {
> -		hdq_reg_out(hdq_data, OMAP_HDQ_CTRL_STATUS,
> -			OMAP_HDQ_CTRL_STATUS_CLOCKENABLE |
> -			OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK |
> -			hdq_data->mode);
> -		hdq_reg_out(hdq_data, OMAP_HDQ_SYSCONFIG,
> -			OMAP_HDQ_SYSCONFIG_AUTOIDLE);
> -	}
> -
> -	return ret;
> -}

I will probably do more testing the next days.

Regards,
Andreas
