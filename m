From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 1/2] remoteproc: use a flag to detect the presence
 of IOMMU
Date: Fri, 13 Mar 2015 18:35:39 -0500
Message-ID: <5503744B.1040700@ti.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com> <1420838519-15669-2-git-send-email-s-anna@ti.com> <CAK=WgbawMvc5Td-1+eEv3+BJWCUwHeZskJwDTPUaD66RT6EOxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37409 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033AbbCMXgF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Mar 2015 19:36:05 -0400
In-Reply-To: <CAK=WgbawMvc5Td-1+eEv3+BJWCUwHeZskJwDTPUaD66RT6EOxw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Robert Tivy <rtivy@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>

On 03/12/2015 04:04 AM, Ohad Ben-Cohen wrote:
> On Fri, Jan 9, 2015 at 11:21 PM, Suman Anna <s-anna@ti.com> wrote:
>> The remoteproc driver core currently relies on iommu_present() on
>> the bus the device is on, to perform MMU management. However, this
>> logic doesn't scale for multi-arch, especially for processors that
>> do not have an IOMMU. Replace this logic instead by using a h/w
>> capability flag for the presence of IOMMU in the rproc structure.
>>
>> This issue is seen on OMAP platforms when trying to add a remoteproc
>> driver for a small Cortex M3 called the WkupM3 used for suspend /
>> resume management on TI AM335/AM437x SoCs. This processor does not
>> have an MMU. Same is the case with another processor subsystem
>> PRU-ICSS on AM335/AM437x. All these are platform devices, and the
>> current iommu_present check will not scale for the same kernel image
>> to support OMAP4/OMAP5 and AM335/AM437x.
>>
>> The existing platform implementation drivers - OMAP remoteproc, STE
>> Modem remoteproc and DA8xx remoteproc, are updated as well to properly
>> configure the newly added rproc field.
>>
>> Cc: Robert Tivy <rtivy@ti.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> Applied to remoteproc's for-next branch.
> 

Thanks Ohad. Can you pick up the minor checkpatch fixes I posted as well
for 4.1?

regards
Suman
