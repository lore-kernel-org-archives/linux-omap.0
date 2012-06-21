From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 04/29] ARM: omap: clk: use clk_prepare_enable and clk_disable_unprepare
Date: Thu, 21 Jun 2012 11:06:06 +0530
Message-ID: <4FE2B2C6.4010904@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com> <1339678038-23082-5-git-send-email-rnayak@ti.com> <20120614191147.GP19410@gmail.com> <4FDAC07A.7020702@ti.com> <20120620114149.GG12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41317 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755216Ab2FUFgP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jun 2012 01:36:15 -0400
Received: by obbun3 with SMTP id un3so800826obb.27
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 22:36:13 -0700 (PDT)
In-Reply-To: <20120620114149.GG12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Turquette <mturquette@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 20 June 2012 05:11 PM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120614 22:01]:
>> On Friday 15 June 2012 12:41 AM, Mike Turquette wrote:
>>> On 20120614-18:16, Rajendra Nayak wrote:
>>>> As we move to Common clk framework use clk_prepare_enable()
>>>> instead of clk_enable() and similarly clk_disable_unprepare()
>>>> instead of clk_disable()
>>>>
>>>> Based on initial changes from Mike turquette.
>
> Sounds like these kind of patches should be a separate series
> to prepare for the common clk fwk conversion? It seems these
> could already get merged separately?

yes, I will post them out separately as a preparatory series for
CCF conversion.

I also have some to get rid of the omap_clk_get_by_name() usage and
direct dereferencing of 'struct clk'.

Paul, are you ok to look at them as preparatory patches for CCF
conversion too?

>
> Tony

