From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Tue, 26 Jun 2012 10:21:05 +0530
Message-ID: <4FE93FB9.3080705@ti.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>		 <1340605221.12683.30.camel@lappyti>		 <CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>	 <1340627459.3395.54.camel@deskari> <4FE85CCA.80903@ti.com> <1340628648.3395.69.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:40098 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751416Ab2FZEvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 00:51:14 -0400
Received: by obbup19 with SMTP id up19so8374742obb.40
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 21:51:13 -0700 (PDT)
In-Reply-To: <1340628648.3395.69.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On Monday 25 June 2012 06:20 PM, Tomi Valkeinen wrote:
> On Mon, 2012-06-25 at 18:12 +0530, Rajendra Nayak wrote:
>> On Monday 25 June 2012 06:00 PM, Tomi Valkeinen wrote:
>>> On Mon, 2012-06-25 at 15:05 +0300, Grazvydas Ignotas wrote:
>>>> On Mon, Jun 25, 2012 at 9:20 AM, Tomi Valkeinen<tomi.valkeinen@ti.com>   wrote:
>>>>> On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
>>>>>>
>>>>>>    Currenlty HDMI fails to come up in the suspend-resume path.
>>>>>> This patch helps that real-world scenario.
>>>>>
>>>>> What is the problem there? It'd be good to explain the problem in the
>>>>> patch description. Does the pm_runtime_get return -EACCES?
>>>>
>>>> On slightly different but related issue, currently OMAPDSS always
>>>> spits lots of backtraces when it's compiled without CONFIG_PM_RUNTIME,
>>>> because pm_runtime_put* always return -ENOSYS without
>>>> CONFIG_PM_RUNTIME. So something like this patch proposes is needed, or
>>>> maybe WARN_ON should check for -ENOSYS, I don't know..
>>>
>>> Hmm. I guess I'm missing some understanding about runtime PM. omapdss
>>> uses runtime PM to enable the underlying DSS hardware. If there's no
>>> runtime PM, how does the driver work? Or is it the job of
>>> hwmod/omap_device to keep all the hardware always enabled if runtime PM
>>> is not compiled in?
>>
>> Yes, the below trick keeps all hwmods always enabled post the initial
>> setup if runtime PM is disabled.
>>
>> from arch/arm/mach-omap2/io.c
>>
>> static void __init omap_hwmod_init_postsetup(void)
>> {
>>           u8 postsetup_state;
>>
>>           /* Set the default postsetup state for all hwmods */
>> #ifdef CONFIG_PM_RUNTIME
>>           postsetup_state = _HWMOD_STATE_IDLE;
>> #else
>>           postsetup_state = _HWMOD_STATE_ENABLED;
>> #endif
>>           omap_hwmod_for_each(_set_hwmod_postsetup_state,&postsetup_state);
>>
>>           omap_pm_if_early_init();
>> }
>
> Ah, ok, thanks.
>
> Do you know how the drivers should handle CONFIG_PM_RUNTIME=n?
> Are they supposed to handle the error values returned by runtime PM
> functions somehow, or should they use #ifdef CONFIG_PM_RUNTIME?

hmm, I always though with CONFIG_RUNTIME_PM=n, the functions would
be stubbed to return success and not failure. And the _pm_runtime_resume
function indeed seems to return 1, which is not failure but just saying
that your device is already active/enabled.
The _pm_runtime_suspend and _pm_runtime_idle do return a -ENOSYS, which
is something only returned when CONFIG_RUNTIME_PM=n, so if you really
want to handle failing pm_runtime_put_sync cases, maybe you still can.
But then, I don't know if there is anything you can do to recover from
a failing pm_runtime_put_sync, except for warning the user maybe.

>
> Both options sound a bit difficult to me... With the first one it's
> difficult to see if there was an actual error and we should somehow
> react to it, or is everything fine and we just shouldn't care about
> runtime PM. The second one requires ifdefs in many places.
>
>   Tomi
>

