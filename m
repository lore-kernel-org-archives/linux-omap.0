From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4] OMAP4: hwmod data: I2C: add flag for context restore
Date: Thu, 25 Aug 2011 17:52:15 +0530
Message-ID: <4E563E77.6090200@ti.com>
References: <1310906603-2673-1-git-send-email-shubhrajyoti@ti.com>	<4E54D012.6050708@ti.com> <87mxeyg98m.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87mxeyg98m.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 24 August 2011 08:14 PM, Kevin Hilman wrote:
> Shubhrajyoti<shubhrajyoti-l0cyMroinI0@public.gmane.org>  writes:
>
>> On Sunday 17 July 2011 06:13 PM, Shubhrajyoti D wrote:
>>> Restore of context is not done for OMAP4. This patch
>>> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
>>> hwmod data which activates the restore for OMAP4.
>>> Currently the OMAP4 does not hit device off still the
>>> driver may have support for it.
>> Could this patch be queued as well?
> Paul is the maintainer for the hwmod data.   It is usually helpful to
> ensure the maintainer is specifically added to the To line.
yes thanks will take care henceforth . For now adding him for comments.
> Kevin
>
>>> Reviewed-by: Kevin Hilman<khilman-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
>>> ---
>>> Applies on top of patches from Andy Green
>>> http://www.spinics.net/lists/linux-i2c/msg05632.html
>>> Tested on OMAP4430
>>>
>>>    arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
>>>    1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> index 0fe9556..5e2c748 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> @@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>>>    };
>>>
>>>    static struct omap_i2c_dev_attr i2c_dev_attr = {
>>> -	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
>>> +	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
>>> +			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
>>>    };
>>>
>>>    /* i2c1 */
