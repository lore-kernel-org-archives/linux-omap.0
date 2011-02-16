From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 0/3] OMAP2+ hwmod fixes
Date: Wed, 16 Feb 2011 19:13:12 +0530
Message-ID: <6cc4b2788ff1e15c22987d5db91f0395@mail.gmail.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com> <4D5BCC10.2060301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36640 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751791Ab1BPNnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 08:43:14 -0500
Received: by mail-fx0-f54.google.com with SMTP id 16so1418834fxm.27
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 05:43:13 -0800 (PST)
In-Reply-To: <4D5BCC10.2060301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Hi Benoit,

> -----Original Message-----
> From: Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: Wednesday, February 16, 2011 6:37 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com;
linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 0/3] OMAP2+ hwmod fixes
>
> Hi Rajendra,
>
> On 2/16/2011 1:11 PM, Nayak, Rajendra wrote:
> > This series fixes some hwmod api return values
> > and also adds some state checks.
> > The hwmod iterator functions are made to
> > continue and not break if one of the
> > callback functions ends up with an error.
>
> By doing that, you change the behavior of this function.
> I'm not sure I fully understand why.
> Could you elaborate on the use case?

Since these functions iterate over all hwmods
calling a common callback function, there might
be cases wherein the callback function for *some*
hwmods might fail. For instance, if you run through
all hwmods and try to clear the context registers
for all of them, for some hwmods which might
not have context registers the callback function
might return a -EINVAL, however that should not
stop you from attempting to clear the context
registers for the rest of the hwmods which have
them and abort the function midway, no?
This is more hypothetical, however the real usecase
that prompted me with this patch was when I
had some wrong state check in _setup function,
and the iterator would stop with the first failure
and not even attempt to setup the rest of the
hwmods.

>
> To avoid that behavior in the past, I was just returning
> 0 in case of failure to avoid stopping the iteration.
> It looks like you do not want to stop the iteration but still
> retrieve the error.
> I do not see in this series what you plan to do with the
> error at the end of the iteration.

Most users of these iterators would just use the non-zero
return value to throw an error/warning out stating there
were failures running through all the callback functions.
That does not change with this patch, and they can still
do it.

Regards,
Rajendra

>
> Thanks,
> Benoit
