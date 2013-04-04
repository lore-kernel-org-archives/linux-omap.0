From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 14/18] ARM: OMAP4: CPUidle: Make C-state description
 field more precise
Date: Thu, 4 Apr 2013 19:18:19 +0530
Message-ID: <515D84A3.6070007@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-15-git-send-email-santosh.shilimkar@ti.com> <87vc83s4sv.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47539 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760451Ab3DDNqS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 09:46:18 -0400
In-Reply-To: <87vc83s4sv.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 02:35 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> It is useful to know the CPU power state along with MPUSS power state
>> in a supported C-state. Since the data is available via sysfs, one can
>> avoid scrolling the source code for precise construction of C-state.
>>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Nice.
> 
> Adding to for_3.10/fixes/cpuidle branch.
> 
Thanks.

regards,
Santosh
