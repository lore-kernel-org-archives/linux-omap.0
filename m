From: Kevin Hilman <khilman@mvista.com>
Subject: Re: PM Issues after Android bootup on 2430
Date: Thu, 01 May 2008 14:47:55 -0700
Message-ID: <87d4o5elx0.fsf@paris.hilman.org>
References: <70E3BF80B2DA6E469688AD5C3BBCC6C40365F3B7@BLR-EC-MBX02.wipro.com>
	<782515bb0804291818w2296bdcajc026f3ab6e6af96a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:55368 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835AbYEAVr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 May 2008 17:47:57 -0400
In-Reply-To: <782515bb0804291818w2296bdcajc026f3ab6e6af96a@mail.gmail.com> (Nishanth Menon's message of "Tue\, 29 Apr 2008 20\:18\:56 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "shivananda.hebbarp@wipro.com" <shivananda.hebbarp@wipro.com>, linux-omap@vger.kernel.org

"Nishanth Menon" <menon.nishanth@gmail.com> writes:

> On 4/29/08, shivananda.hebbarp@wipro.com <shivananda.hebbarp@wipro.com> wrote:
>> omapfb omapfb: irq error status 00e2
>> omapfb omapfb: irq error status 0040
>> omapfb omapfb: irq error status 0040
>> omapfb omapfb: irq error status 0040
>> omapfb omapfb: irq error status 0040
>> omapfb omapfb: irq error status 0040
>> omapfb omapfb: irq error status 0040
>> omapfb omapfb: irq error status 0040
>> omapfb omapfb: irq error status 0040
>> omapfb omapfb: irq error status 0040
> This does look suspiciously like the thread
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-July/010566.html
>
> Interesting... ;)... I never got the chance to debug this issue..
>
> Kevin, Khasim, did u guys get a chance to look at this later?? I dont
> recollect hearing any one saying the same for 3430 though..

No, I never debugged this any further.  AFAIK, the omapfb is still
broken in git.

Kevin

