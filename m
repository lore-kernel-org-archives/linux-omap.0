From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 03/19] irqchip: crossbar: Skip some irqs from getting
 mapped to crossbar
Date: Fri, 13 Jun 2014 16:34:53 +0530
Message-ID: <539ADAD5.1000904@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com> <1402574007-13987-4-git-send-email-r.sricharan@ti.com> <20140612125134.GS8664@titan.lakedaemon.net> <20140612135715.GE17845@atomide.com> <20140612140508.GC8664@titan.lakedaemon.net> <539AA08A.7010001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <539AA08A.7010001-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 13 June 2014 12:26 PM, Sricharan R wrote:
> Hi Jason,
> 
> On Thursday 12 June 2014 07:35 PM, Jason Cooper wrote:
>> On Thu, Jun 12, 2014 at 06:57:15AM -0700, Tony Lindgren wrote:
>>> * Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org> [140612 05:52]:
>>>> On Thu, Jun 12, 2014 at 05:23:11PM +0530, Sricharan R wrote:
>>>>> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>>>>>
>>>>> When, in the system due to varied reasons, interrupts might be unusable
>>>>> due to hardware behavior, but register maps do exist, then those interrupts
>>>>> should be skipped while mapping irq to crossbars.
>>>>>
>>>>> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>>>>> Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
>>>>> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>>>
>>>> Tony, have you applied these somewhere already?
>>>
>>> I think some of these I had applied into a branch ready for
>>> merging but then it was discovered that further changes
>>> were needed and the branch was dropped.
>>
>> Ok.
>>
>>> Sricharan, please remove my Signed-off-by from this series.
>>> If I end up applying it for merging my scripts will add it
>>> automatically.
>>
>> Do you have other changes outside of irqchip depending on this series?
>> If so, I can set up a topic branch for you guys to base off of.
>> Otherwise, I'll just apply them to irqchip/core when they're ready.
>>
>  There are dts changes which are dependent upon this series.
> 
>   http://www.spinics.net/lists/linux-omap/msg108116.html
> 
>> Also, Sricharan, when you respin this, please clearly identify (in the
>> comment section) those patches that need to be flagged for stable.  It
>> would be helpful if they were the first patches in the series as well.
> 
> Ok, i will point this out clearly.
 Infact since the dts node is not present in the older kernel (even now),
 the driver itself is not used. So i feel there is nothing to be flagged
  for stable as such.

Regards,
 Sricharan
 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
