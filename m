From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: omap4 ehci sporadic resume issue
Date: Tue, 02 Jul 2013 16:49:46 +0200
Message-ID: <51D2E88A.7050202@amarulasolutions.com>
References: <51CC2755.2030505@amarulasolutions.com> <51CC454A.1040104@ti.com> <20130627141704.GF12956@panicking> <51CC5105.4070301@ti.com> <20130627175623.GB21364@panicking> <CAB=otbQXVqFKOTtgvif=FZnWgDpbovAB6naPKTrsEHUJb21xTw@mail.gmail.com> <20130627192413.GA14115@panicking> <CAB=otbT-BcJg5tNZ=7jd1jvoK8N1Hd_skScuxczaeP=tagdcSw@mail.gmail.com> <20130628113314.GA25536@panicking> <51CD7783.8030907@ti.com> <20130628164751.GA1281@panicking> <51D2E6DA.6030000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51D2E6DA.6030000-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger

On 07/02/2013 04:42 PM, Roger Quadros wrote:
> On 06/28/2013 07:47 PM, Michael Trimarchi wrote:
>> Hi
>>
>> On Fri, Jun 28, 2013 at 02:46:11PM +0300, Roger Quadros wrote:
>>> On 06/28/2013 02:33 PM, Michael Trimarchi wrote:
>>>> Hi Roger
>>>>
>>>> On Thu, Jun 27, 2013 at 11:07:11PM +0300, Ruslan Bilovol wrote:
>>>>> On Thu, Jun 27, 2013 at 10:24 PM, Michael Trimarchi
>>>>> <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
>>>
>>>>> Do you have locks around this software workaround?
>>>>> The patch I did against 3.4 linux kernel may be helpful for
>>>>> you in such case: http://review.omapzoom.org/28515
>>>>> Another patch extends this WA for all OMAP4 SoCs:
>>>>> http://review.omapzoom.org/31108
>>>>
>>>> I'm testing using pm_test and stop to core (5ms and not 5 seconds) (usb suspend cycle are done correctly) so
>>>> the problem could be:
>>>>
>>>> 1) SAR usb context restore. I have applied the SAR workaround but the core doesn't go in full retantion
>>>> could be it a problem?
>>>
>>> If core doesn't go in to OFF then SAR will not come into play. Are you still affected by the
>>> issue if OFF mode is disabled? If yes then it probably is not related to SAR.
>>>
>>>>
>>>> 2) idle status of ulpis pins?
>>>
>>> Yes this can be possible.
>>>
>>> When you said earlier that the problem doesn't happen when one of the ULPIs is used
>>> did you try both of them individually. e.g. case 1: port 1 only enabled,
>>> case 2: port 2 only enabled.
>>>
>>> Did it work in both the cases?
>>
>> Yes, so I don't think could be a problem of ulpi pins and why this happen
>> on both at the same time? Seems more connected to somenthing else.
>>
> 
> Right. Seems to be related to two things. OFF Mode and 2 ports being used simultaneously.
> 
> I'm not sure how to go about fixing this. How important is OFF Mode for your application.
> Can you keep it always disabled?
> 

Right now I delivery without off mode. I will try to fix in long run the usb and I think that it could be a good platform to test omap4 mainline.

Last question:
If one domain is in RET mode and not OFF mode what happen during SAR restore in OFF mode?


Michael


> cheers,
> -roger
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
