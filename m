From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on OMAP3430
Date: Tue, 06 Oct 2009 07:20:17 -0700
Message-ID: <8763assixq.fsf@deeprootsystems.com>
References: <1254741761-31546-1-git-send-email-y>
	<87ljjpzs9p.fsf@deeprootsystems.com> <4ACA2C83.9080400@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A3321EF@dbde02.ent.ti.com>
	<87k4z8u0fh.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A33246A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f187.google.com ([209.85.216.187]:42049 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688AbZJFOU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 10:20:57 -0400
Received: by pxi17 with SMTP id 17so5182896pxi.21
        for <linux-omap@vger.kernel.org>; Tue, 06 Oct 2009 07:20:20 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A33246A@dbde02.ent.ti.com> (Thara Gopinath's message of "Tue\, 6 Oct 2009 19\:01\:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Tuesday, October 06, 2009 6:47 PM
>>>To: Gopinath, Thara
>>>Cc: Menon, Nishanth; linux-omap@vger.kernel.org; Gulati, Shweta
>>>Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on OMAP3430
>>>
>>>"Gopinath, Thara" <thara@ti.com> writes:
>>>
>>>> The problem here is not with the restore. If MPU reads the PADCONF_SAVEDONE bit very close
>>>> to the end of context save sequence for the pad conf registers, the last context is not
>>>> saved to the scratchpad memory. This is a h/w bug. The workaround proposed is to delay the
>>>> MPU access of SAVEDONE bit until the last context has been saved. 300 us delay is the current
>>>> safe delay proposed by TI. I believe investigations are going on to whether this delay can be
>>>> optimized. Also only the last context (ETK_D14) has the risk of not getting saved.
>>>
>>>All of this should've been in the original changelog.  These are the
>>>details that help others understand the problem trying to be solved
>>>and think about whether there might be other solutions.
>>>
>>>> We could add a defconfig option for this workaround and enable it on need basis till TI
>>>> comes out with proper optimized workaround sequence.
>>>
>>>No, Kconfig is not an option for this.
>>>
>>>I think Nishanth's proposal is a much better workaround for this
>>>problem, and doesn't introduce and additional 300 usec delay to
>>>*every* off-mode transistion.
>
> I am not very sure about this as it has the risk of glitch on the
> line. It is probably ok if the ball is not used. But if in use, the
> glitch could create issues.

I don't follow.

IIUC, Nishanth's proposal would be to

In save context:
- manually save ETK_D14 to some static variable (SDRAM)
- initiate the padconf safe 
- poll SAVE_DONE
- here ETK_D14 value saved by HW possibly corrupted, 
  but the copy saved manually should be fine

In restore:
- manually restore ETK_D14 from the static variable

What is wrong with this approach?

Kevin


