From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: hwmod: add support for blocking WFI
 when a device is active
Date: Mon, 31 Dec 2012 18:40:46 +0530
Message-ID: <50E18ED6.30802@ti.com>
References: <20121230182745.30526.47072.stgit@dusk.lan> <20121230182829.30526.32914.stgit@dusk.lan> <50E14C12.5020105@ti.com> <alpine.DEB.2.00.1212311254570.27120@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59894 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2LaNKA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Dec 2012 08:10:00 -0500
In-Reply-To: <alpine.DEB.2.00.1212311254570.27120@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 31 December 2012 06:26 PM, Paul Walmsley wrote:
> Hi
>
> On Mon, 31 Dec 2012, Santosh Shilimkar wrote:
>
>> This is more of question. If the limitation is w.r.t MPU power
>> state then shouldn't we just prevent the MPU power state rather
>> than blocking the WFI completely.
>>
>> Can you please clarify if retaining MPU power state in ON can achieve
>> the same results ?
>
> In these cases, it's blocking WFI that is apparently needed.  I know it
> doesn't make much sense.
>
Ya. It doesn't make sense but if that is the case then the patch make
sense :-)

Thanks for clarification !!

Regards
Santosh

