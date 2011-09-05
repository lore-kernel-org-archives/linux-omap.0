From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 05/25] OMAP4: Use WARN_ON() instead of BUG_ON() with graceful
 exit
Date: Mon, 05 Sep 2011 16:21:25 +0530
Message-ID: <4E64A9AD.7030206@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-6-git-send-email-santosh.shilimkar@ti.com> <4E64A040.4000801@ru.mvista.com> <4E64A77A.10400@ti.com> <20110905104755.GC6918@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:43369 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752322Ab1IEKvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 06:51:32 -0400
Received: by gxk26 with SMTP id 26so3167717gxk.4
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 03:51:30 -0700 (PDT)
In-Reply-To: <20110905104755.GC6918@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-omap@vger.kernel.org, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Monday 05 September 2011 04:17 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 05, 2011 at 04:12:02PM +0530, Santosh wrote:
>> On Monday 05 September 2011 03:41 PM, Sergei Shtylyov wrote:

[..]

>>>> /* Static mapping, never released */
>>>> l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
>>>> - BUG_ON(!l2cache_base);
>>>> + if (WARN_ON(!l2cache_base))
>>>> + return -ENODEV;
>>>
>>> Rather ENOMEM...
>>>
>> Nope. Even though it's related to memory, it's
>> a memory controller so DEV is right.
>
> No it's not.  The most likely reason ioremap() fails is because:
>
> 1. it's run out of memory for the metadata or page tables.
> 2. you passed it an invalid memory type (unlikely, you're using ioremap
>     which uses a fixed known good type).
> 3. the address was>4GB but was not section aligned (also unlikely).
>
> Therefore, the error code should be "out of memory" not "no such device".
Got it. Will fix that.
