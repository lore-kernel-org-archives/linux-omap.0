From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP2+ i2c NACK without STP
Date: Tue, 03 Jan 2012 16:07:04 -0800
Message-ID: <87boqk8h5j.fsf@ti.com>
References: <20110614102409.GN3352@atomide.com>
	<1308048853-21911-1-git-send-email-j.weitzel@phytec.de>
	<CANrkHUZ530H+0+YKy2QJPFbwUQ1zqD=OaSrF6ByTbpx6eU421Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANrkHUZ530H+0+YKy2QJPFbwUQ1zqD=OaSrF6ByTbpx6eU421Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(T. Krishnamoorthy's message of "Tue, 27 Dec 2011 20:18:21 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "T Krishnamoorthy, Balaji" <balajitk-l0cyMroinI0@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Jan Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

"T Krishnamoorthy, Balaji" <balajitk-l0cyMroinI0@public.gmane.org> writes:

> On Tue, Jun 14, 2011 at 4:24 PM, Jan Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org> wrote:
>> On OMAP4 OMAP_I2C_STAT_NACK is causing a timeout on the next access.
>> The isr cleans all flags in OMAP_I2C_CON_REG by setting OMAP_I2C_CON_STP
>> OMAP_I2C_CON_STP is also set in omap_i2c_xfer_msg on the last message.
>>
>> According to the TI TSR the sequence for OMAP_I2C_STAT_NACK and
>> OMAP_I2C_STAT_AL are nearly the same.
>> Removing the OMAP_I2C_CON_STP part in the isr fix the problem.
>> Tested on OMAP4430 and OMAP3530 (here NACK was not a problem)
>> Fixes also booting on 2430sdp.
>>
>> Signed-off-by: Jan Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
>> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>
> Acked-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> Can you please queue this patch
>
> This patch has been tested in linux-omap tree
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=464fca36d98b97ccd05e4f200ab7483d3acc8345

I have this patch in my queue (branch: for_3.3/i2c/misc), but
unfortunately,  the maintainer has not responded to any of my queries or
pull requests for a couple months now.

I have sent some more off-list queries recently in hopes to get this
moving again.

Kevin
