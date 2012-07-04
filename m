From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Wed, 04 Jul 2012 06:33:35 -0700
Message-ID: <87k3yj4pn4.fsf@ti.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
	<20120622103050.GG28472@arwen.pp.htv.fi> <87ehp71liv.fsf@ti.com>
	<20120622203645.GD29290@arwen.pp.htv.fi> <87d34nfdei.fsf@ti.com>
	<871uku85o8.fsf@ti.com>
	<CAP05o4+hxt6zY0AxK5aNW7a3Hyiw0_krP9=XK_prN5=Uk2SxmA@mail.gmail.com>
	<CAP05o4KinrK7N13nivOy+reibY526c8sv6ySkxwDZwDMJHSaiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:59809 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752140Ab2GDNde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 09:33:34 -0400
Received: by pbbrp2 with SMTP id rp2so10326493pbb.28
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 06:33:26 -0700 (PDT)
In-Reply-To: <CAP05o4KinrK7N13nivOy+reibY526c8sv6ySkxwDZwDMJHSaiQ@mail.gmail.com>
	(Keshava Munegowda's message of "Tue, 3 Jul 2012 12:52:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, sameo@linux.intel.com, notasas@gmail.com, Paul Walmsley <paul@pwsan.com>

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

> On Tue, Jul 3, 2012 at 12:17 PM, Munegowda, Keshava
> <keshava_mgowda@ti.com> wrote:
>> On Mon, Jul 2, 2012 at 10:24 PM, Kevin Hilman <khilman@ti.com> wrote:
>>> Felipe, Keshava,
>>>
>>> Kevin Hilman <khilman@ti.com> writes:
>>>
>>>> Felipe Balbi <balbi@ti.com> writes:
>>>>
>>>> [...]
>>>>
>>>>> Keshava is reverting a fix for a HW errata. I can't accept it as it will
>>>>> cause regressions. Granted, regression by regression, there's no change,
>>>>> but I simply can't knowingly cause a regression to the driver just to
>>>>> have PM working. We need a real fix for this issue.
>>>>
>>>> Sure, as long as there is a fix in this -rc cycle.
>>>>
>>>> This driver intoduced changes in v3.5 that break PM for the whole SoC
>>>> (by preventing CORE retention.)  These changes were clearly not tested
>>>> with PM.
>>>>
>>>> If you cannot fix this during the -rc cycle, then you need to revert the
>>>> driver PM changes that broke PM for the *whole* SoC.
>>>
>>> What's the status of this regression?
>>>
>>> This is still broken in v3.5-rc and is preventing CORE retention for the
>>> *whole* SoC.
>>>
>>> Please fix this, either with a proper fix, or a revert for 3.5-rc.
>>
>>
>> The proper fix for this is implement ion of ehci remote wakeup through
>> I/O chain handler; it takes time.
>> As Felipe also mentioned,  This patch is OK for now.
>
> Sorry, Felipe still insist not to revert this patch, but to change
> this patch requires quite more changes in the usbhs core
> and we need to see the how the hub control changes need to be brought
> in to usbhs core. so , reverting is the
> best solution to time being.
>
> Its observed that ehci was enabled after linux kernal version 3.3 ;
> before that even though driver was there
> the ehci deriver was disabled by defaults; and it is expected the
> people who want to use NFS then can enable it
> explicitly.
>
> so,  the solution is
>
> 1. Use this patch ( reverting the hw errata ) to fix the NFS Boot and
> suspend/resume crash

Or, use the patches from Russ Dill where were more targetted fixes.
Either way, I'm OK with that.

> 2. Disable the ehci driver to make the pm work in idle case ;
>               This configuration should exist till the ehci remote
> wakeup implementation completes.

Yes.  Please disabled it by default.

Until PM in this driver can work without breaking PM for the whole SoC,
it should remain disabled.

Please queue up all of these fixes ASAP for the v3.5

Kevin
