From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2 03/14] ARM: OMAP3+: Implement timer workaround for
 errata i103 and i767
Date: Wed, 7 Nov 2012 17:43:24 -0600
Message-ID: <509AF21C.7020105@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com> <1352314890-22224-4-git-send-email-jon-hunter@ti.com> <509ADD28.20707@ti.com> <509AEEA4.80804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49461 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab2KGXnc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 18:43:32 -0500
In-Reply-To: <509AEEA4.80804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wednesday 07 November 2012 05:28 PM, Jon Hunter wrote:
>
> On 11/07/2012 04:14 PM, Santosh Shilimkar wrote:
>
>> Looks sensible considering alternative WAs.
>>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Thanks. With further thought I think that it would be best to combine
> patches #2 and #3. Really the main motivation here is the errata
> workaround and without actually benchmarking the timer read I should
> not claim the improvement in overhead as stated in patch #2. So I
> have combined #2 and #3 and updated the changelog/comments
> appropriately. Let me know if you guys are ok with this.
>
Yep. Sounds good.

Regards
Santosh

