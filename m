From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 0/7] omap hwspinlock dt support
Date: Mon, 17 Mar 2014 14:10:47 -0500
Message-ID: <532748B7.1080606@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com> <52F9282B.5000702@ti.com> <530B8C00.8020001@ti.com> <CAK=WgbZp_RQPCeZJyMRkNTQxaJsnGZ3DnjhSkYYR_-PAE_Kp4g@mail.gmail.com> <53239789.40600@ti.com> <CAK=WgbZCzA7JovSxnysHCQRZZWc3Z2j3AS8ekpM9fOZ160rmCA@mail.gmail.com>
Reply-To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK=WgbZCzA7JovSxnysHCQRZZWc3Z2j3AS8ekpM9fOZ160rmCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 03/17/2014 09:23 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
>
> On Sat, Mar 15, 2014 at 1:58 AM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
>> The series doesn't change the semantics of hwspinlock registration or adds a
>> new OF controller registration function. Implementations would still need to
>> register a controller using a base_id and number of locks. The series rather
>> adds a DT-friendly function _ONLY_ for requesting a specific hwlock, and
>> there are no restrictions on the args specifier being relative id numbers.
>> Though this is what the simple default xlate helper does (most common
>> usage), the added xlate ops and #hwlock-cells should allow individual
>> implementation drivers to adjust any variations, and return a relative lock
>> w.r.t its registered base_id, as this is how a lock gets registered in the
>> first place.
>
> I might be missing something, but why can't we have the
> specifier+base_id be the hwlock id and then we can entirely drop most
> of the core changes in this patch-set?

base_id would be a property (if added) of the hwspinlock controller 
node, and from DT perspective, we will be using the phandle for the 
controller anyway. So, using a base_id+specifier seems redundant, as the 
specifier is already w.r.t a hwspinlock controller node.  It is best to 
leave the base_id out, just use the specifier. This is pretty much the 
standard practice (GPIOs, DMAs, etc all follow this). Please see the 
comments from Mark regarding the same on an earlier version.

http://marc.info/?l=linux-omap&m=138135487703774&w=2

> I realize we couldn't easily
> support sparse id numbers, but not sure this is relevant to
> hwspinlocks? do we have a use case that couldn't be supported in this
> case?

I agree on the  sparse id numbers on hwspinlock, I don't see a need for it.

>
>> I actually started out this series with the base_id property, and dropped it
>> in v3 based on comments looking at it from the request-specific-lock
>> semantics with DT. That said, the drivers still need to manage a 'base_id'
>> needed for registration when they get probed for multiple controllers.
>> Getting the base_id from DT _may_ be useful just for registration purposes,
>> but for requesting a hwlock, a controller phandle and an implementation
>> defined args-specifier should suffice IMHO.
>
> How could drivers know what the base_id is if DT doesn't provide it?
> please note that we can't depend on order of controller probing; the
> hwlock id numbers cannot depend on implementation details.

Yes, I agree this is an issue if we have to have the base_ids fixed per 
controller. But I don't think it makes any difference from requesting a 
lock from a client DTS node. I can bring it back if Mark agrees.

>
>> The exact notion of informing the hwspinlock core about a list of reserved
>> locks is missing at the moment (even in the non-DT case). I am not sure if
>> this got lost during the conversion of the registration from per lock to
>> registering a bank of locks together, or if it is implied by the base_id +
>> num_locks combination. The core today supports requesting only those locks
>> that were actually registered, whether allocating a free one dynamically or
>> giving a specific one.
>
> Before DT came along, early board code could have reserved specific
> hwspinlocks if needed. Now with DT, we should add the list of reserved
> locks to the controller node, in order to prevent them from being
> dynamically allocated by others.

But that strictly relied on the order of requests without any core 
changes in the hwspinlock core, right. Also mandates that unique locks 
were requested for different clients (left to board integration). The 
early board code also has to pass on the reserved hwspinlock information 
to the actual client driver somehow (platform data).

With DT, the early board code is much simplified. Looking at the same 
scenario from DT case, it seems kinda redundant to specify a set of 
reserved locks both in the controller node, as well as the respective 
client drivers, as there is almost no platform data with DT. The only 
use case for DT client nodes would be for requesting specific locks. I 
agree with the problem you described, and I think it will require a 
different set of changes to the core.

regards
Suman


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
