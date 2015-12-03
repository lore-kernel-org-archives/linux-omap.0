From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [4.4-rc][PATCH v2] ARM: dts: am4372: fix clock source for arm twd
 and global timers
Date: Thu, 3 Dec 2015 20:04:46 +0200
Message-ID: <5660843E.3000801@ti.com>
References: <1448898998-32749-1-git-send-email-grygorii.strashko@ti.com>
 <20151203163551.GQ23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151203163551.GQ23396-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: t-kristo-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 12/03/2015 06:35 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [151130 07:58]:
>> ARM TWD and Global timer are clocked by PERIPHCLK which is MPU_CLK/2.
>> But now they are clocked by dpll_mpu_m2_ck == MPU_CLK and, as result.
>> Timekeeping core misbehaves. For example, execution of command
>> "sleep 5" will take 10 sec instead of 5.
>>
>> Hence, fix it by adding mpu_periphclk ("fixed-factor-clock") and use
>> it for clocking ARM TWD and Global timer (same way as on OMAP4).
>>
>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
>> Fixes:commit 8cbd4c2f6a99 ("arm: boot: dts: am4372: add ARM timers and SCU nodes")
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> 
> Is this fix alone enough or do you still need to disable other the ARM
> timers in the board specific dts file?
> 

This one is independent and it's required for -rc, because ARM TWD timer will be selected
now for am43xx even if http://www.spinics.net/lists/arm-kernel/msg459649.html
is not merged yet ;) in case of omap2plus_defconfig build.


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
