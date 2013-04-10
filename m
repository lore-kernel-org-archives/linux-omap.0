From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 2/4] ARM: OMAP4+: PM: Consolidate OMAP4 PM code to
 re-use it for OMAP5
Date: Wed, 10 Apr 2013 11:47:15 +0530
Message-ID: <516503EB.8080805@ti.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com> <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com> <20130405213433.GF10155@atomide.com> <5162A093.7090808@ti.com> <20130408164228.GK10155@atomide.com> <5163B19E.30105@ti.com> <20130409165503.GM10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54634 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab3DJGPP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 02:15:15 -0400
In-Reply-To: <20130409165503.GM10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 09 April 2013 10:25 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130408 23:16]:
>>>
>> As I said, the IP has been there from OMAP2XX days. Here the case that
>> IP version is very similar between OMAP4, OMAP5. DRA(next SOC) and its
>> derivatives. Hence can share most of the code. I thought this was good
>> enough reason considering at least 4 family of SOC's can make use
>> of the code.
> 
> Well at least that might be enough of a reasoning to rename it as
> it is somewhat futureproof.
>
Yep. I can't see to much further in future but there is a *strong*
mandate to not break compatibility so hopefully we won't see too
much churn for similar IP blocks in future. 
  
>> It has nothing to do with SMP etc specifically and rather the similarity
>> between the PM infrastructure on the mentioned SOCs. 
>>
>> Let me know if you can suggested better name than what I chose ?
> 
> Not really except something like pm-iprevXXX.[chS] where the rev is
> the first revision that it works with?
> 
> But then again if it's touching registers all over the place directly,
> that naming does not make much sense either :)
> 
Exactly. Thanks for the discussion. I will go ahead with rename
when we add OMAP5 stuff like I did in earlier patch.
i.e
pm44xx.c --> pm_omap4plus.c
sleep44xx.S --> sleep_omap4plus.S

Regrads,
Santosh

