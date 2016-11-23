From: Nicolae Rosia <nicolae.rosia.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] rtc: rtc-twl: kill static variables
Date: Wed, 23 Nov 2016 10:39:12 +0200
Message-ID: <CAKP5S=0vLb+7az4aaFyPjGSEE5cG+epM2qpGP=zpzhvt6x69qA@mail.gmail.com>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-2-git-send-email-Nicolae_Rosia@mentor.com> <20161122223103.qd44b3z5aj4ahroi@piout.net>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDL53MW2W4EBBMNL2XAQKGQEBEG6HZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161122223103.qd44b3z5aj4ahroi-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
Thanks for the review.

On Wed, Nov 23, 2016 at 12:31 AM, Alexandre Belloni
<alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hi,
>
> A few alignments are off but I can fix that provided you answer the
> question below:
>
Ok, could you please indicate which lines so I can fix them instead of
wasting your time?

> On 12/11/2016 at 12:07:24 +0200, Nicolae Rosia wrote :
>>       /* for twl6030/32 make sure BIT_RTC_CTRL_REG_GET_TIME_M is clear */
>> -     if (twl_class_is_6030()) {
>> +     if (!twl_rtc->is_4030) {
>
> This changes the meaning of it. What if at some point there is a new
> part that is neither a 4030 nor an 6030?
> That will probably mean going over ths part of code again but maybe the
> odds are low and nobody cares.
Since there are only two classes, 4030 and 6030, it will work.
But you're right, it's better to retain the old logic so the changes
are minimal.

Will send V2 in a bit.

Thanks,
Nicolae

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
