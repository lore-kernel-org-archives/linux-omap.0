From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: omap: convert to module_platform_driver()
Date: Thu, 6 Jun 2013 17:58:24 +0300
Message-ID: <51B0A390.1030807@ti.com>
References: <1366723151-23209-1-git-send-email-grygorii.strashko@ti.com> <1366723151-23209-2-git-send-email-grygorii.strashko@ti.com> <87fvwylxl8.fsf@linaro.org> <51ADD06B.3000201@ti.com> <87zjv5zq41.fsf@linaro.org> <51AF20F0.30000@ti.com> <20130605135048.GB2934@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130605135048.GB2934@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/05/2013 04:50 PM, Wolfram Sang wrote:
>> The similar patch already exists:
>> https://patchwork.kernel.org/patch/2448251/ - [v2,1/2] RTC: rtc-twl:
>> Fix rtc_reg_map initialization
>> from Peter Ujfalusi
> So, I think it is best if you resend this patch after all the fixes it
> needs are applied or you resend the series with all patches it depends
> on. Which should then probably go via arm-soc. Or?
>
It can wait - I'll track and resend after twl-rtc patches.

-grygorii
