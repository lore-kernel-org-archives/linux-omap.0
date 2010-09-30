From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH] ARM: add cpu_idle_wait() to support CPUidle on SMP systems.
Date: Thu, 30 Sep 2010 11:04:28 -0700
Message-ID: <AANLkTi=EkQNd4JFrwCY1qH6XOq0+O_5ZuxaJY1dQg=cw@mail.gmail.com>
References: <1285692192-32075-1-git-send-email-khilman@deeprootsystems.com>
	<87hbh7f9dl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:43462 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab0I3SEs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 14:04:48 -0400
Received: from kpbe16.cbf.corp.google.com (kpbe16.cbf.corp.google.com [172.25.105.80])
	by smtp-out.google.com with ESMTP id o8UI4jHK022467
	for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 11:04:45 -0700
Received: from pzk36 (pzk36.prod.google.com [10.243.19.164])
	by kpbe16.cbf.corp.google.com with ESMTP id o8UI4TA3015496
	for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 11:04:33 -0700
Received: by pzk36 with SMTP id 36so1402950pzk.40
        for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 11:04:28 -0700 (PDT)
In-Reply-To: <87hbh7f9dl.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 30, 2010 at 10:07 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Russell,
>
> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
>> In order for CPUidle to work on SMP systems, an implementation of
>> cpu_idle_wait() is needed.
>>
>> This patch duplicates the x86 implementation of cpu_idle_wait() for
>> ARM.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> Are you OK with this for the patch system for 2.6.37?

Tested-by: Colin Cross <ccross@android.com>

CPUidle works on Tegra2 with this patch.
