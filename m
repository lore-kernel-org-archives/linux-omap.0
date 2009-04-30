From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: LDP support
Date: Thu, 30 Apr 2009 19:28:11 +0200
Message-ID: <97E57323-C0CC-4DD1-BBCB-A590A16EC48A@student.utwente.nl>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com>
Mime-Version: 1.0 (iPhone Mail 5H11)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:45650 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045AbZEAJM3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 May 2009 05:12:29 -0400
In-Reply-To: <20090428224237.GT22457@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>



Op 29 apr 2009 om 00:42 heeft Tony Lindgren <tony@atomide.com> het  
volgende geschreven:\

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090428 15:07]:
>> Tony, et.al.,
>>
>> Any ideas when more LDP support will be pushed into mainline (such as
>> the framebuffer support)?
>
> I'll be looking at the board-*.c patches for the next merge window
> hopefully this week or next week.
>
> Looks like LDP keyboard, touchscreen

The ts is pretty much unusable in 2.6.29, haven't tried .30rc yet

Regards,

Koen



> & RTC are pretty much ready
> to go. Then the MMC has some regulator updates, but AFAIK the MMC
> should work OK already.
>
> For the framebuffer, Imre and Tomi know the status the best, so
> I've added them to Cc.
>
> Imre has been meaning to send a bunch of drivers/video/omap changes
> to the fbdev list for a while now and LDP framebuffer may depend on
> those. Imre, any news on the status of sending the fb patches
> upstream?
>
> Then there are the upcoming DSS patches from Tomi, but those still
> need some work before they're ready to go.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
