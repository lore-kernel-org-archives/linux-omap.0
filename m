From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Thu, 31 May 2012 13:49:48 -0500
Message-ID: <4FC7BD4C.7090808@ti.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com> <87wr3uelgp.fsf@ti.com> <4FC548A3.2040906@ti.com> <4FC54D3B.10301@ti.com> <87pq9l7306.fsf@ti.com> <20120531012923.GB8506@mudshark.cambridge.arm.com> <4FC788D1.5080009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51168 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab2EaSt5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 14:49:57 -0400
In-Reply-To: <4FC788D1.5080009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>


On 05/31/2012 10:05 AM, Jon Hunter wrote:
> Hi Will,
> 
> On 05/30/2012 08:29 PM, Will Deacon wrote:
>> Hi Kevin,
>>
>> On Wed, May 30, 2012 at 10:50:01PM +0100, Kevin Hilman wrote:
>>> Basically, I don't like the result when we have to hack around missing
>>> runtime PM support for a driver, so IMO, the driver should be updated.
>>>
>>> IOW, it looks to me like the armpmu driver should grow runtime PM
>>> support.  The current armpmu_release|reserve should probably be replaced
>>> with runtime PM get/put, and the functionality in those functions would
>>> be the runtime PM callbacks instead.
>>>
>>> Will, any objections to armpmu growing runtime PM support?
>>
>> My plan for the armpmu reservation is to kill the global reservation scheme
>> that we currently have and push those function pointers into the arm_pmu,
>> so that fits with what you'd like.
>>
>> The only concern I have is that we need the mutual exclusion even when we
>> don't have support for runtime PM. If we can solve that then I'm fine with
>> the approach.
> 
> I am not sure I follow your last point. Can you elaborate a little more?

By the way, I do see your point now. I have just posted a very simple PM
runtime adaption, which I am not sure if this is exactly what you and
Kevin have in mind. However, with this implementation we would not need
to worry about the mutual exclusion as we don't change the flow.
Alternatively, the reserve_pmu() call could be done outside of the
runtime pm callbacks.

Cheers
Jon
