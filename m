From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] omap4: i2c: add post idle reset registers flag
Date: Tue, 08 Nov 2011 11:55:10 -0800
Message-ID: <87hb2e1ja9.fsf@ti.com>
References: <1320701500-14535-1-git-send-email-x0132446@ti.com>
	<4EB8E445.4050604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EB8E445.4050604-l0cyMroinI0@public.gmane.org> (shubhrajyoti-l0cyMroinI0@public.gmane.org's message of "Tue,
	08 Nov 2011 13:41:49 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: David Anders <x0132446-l0cyMroinI0@public.gmane.org>, danders.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, aneesh-l0cyMroinI0@public.gmane.org, jayabharath-l0cyMroinI0@public.gmane.org, andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> On Tuesday 08 November 2011 03:01 AM, David Anders wrote:
>> omap44xx i2c devices need to have the registers reset post idle
>> similar to omap3xxx devices. this adds the additional flag for
>> OMAP_I2C_FLAG_RESET_REGS_POSTIDLE to the omap44xx i2c_dev_attr.
>
> Hello Anders a similar patch is already posted
> http://www.spinics.net/lists/linux-i2c/msg05913.html

Benoit/Paul,

Can one of you queue the original hwmod data fix from Shubhrajyoti (link
above) for v3.2-rc1?

Thanks,

Kevin
