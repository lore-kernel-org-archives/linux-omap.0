From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 0/2] Couple of DRA7 hwmod patches on Timers
Date: Mon, 23 Mar 2015 11:30:13 -0500
Message-ID: <55103F95.5070100@ti.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com> <alpine.DEB.2.02.1503211939340.2512@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51841 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbbCWQak (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Mar 2015 12:30:40 -0400
In-Reply-To: <alpine.DEB.2.02.1503211939340.2512@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

>> Following are couple of DRA7 hwmod patches for the GPTimers.
>> Patches based on 4.0-rc1.
>>
>> The first patch adds the data for timers 13 through 16, the DT
>> nodes are already present, and when enabled without the hwmod
>> data triggers a l3_noc interrupt and hangs the kernel boot [1].
>> The boot hang can also be fixed by checking the return status
>> of pm_runtime_get_sync() in the OMAP dmtimer probe, I will post
>> a separate fix for that.
>>
>> Second patch is a minor fix.
> 
> Thanks.  Sounds like the first one should go in for v4.0-rc fixes, and the 
> second one can wait for v4.1?  
> 
> If so then could you repost the first fix to include the description of 
> why it should go in early in the patch description ("the DT nodes are 
> already present, and when enabled without the hwmod data triggers a l3_noc 
> interrupt and hangs the kernel boot").  That should avoid anyone 
> questioning why it would go in as a v4.0-rc fix at this point, and should 
> help the -stable crew out.

Actually, both of them can be queued for v4.1. Tony has already sent a
pull request with the fixes [1] in the driver. The driver fixes will
scale for all SoCs, so will fix this boot issue as well if anyone tries
to enable these timers.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=142661461902725&w=2

