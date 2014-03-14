From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 0/7] omap hwspinlock dt support
Date: Fri, 14 Mar 2014 22:10:00 +0200
Message-ID: <CAK=WgbZp_RQPCeZJyMRkNTQxaJsnGZ3DnjhSkYYR_-PAE_Kp4g@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <52F9282B.5000702@ti.com> <530B8C00.8020001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <530B8C00.8020001-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman, Mark,

On Mon, Feb 24, 2014 at 8:14 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> Mark, Ohad,
...
> Gentle reminder, can you provide your acks/comments?

Sorry for the late jump in.

I have a few comments:

- Hardware spinlocks must have global and system-wide id numbers;
these numbers cannot be maintained internally by the Linux Kernel.
Think of an SoC with several asynchronous heterogeneous processors,
each of which is running a different OS, and they all need to use a
specific hardware spinlock in order to share some resource. For that
to happen, every hwlock must have a predefined and deterministic id
number which is global in the system. We can't have those id numbers
be relative to an hwlock "controller", and we can't have two hwlock
"controllers" share the same id numbers.

- I suspect the simplest and most straight forward way to achieve this
is by (a) bringing back the concept of the base_id property, and (b)
letting the global hwlock id be the DT identifier (plus the base_id)
and then providing it directly to the drivers when needed. The latter
is required in order to support dynamically allocation of hwlocks, in
which case Linux must know the global system-wide id number, and then
share it with the other asynchronous OSes via some IPC.

- If we feel there's no way any system is going to have more than a
single hwlock controller, then we can live without a base_id property,
but then this needs to be clearly documented and prohibited. Today
both the hwlock DT representation, and the coupled kernel code,
implicitly allow this anomaly to exist.

- Hwlock controller nodes should have a list of reserved locks (those
locks for which other nodes have a phandle+identifier pointing at) to
prevent those locks from being dynamically allocated by eager drivers.

Most of these issues were discussed Arnd, Benoit and myself back then,
please see below:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-September/064265.html

Let's discuss,

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
