From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/16] OMAP3: Populate scratchpad contents
Date: Wed, 29 Oct 2008 16:35:37 -0700
Message-ID: <4908F349.2050100@deeprootsystems.com>
References: <01f901c91fd2$06570810$LocalHost@wipultra1382> <87skqf6r48.fsf@deeprootsystems.com> <13B9B4C6EF24D648824FF11BE89671620369796DED@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.158]:10693 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbYJ2Xfm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 19:35:42 -0400
Received: by po-out-1718.google.com with SMTP id y22so5610916pof.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 16:35:40 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620369796DED@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Woodruff, Richard wrote:
>>> +   arm_context_addr = io_v2p(omap3_arm_context);
> 
>> strange is how the code is still working.
> 
> Probably just corrupts some DDR a bit higher up.

Hmm, "just" corrupting memory?  ;)

I assume memory is being corrupted, but it also given an address in the 
virtual memory map of the kernel.  How is the ROM code halding a virtual 
address?  Just ignoring the upper bits?

>> I believe what is intented is for arm_context_addr to be a physical
>> memory address, right?  I've converted this to virt_to_phys().
> 
> Yes virt_to_phys() should be here.  Current 2.6.24 kernel's do it this way also.

Which begs the question why the patch sent to the list is using io_p2v() 
introducing a bug which was only caught by accident because it also 
introduced a compiler warning.

Kevin
