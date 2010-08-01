From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH v2] twl4030 reboot workaround
Date: Sun, 01 Aug 2010 09:31:55 +0300
Message-ID: <4C5514DB.9020508@compulab.co.il>
References: <20100729061608.GG12063@edollo>	<1280385678-4366-1-git-send-email-ext-mikko.rapeli@nokia.com> <AANLkTi=OkfRGvW05ZTOaSU+-r7jo40wHFK_pkQM9Hmw=@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB0323D40C6F@dbde02.ent.ti.com> <4C531C58.4020803@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0323D40F1B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:41535 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab0HAGcs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 1 Aug 2010 02:32:48 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323D40F1B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Turquette, Mike" <mturquette@ti.com>, Mikko Rapeli <ext-mikko.rapeli@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, Mike Rapoport <mike@compulab.co.il>

Gopinath, Thara wrote:
> 
>>> -----Original Message-----
>>> From: Turquette, Mike
>>> Sent: Saturday, July 31, 2010 12:09 AM
>>> To: Gopinath, Thara
>>> Cc: Mike Rapoport; Mikko Rapeli; linux-omap@vger.kernel.org; sameo@linux.intel.com
>>> Subject: Re: [PATCH v2] twl4030 reboot workaround
>>>
>>> Gopinath, Thara wrote:
>>>>>> -----Original Message-----
>>>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>>> Mike
>>>>>> Rapoport
>>>>>> Sent: Friday, July 30, 2010 12:41 AM
>>>>>> To: Mikko Rapeli
>>>>>> Cc: linux-omap@vger.kernel.org; Turquette, Mike; sameo@linux.intel.com
>>>>>> Subject: Re: [PATCH v2] twl4030 reboot workaround
>>>>>>
>>>>>> Hi
>>>>>>
>>>>>> On Thu, Jul 29, 2010 at 9:41 AM, Mikko Rapeli
>>>>>> <ext-mikko.rapeli@nokia.com> wrote:
>>>>>>> From: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
>>>>>>>
>>>>>>> Original patch: http://marc.info/?l=linux-omap&m=126522625032441&w=2
>>>>>>>
>>>>>>> "Removes TWL4030 sleep script prior to rebooting, only on OMAP3. This is
>>>>>>> necessary since DPLL3 reset causes SYS_OFFMODE pin to go low, resulting
>>>>>>> in the sleep script being executed on TWL4030. This usually results in
>>>>>>> VDD1 & VDD2 voltage collapse while ROM code is executing, followed by an
>>>>>>> MPU Watch Dog reset or worse, an irrecoverable hang."
>>>>>> I had a similar issue when my system hanged on hard reset when there
>>>>>> was a TWL sleep script installed.
>>>>>> The workaround I've found was to install the sleep script immediately
>>>>>> before entering the suspend state and remove the script on the resume
>>>>>> path.
>>>>>> If you think that such approach is appropriate I can send a patch.
>>>> How do you hit the off state(Vdd's at 0 V) in the idle path then? Or do you do this every
>>>> time in the idle thread also?
>>> I do not think it is appropriate to add/remove the sleep script
>>> before/after every OFF mode case.  The script should be programmed once
>>> and left alone EXCEPT in the case of warm reset.
>>>
>>> If there are other corner cases where SYS_OFFMODE goes low, then we
>>> should cover those with similar fixes to the warm reset fix, but in
>>> general I think the policy should be to leave the scripts alone once
>>> programmed
>>>
>>> Dynamically programming/removing the scripts around OFF transitions
>>> increases software overhead for those transitions even more which is
>>> very undesirable.
> 
> This was exactly my concern. The latency increase due to the dynamic addition and
> removal of sleep scripts around off transitions might not be justifiable. Maybe Mike
> does not want to hit 0V for Vdd's in the idle thread in which case it can be acceptable to
> dynamically add the script in the system suspend path and remove it in the resume path.
> Else I also do not think this approach is acceptable.

I've missed the idle case indeed and I agree that dynamic addition and removal 
of sleep scripts is not an acceptable solution.

> Regards
> Thara
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
