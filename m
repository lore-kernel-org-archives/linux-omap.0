From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on
 OMAP3430
Date: Tue, 6 Oct 2009 20:05:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A3324B2@dbde02.ent.ti.com>
References: <1254741761-31546-1-git-send-email-y>
	<87ljjpzs9p.fsf@deeprootsystems.com> <4ACA2C83.9080400@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A3321EF@dbde02.ent.ti.com>
	<87k4z8u0fh.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A33246A@dbde02.ent.ti.com>
 <8763assixq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55565 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbZJFOgQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 10:36:16 -0400
In-Reply-To: <8763assixq.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Tuesday, October 06, 2009 7:50 PM
>>To: Gopinath, Thara
>>Cc: Menon, Nishanth; linux-omap@vger.kernel.org; Gulati, Shweta
>>Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on OMAP3430
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>>>>-----Original Message-----
>>>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>>Sent: Tuesday, October 06, 2009 6:47 PM
>>>>>To: Gopinath, Thara
>>>>>Cc: Menon, Nishanth; linux-omap@vger.kernel.org; Gulati, Shweta
>>>>>Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on OMAP3430
>>>>>
>>>>>"Gopinath, Thara" <thara@ti.com> writes:
>>>>>
>>>>>> The problem here is not with the restore. If MPU reads the PADCONF_SAVEDONE bit very close
>>>>>> to the end of context save sequence for the pad conf registers, the last context is not
>>>>>> saved to the scratchpad memory. This is a h/w bug. The workaround proposed is to delay the
>>>>>> MPU access of SAVEDONE bit until the last context has been saved. 300 us delay is the current
>>>>>> safe delay proposed by TI. I believe investigations are going on to whether this delay can be
>>>>>> optimized. Also only the last context (ETK_D14) has the risk of not getting saved.
>>>>>
>>>>>All of this should've been in the original changelog.  These are the
>>>>>details that help others understand the problem trying to be solved
>>>>>and think about whether there might be other solutions.
>>>>>
>>>>>> We could add a defconfig option for this workaround and enable it on need basis till TI
>>>>>> comes out with proper optimized workaround sequence.
>>>>>
>>>>>No, Kconfig is not an option for this.
>>>>>
>>>>>I think Nishanth's proposal is a much better workaround for this
>>>>>problem, and doesn't introduce and additional 300 usec delay to
>>>>>*every* off-mode transistion.
>>>
>>> I am not very sure about this as it has the risk of glitch on the
>>> line. It is probably ok if the ball is not used. But if in use, the
>>> glitch could create issues.
>>
>>I don't follow.
>>
>>IIUC, Nishanth's proposal would be to
>>
>>In save context:
>>- manually save ETK_D14 to some static variable (SDRAM)
>>- initiate the padconf safe
>>- poll SAVE_DONE
>>- here ETK_D14 value saved by HW possibly corrupted,
>>  but the copy saved manually should be fine
>>
>>In restore:
>>- manually restore ETK_D14 from the static variable
>>
>>What is wrong with this approach?
In this approach there is a possibility that the h/w restore a wrong value to PADCONF_ETKD14.
Now suppose this pin is in use and is supposed to be pulled high. And the proper save does not happen
1. Before going to Off - the pin is pulled high
2. Off 
3. h/w restore - Has done bad save. So bad value restored. Say pull low.
4. Manual restore - the pin is again pulled high.

Now there is a glitch between step 3 and 4. If this pin is not used by anybody we could live with this glitch. But considering this pin is muxed with gpio28/gpio29, hsusb_tll_data0/ hsusb_tll_data1 this glitch might be unacceptable.

Regards
Thara
