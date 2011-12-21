From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Wed, 21 Dec 2011 13:12:57 +0100
Message-ID: <4EF1CD49.9020800@linux.intel.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com> <4EF1A0B4.5080307@linux.intel.com> <CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw@mail.gmail.com> <4EF1AA8A.8060304@linux.intel.com> <CAMbhsRSNTUvou9Gf6T4Ggq=jfxsWUcn7M2yNsKQz6aNrt6gLDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3119 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab1LUMNB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Dec 2011 07:13:01 -0500
In-Reply-To: <CAMbhsRSNTUvou9Gf6T4Ggq=jfxsWUcn7M2yNsKQz6aNrt6gLDg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Trinabh Gupta <g.trinabh@gmail.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org

On 12/21/2011 10:55 AM, Colin Cross wrote:
> On Wed, Dec 21, 2011 at 1:44 AM, Arjan van de Ven <arjan@linux.intel.com> wrote:
>> On 12/21/2011 10:40 AM, Colin Cross wrote:
>>
>>>> this smells fundamentally racey to me; you can get an interrupt one
>>>> cycle after you think you're done, but before the last guy enters WFI...
>>>>
>>>> how do you solve that issue ?
>>>
>>> All the cpus have interrupts off when they increment the counter, so
>>> they cannot receive an interrupt.  If an interrupt is pending on one
>>> of those cpus, it will be handled later when WFI aborts due to the
>>> pending interrupt.
>>
>> ... but this leads to cases where you're aborting before other cpus are
>> entering..... so your "last guy in" doesn't really work, since while cpu
>> 0 thinks it's the last guy, cpu 1 is already on the way out/out
>> already...  (heck it might already be going back to sleep if your idle
>> code can run fast, like in the size of a cache miss)
> 
> Once a cpu has incremented the counter, it has no way out unless either
> 1: another cpu (that hasn't incremented the counter yet) receives an
> interrupt, aborts idle, and clears its idle flag
> or
> 2: all cpus enter the ready counter, and call the cpuidle driver's
> enter function.

.. or it enters WFI, and a physical device sends it an interrupt,
at which point it exits.
