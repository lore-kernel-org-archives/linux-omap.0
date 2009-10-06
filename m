From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on
 OMAP3430
Date: Tue, 6 Oct 2009 19:01:28 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A33246A@dbde02.ent.ti.com>
References: <1254741761-31546-1-git-send-email-y>
	<87ljjpzs9p.fsf@deeprootsystems.com> <4ACA2C83.9080400@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A3321EF@dbde02.ent.ti.com>
 <87k4z8u0fh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37164 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757276AbZJFNc0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 09:32:26 -0400
In-Reply-To: <87k4z8u0fh.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Tuesday, October 06, 2009 6:47 PM
>>To: Gopinath, Thara
>>Cc: Menon, Nishanth; linux-omap@vger.kernel.org; Gulati, Shweta
>>Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on OMAP3430
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>> The problem here is not with the restore. If MPU reads the PADCONF_SAVEDONE bit very close
>>> to the end of context save sequence for the pad conf registers, the last context is not
>>> saved to the scratchpad memory. This is a h/w bug. The workaround proposed is to delay the
>>> MPU access of SAVEDONE bit until the last context has been saved. 300 us delay is the current
>>> safe delay proposed by TI. I believe investigations are going on to whether this delay can be
>>> optimized. Also only the last context (ETK_D14) has the risk of not getting saved.
>>
>>All of this should've been in the original changelog.  These are the
>>details that help others understand the problem trying to be solved
>>and think about whether there might be other solutions.
>>
>>> We could add a defconfig option for this workaround and enable it on need basis till TI
>>> comes out with proper optimized workaround sequence.
>>
>>No, Kconfig is not an option for this.
>>
>>I think Nishanth's proposal is a much better workaround for this
>>problem, and doesn't introduce and additional 300 usec delay to
>>*every* off-mode transistion.

I am not very sure about this as it has the risk of glitch on the line. It is probably ok if the ball is not used. But if in use, the glitch could create issues. 
>>
>>Kevin
