From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code under smp_prepare_cpus()
Date: Wed, 27 Mar 2013 12:54:09 -0700
Message-ID: <87txnw62la.fsf@linaro.org>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
	<1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com>
	<878v587kco.fsf@linaro.org> <515342D2.2080409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:38150 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab3C0TyN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 15:54:13 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so2705651dae.9
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 12:54:12 -0700 (PDT)
In-Reply-To: <515342D2.2080409@ti.com> (Santosh Shilimkar's message of "Thu,
	28 Mar 2013 00:34:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Thursday 28 March 2013 12:15 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>> 
>>> Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). 
>> 
>> Why?
>> 
> Because that code belongs to smp_prepare_cpus(). As I said
> in earlier patches, it was remainder of the pen release code
> which was borrowed from ARM code initially.

Sure, but that should be in the changelog.

Kevin
