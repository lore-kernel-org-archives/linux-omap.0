From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] dspbridge: wait less and check the mailbox more
Date: Sun, 22 Feb 2009 08:46:47 +0200
Message-ID: <94a0d4530902212246h4160ae83pf435b5c6faf88237@mail.gmail.com>
References: <1235171057-7859-1-git-send-email-felipe.contreras@gmail.com>
	 <20090222.072137.189714248.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:33180 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbZBVGqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 01:46:49 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2310173fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 21 Feb 2009 22:46:47 -0800 (PST)
In-Reply-To: <20090222.072137.189714248.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: h-kanigeri2@ti.com, linux-omap@vger.kernel.org, felipe.contreras@nokia.com, ameya.palande@nokia.com

On Sun, Feb 22, 2009 at 7:21 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> Hi Felipe,
>
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: [PATCH] dspbridge: wait less and check the mailbox more
> Date: Sat, 21 Feb 2009 00:04:17 +0100
>
>> From: Felipe Contreras <felipe.contrers@nokia.com>
>>
>> Profiling showed the __delay function is called a lot; checking the mbox
>> more often seems to decrease the usage by 2/3 according to OProfile.
>
> Good finding.
>
>> The changes are based on 'arch/arm/plat-omap/mailbox.c'. Tested on OMAP3430.
>>
>> Also, remove HW_MBOX_IsFull since it's not used by anybody.
>
> Woundn't it be better to split this one into some logical parts,
> tunning up part(decreasing delay) and cleanup part(the others)?

I can do that, but my objective is to decrease CPU usage... increasing
the frequency of mbox checking means more calls to HW_MBOX_IsFull. So
the 'cleanup' part must be applied too for performance reasons.

> Home brewed MACROs themselves like UTIL_Wait() are basically evil from
> kernel source readibility perspective, but keeping consistency within
> specific module may be more important and this kind of cleaning up
> would be better to be done at onece over a module, in separate
> patches.

I can do that too.

Note that the author is wrong: contrers -> contreras

-- 
Felipe Contreras
