From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx cleanups
Date: Mon, 30 Apr 2012 15:58:19 -0700
Message-ID: <87vckgltdg.fsf@ti.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
	<4F98740F.1020402@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:49359 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757325Ab2D3W6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 18:58:22 -0400
Received: by pbbrq2 with SMTP id rq2so3620727pbb.6
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 15:58:20 -0700 (PDT)
In-Reply-To: <4F98740F.1020402@linaro.org> (Daniel Lezcano's message of "Thu,
	26 Apr 2012 00:00:47 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 04/24/2012 04:05 PM, Daniel Lezcano wrote:
>> This patchset makes some cleanup on these cpuidle drivers
>> and consolidate the code across both architecture.
>>
>> Tested on OMAP3 (igepV2).
>> Partially tested on OMAP4 (pandaboard), without offlining the cpu1.

Without offlining CPU1, none of this code is executed.  Can you test
with CPU1 offlined?

> Hi,
>
> could be this patchset considered for inclusion ?
>

Yes.   This is a good series, and a great cleanup.

Unfortunately, there is lots of OMAP PM code to review at the moment so
there's a bit of a lag in my ability to review and test.

Tested-by tags from others on various platforms will also go a long ways
as well.

Kevin
