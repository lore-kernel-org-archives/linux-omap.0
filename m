From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv6 19/19] ARM: OMAP4: hwmod data: I2C: add flag for context
 restore
Date: Wed, 11 Apr 2012 11:10:32 +0530
Message-ID: <4F851950.6060503@ti.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com> <1334055397-899-20-git-send-email-shubhrajyoti@ti.com> <alpine.DEB.2.00.1204101212530.20894@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1204101212530.20894-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 April 2012 11:43 PM, Paul Walmsley wrote:
> On Tue, 10 Apr 2012, Shubhrajyoti D wrote:
>
>> Restore of context is not done for OMAP4. This patch
>> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
>> hwmod data which activates the restore for OMAP4.
>> Currently the OMAP4 does not hit device off still the
>> driver may have support for it.
>>
>> Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>> Cc: Paul Wamsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>> Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> Thanks, queued for 3.5.  You can drop this from your series; it will 
> likely cause merge conflicts if you don't.
Thanks Paul.
Will drop this patch and resend.
> - Paul
