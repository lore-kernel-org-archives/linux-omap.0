From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: add cpu_idle_wait() to support CPUidle on SMP systems.
Date: Fri, 01 Oct 2010 14:15:58 -0700
Message-ID: <87sk0p7gxd.fsf@deeprootsystems.com>
References: <1285692192-32075-1-git-send-email-khilman@deeprootsystems.com>
	<87hbh7f9dl.fsf@deeprootsystems.com>
	<AANLkTi=EkQNd4JFrwCY1qH6XOq0+O_5ZuxaJY1dQg=cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60465 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab0JAVQB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:16:01 -0400
Received: by pwj5 with SMTP id 5so657313pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 14:16:01 -0700 (PDT)
In-Reply-To: <AANLkTi=EkQNd4JFrwCY1qH6XOq0+O_5ZuxaJY1dQg=cw@mail.gmail.com>
	(Colin Cross's message of "Thu, 30 Sep 2010 11:04:28 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Colin Cross <ccross@google.com> writes:

> On Thu, Sep 30, 2010 at 10:07 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Russell,
>>
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>
>>> In order for CPUidle to work on SMP systems, an implementation of
>>> cpu_idle_wait() is needed.
>>>
>>> This patch duplicates the x86 implementation of cpu_idle_wait() for
>>> ARM.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Are you OK with this for the patch system for 2.6.37?
>
> Tested-by: Colin Cross <ccross@android.com>
>
> CPUidle works on Tegra2 with this patch.

Thanks for testing.

Patch is now queued in Russell's patch system as 6428/1

   http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6428/1

Kevin
