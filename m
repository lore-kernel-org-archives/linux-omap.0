From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 1/4] ARM: OMAP3: cpuidle: Remove unused MPU OSWR support
 code
Date: Mon, 23 Jul 2012 12:40:02 +0530
Message-ID: <500CF8CA.10809@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com> <1342764284-8143-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1207201222250.14390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:55065 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753156Ab2GWHKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jul 2012 03:10:08 -0400
Received: by obbwd20 with SMTP id wd20so12455250obb.37
        for <linux-omap@vger.kernel.org>; Mon, 23 Jul 2012 00:10:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207201222250.14390@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, t-kristo@ti.com

Hi Paul,

On Friday 20 July 2012 11:55 PM, Paul Walmsley wrote:
> On Fri, 20 Jul 2012, Rajendra Nayak wrote:
>
>> We do not support MPU OSWR on OMAP3. Get rid of the complex/multiple
>> save_state handling in omap_sram_idle() and just use 2 save_state
>> definitions
>>
>> save_state = 1, all logic and memory lost, MPU hits OFF
>> save_state = 0, nothing lost, MPU hits CSWR or shallower state
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> The code is certainly simpler, but I recall seeing patchsets in the past
> that implemented OSWR on OMAP3.  (Not sure which powerdomains it was
> implemented for.)  Do you know what the status of those patchsets are?

OMAP3 supports OSWR for MPU/IVA/CORE and PER powerdomains. Though we did
have some OSWR implementations in our internal trees, we never ended up
using them effectively, mainly because the latencies for OSWR as
compared to OFF were very close on OMAP3 and the power savings from OFF
(given we could hit 0v) significantly higher.

OSWR on OMAP4 was hence reworked to keep much more retained in OSWR and
make it, in latency terms, something _in_between_ a CSWR and OFF.

Someone at some point (I don't recall and it could have even been me)
would have tried to upstream the OSWR support from our internal trees,
but as of now I don't know if anyone is trying to push or interested in
OSWR support for OMAP3 anymore.

regards,
Rajendra

>
> - Paul

