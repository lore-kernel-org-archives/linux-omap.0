From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 0/7] omap hwspinlock dt support
Date: Mon, 17 Mar 2014 21:47:42 +0200
Message-ID: <CAK=WgbYjtw+cxy5wX6pjK=Rpj6wOk6Cu+GrPuFN+sqtgDAY=_Q@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <52F9282B.5000702@ti.com> <530B8C00.8020001@ti.com> <CAK=WgbZp_RQPCeZJyMRkNTQxaJsnGZ3DnjhSkYYR_-PAE_Kp4g@mail.gmail.com>
 <53239789.40600@ti.com> <CAK=WgbZCzA7JovSxnysHCQRZZWc3Z2j3AS8ekpM9fOZ160rmCA@mail.gmail.com>
 <532748B7.1080606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <532748B7.1080606-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Mon, Mar 17, 2014 at 9:10 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> base_id would be a property (if added) of the hwspinlock controller node,
> and from DT perspective, we will be using the phandle for the controller
> anyway. So, using a base_id+specifier seems redundant, as the specifier is
> already w.r.t a hwspinlock controller node.  It is best to leave the base_id
> out, just use the specifier. This is pretty much the standard practice
> (GPIOs, DMAs, etc all follow this).

Do you mean hwspin_lock_get_id() will return just the specifier
instead of base_id+specifier? This is problematic, because Linux will
not be able to communicate this lock id outside to a different core
running a different OS: that OS will have no idea what hwlock
controller this is relative to.

> Please see the comments from Mark regarding the same on an earlier version.

I think I understand and agree with Mark generally, but in this case,
the hwlock id is not an implementation detail. Unlike GPIOs/DMAs, this
id number is global and system-wide (Linux is just one component in
the system, and must use the same predefined id numbers all other
cores use, otherwise it will be impossible to use those hwlocks for
multi-core synchronization).

> Yes, I agree this is an issue if we have to have the base_ids fixed per
> controller.

Do you see any other way this could work if the base_ids were not
predefined? Linux and some other core running a different OS must
agree on the id numbers of the hardware locks we have in the system.

>> Before DT came along, early board code could have reserved specific
>> hwspinlocks if needed. Now with DT, we should add the list of reserved
>> locks to the controller node, in order to prevent them from being
>> dynamically allocated by others.
>
>
> But that strictly relied on the order of requests without any core changes
> in the hwspinlock core, right.

I don't think so, you could request a specific lock by id number.

> With DT, the early board code is much simplified. Looking at the same
> scenario from DT case, it seems kinda redundant to specify a set of reserved
> locks both in the controller node, as well as the respective client drivers,
> as there is almost no platform data with DT. The only use case for DT client
> nodes would be for requesting specific locks. I agree with the problem you
> described, and I think it will require a different set of changes to the
> core.

Exactly. The platform-specific hwspinlock driver will have to inform
the core, upon registration, which of the locks are already reserved.
In turn, the core will never provide them to clients that dynamically
allocate an hwlock: they will be provided only to clients that ask for
them specifically (using phandle+specifier).

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
