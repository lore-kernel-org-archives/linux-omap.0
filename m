From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] omap fixes for v2.6.38-rc6
Date: Tue, 01 Mar 2011 14:48:45 -0800
Message-ID: <87aahefodu.fsf@ti.com>
References: <20110228194151.GJ20560@atomide.com>
	<alpine.DEB.1.10.1103011931380.27610@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:40275 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753233Ab1CAWss (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 17:48:48 -0500
In-Reply-To: <alpine.DEB.1.10.1103011931380.27610@esdhcp041196.research.nokia.com>
	(Aaro Koskinen's message of "Tue, 1 Mar 2011 19:39:01 +0200 (EET)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> Hi,
>
> On Mon, 28 Feb 2011, Tony Lindgren wrote:
>> Please pull omap fixes from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus
>>
>> This contains one more timer regression fix, a DPLL rate fix,
>> and a mailbox NULL pointer fix that would be good to get
>> in for 2.6.38. The series also removes world-writable flag for
>> some debugfs entries.
>>
>> Other than I believe that's it for omap fixes for v2.6.38.
>
> I wonder what happened to this patch:
>
> 	http://marc.info/?l=linux-omap&m=129772313519005&w=2
>

I have it queued with some other PM fixes that I haven't (yet) pushed to
Tony due to being on vacation.

Will take care of that today or tomorrow at the latest.

Kevin
