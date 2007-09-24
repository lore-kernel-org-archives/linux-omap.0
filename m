From: Vivek Kutal <vivek.kutal@celunite.com>
Subject: Re: Problem in omap_pm_idle()
Date: Mon, 24 Sep 2007 12:48:03 +0530
Message-ID: <46F764AB.7040400@celunite.com>
References: <46EFDF0D.8000808@celunite.com><3E32F84CD6CB95498A35B353CA3B930C067318@fioues08.ebgroup.elektrobit.com>
	<46F26879.9020504@celunite.com>
	<3E32F84CD6CB95498A35B353CA3B930C06731E@fioues08.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3E32F84CD6CB95498A35B353CA3B930C06731E@fioues08.ebgroup.elektrobit.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tuukka.Tikkanen@elektrobit.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tuukka.Tikkanen@elektrobit.com wrote:
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
> Vivek Kutal
>   
>> Tuukka.Tikkanen@elektrobit.com wrote:
>>     
>>> From: Vivek Kutal
>>> Subject: Problem in omap_pm_idle()
>>>   
>>>       
>>>> Hi ,
>>>>        I was looking at omap_pm_idle() in omap1/pm.c , at the end
>>>> there is a call to omap_sram_suspend , shouldn't it be
>>>> omap_sram_idle() ? and if CONFIG_OMAP_MPU_TIMER is set it sets
>>>> use_idlect1 = use_idlect1 & ~(1 << 9) ,  but it does not go into
>>>> wait for interrupt.
>>>>        Can anyone please explain this ?
>>>>     
>>>>         
>>> The only real difference between suspend and idle sleep on omap1 is
>>>       
> that
>   
>>> for suspend peripheral devices are forcibly shut down. Also the idle
>>> sleep avoids turning off certain clock in some special cases. If
>>>       
> there
>   
>>> is no user or application activity, when everything is working as
>>> intended the hardware ends up into suspend-like state in idle sleep
>>>       
> to
>   
>>> conserve battery (with very quick recovery however), so the call is
>>> correct.
>>>
>>>   
>>>       
>> So we should probably remove the omap_sram_push calls for
>>     
> omap_sram_idle 
>   
>> from omap_pm_init , and its code from sleep.S...right ?
>>
>> and what about the CONFIG_OMAP_MPU_TIMER problem ?
>> it should at least go in Wait for interrupt when mpu timer is 
>> used...right now it just exits from omap_pm_idle().
>>     
>
> Yes, it seems the conditional compilation directives are wrong. I'd say
> the #endif on line 178 should be on line 150. (Assuming the 1<<9 bit in
> idlect1 is the one controlling the clock source used by the system timer
> in cases where 32kHz source is not used. I dont have TRM access any
> more, so I can't be certain.) Additionally the do_sleep variable should
> be unconditionally declared and the initial value should be moved from
> line 138 outside the conditional area.
>
> Functionality should be verified after such changes, of course.
> Particular attention should be paid to the system time potentially
> slowing down. Should there be any issues then additional idlect bits
> need to be masked. Key issue is to make sure the timer still gets
> functional clock feed under all circumstances.
>
>
>   
I'll do the changes and see if there is any time issue.
and I'll also send a patch for removing the code related to 
omap_sram_idle in pm_init.

--
Thanks
Vivek
