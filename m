From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Fri, 16 Jan 2015 08:09:00 +0200
Message-ID: <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
 <1421269101-51105-2-git-send-email-s-anna@ti.com> <20150115135201.GG16217@leverpostej>
 <20150115135556.GH16217@leverpostej> <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 15, 2015 at 4:42 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jan 15, 2015 at 7:55 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> On Thu, Jan 15, 2015 at 01:52:01PM +0000, Mark Rutland wrote:
>>> On Wed, Jan 14, 2015 at 08:58:18PM +0000, Suman Anna wrote:
>>> > +- hwlock-base-id:  An unique base Id for the locks for a particular hwlock
>>> > +                   device. This property is mandatory for all platform
>>> > +                   implementations.
>>>
>>> This property makes no sense. The ID encoded in the hwlock cells is
>>> relative to the instance (identified by phandle), not global. So the DT
>>> has no global ID space.
>>>
>>> Why do you think you need this?
>>
>> Having looked at the way this proeprty is used, NAK.
>>
>> If you need to carve up a Linux-internal ID space, do that dynamically.
>> There is no need for this property.
>
> Better yet, don't create a Linux ID space for this. Everywhere we have
> one, we want to get rid of it.

Rob, Mark,

The hwlock is a basic hardware primitive that allow synchronization
between different processors in the system, which may be running Linux
as well as other operating systems, and may have no other means of
communication.

The hwlock id numbers are predefined, global and static across the
entire system: Linux may boot well after other operating systems are
already running and using these hwlocks to communicate, and therefore,
in order to use these hardware devices, it must not enumerate them
differently than the rest of the system.

Given that these id numbers are global, system-wide, static and
predefined, where Linux may just be one user of them, please
reconsider the approach as implemented by Suman, or suggest an
alternative one you may prefer.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
