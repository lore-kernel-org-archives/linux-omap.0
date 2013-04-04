From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 16/18] ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()
Date: Thu, 4 Apr 2013 19:29:09 +0530
Message-ID: <515D872D.9070404@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-17-git-send-email-santosh.shilimkar@ti.com> <876203qos1.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48186 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761385Ab3DDN5H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 09:57:07 -0400
In-Reply-To: <876203qos1.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 03:07 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Current OMAP4 CPUIdle driver is using omap4_mpuss_read_prev_context_state()
>> function to check whether the MPU cluster lost context or not. Thanks to
>> couple CPUIdle, cluster low power entry is almost guaranteed and hence
>> the programmed cluster check is enough in idle exit path. The API was
>> more of an optimization for corner cases, where if the cluster low power
>> entry fails for some reason, the cluster context restore gets skipped.
>>
>> Moving forward, OMAP CPUidle drivers needs to be moved to drivers/idle/*
>> once the PRM/CM code gets moved to drivers. This patch also reduces one
>> dependency with platform code for idle driver movement.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Looks good, but I find the changelog a bit confusing.
> 
> Below is a slightly modified patch (I only modified the changelog).  If
> those changes are OK with you, I'll add it to my cpuidle branch as well.
> 
Looks good to me Kevin. Thanks for the change-log update.

Regards,
Santosh

