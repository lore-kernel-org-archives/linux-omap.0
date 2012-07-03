From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Tue, 3 Jul 2012 12:15:51 +0530
Message-ID: <CAP05o4+v0+DrLv+DZRvrfuE3zc9pyu+5C9owz7CjqnY+s=bcqQ@mail.gmail.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
	<20120622103050.GG28472@arwen.pp.htv.fi>
	<87ehp71liv.fsf@ti.com>
	<20120622203645.GD29290@arwen.pp.htv.fi>
	<87d34nfdei.fsf@ti.com>
	<871uku85o8.fsf@ti.com>
	<87hatp4s6m.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33767 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309Ab2GCGpy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 02:45:54 -0400
Received: by lbbgg6 with SMTP id gg6so10233830lbb.8
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 23:45:51 -0700 (PDT)
In-Reply-To: <87hatp4s6m.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, sameo@linux.intel.com, notasas@gmail.com, Paul Walmsley <paul@pwsan.com>

On Tue, Jul 3, 2012 at 5:44 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kevin Hilman <khilman@ti.com> writes:
>
>> Felipe, Keshava,
>>
>> Kevin Hilman <khilman@ti.com> writes:
>>
>>> Felipe Balbi <balbi@ti.com> writes:
>>>
>>> [...]
>>>
>>>> Keshava is reverting a fix for a HW errata. I can't accept it as it will
>>>> cause regressions. Granted, regression by regression, there's no change,
>>>> but I simply can't knowingly cause a regression to the driver just to
>>>> have PM working. We need a real fix for this issue.
>>>
>>> Sure, as long as there is a fix in this -rc cycle.
>>>
>>> This driver intoduced changes in v3.5 that break PM for the whole SoC
>>> (by preventing CORE retention.)  These changes were clearly not tested
>>> with PM.
>>>
>>> If you cannot fix this during the -rc cycle, then you need to revert the
>>> driver PM changes that broke PM for the *whole* SoC.
>>
>> What's the status of this regression?
>>
>> This is still broken in v3.5-rc and is preventing CORE retention for the
>> *whole* SoC.
>>
>> Please fix this, either with a proper fix, or a revert for 3.5-rc.
>>
>
> BTW, a related issue with this driver (but not sure it's a regression)
> is that USB ethernet does not seem to survive a suspend/resume.
>
> If I'm using a NFS rootfs, after suspend/resume, the NFS servers stops
> responding, and I get these errors:
>
>   nfs: server X.X.X.X not responding, still trying

This issue because of two issues:

1. The phy goes to bad state and ehci ports goes out the suspend
                    Fix was made by resetting the phy and re-power the
ehci ports; but Alan has commented on this.
                 it stil requires a reworks
2. The usb-serial driver does not have reset-resume, so it gets the
different ip address but NFS wont be functional
                     nothing can be done in the ehci driver,
debugging is requried at usb serial driver.

regards
keshava
