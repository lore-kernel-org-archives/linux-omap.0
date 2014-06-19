From: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Subject: Re: Gadget regression with enabling of MUSB babble interrupt handling
Date: Thu, 19 Jun 2014 12:50:21 +0200
Message-ID: <53A2C06D.1000705@zonque.org>
References: <20140619095655.GA29055@atomide.com> <53A2B6B0.2040804@zonque.org> <20140619103100.GB29055@atomide.com> <53A2BD34.1060409@zonque.org> <20140619104324.GC29055@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140619104324.GC29055-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/19/2014 12:43 PM, Tony Lindgren wrote:
> * Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> [140619 03:38]:
>> On 06/19/2014 12:31 PM, Tony Lindgren wrote:
>>> * Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> [140619 03:10]:
>>>> On 06/19/2014 11:56 AM, Tony Lindgren wrote:

>>> But that also raises a question: Were these patches merged for
>>> v3.16 ever even tested in peripheral mode?
>>
>> At the time, I had no such hardware to test this on, so I was hoping for
>> more testers to give them a try in different environments, which
>> apparently didn't happen. It fixed a dead USB port condition on
>> host-mode enabled hardware, though.
> 
> Well we probably should not merge patches without proper acks and
> tested-by:s in general as things just seem to keep breaking
> constantly otherwise. And things not working will keep people from
> using linux next which will lead into even less testing..

I'm fairly sure the patch causing your trouble has been in linux-next
for a while before they hit the merge window, so people with gadget
enabled musb could have noticed the breakage early enough. The feedback
rate for patches to this driver posted to linux-usb is also usually low,
unfortunately.

Anyway, breaking things is certainly not good, and I'm sorry for that.
I'm just uncertain what detail in the procedure should be tweaked in
order to prevent that from happening in the future.


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
