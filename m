From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM: Fix the dt return condition in pm_late_init()
Date: Fri, 8 Feb 2013 21:06:11 +0530
Message-ID: <51151B6B.9000505@ti.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1302081533270.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47257 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754926Ab3BHPe5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 10:34:57 -0500
In-Reply-To: <alpine.DEB.2.00.1302081533270.28008@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>

On Friday 08 February 2013 09:04 PM, Paul Walmsley wrote:
> On Fri, 8 Feb 2013, Santosh Shilimkar wrote:
>
>> Commit 1416408d {ARM: OMAP2+: PM: share some suspend-related functions
>> across OMAP2, 3, 4} moved suspend code to common place but now with
>> that change, for DT build on OMAP4, suspend hooks are not getting
>> registered which results in no suspend support.
>>
>> The DT return condition is limited to PMIC and smartreflex
>> initialization and hence restrict it so that suspend ops gets
>> registered.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Thanks, queued here with Felipe's Reviewed-by: along with the other OMAP4
> PM fixes.
>
Thanks Paul !!

Regards,
Santosh

