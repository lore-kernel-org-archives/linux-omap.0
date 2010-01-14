From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP: hwmod: add read/write API for SYSCONFIG
Date: Thu, 14 Jan 2010 10:07:34 -0800
Message-ID: <87ockwa7bt.fsf@deeprootsystems.com>
References: <1262993213-19866-1-git-send-email-khilman@deeprootsystems.com>
	<1262993213-19866-2-git-send-email-khilman@deeprootsystems.com>
	<1262993213-19866-3-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1001131822440.4769@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47103 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0ANSPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 13:15:21 -0500
Received: by pzk1 with SMTP id 1so8522278pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 14 Jan 2010 10:15:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1001131822440.4769@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 13 Jan 2010 18\:26\:04 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin, 
>
> On Fri, 8 Jan 2010, Kevin Hilman wrote:
>
>> Some HW blocks have errata which requires selective enabling/disabling
>> of SYSCONFIG bits.  In particular, some blocks have known issues with
>> smart-idle so smart-idle has to be disabled under certain conditions.
>
> ...
>
>> RFC: would an API to only touch smart-idle be more appropriate? Maybe 
>> omap_hwmod_smart_idle_enable(oh, bool enable)?
>
> This idea sounds good.  Since the SYSCONFIG bit fields can change and move 
> around depending on the chip and IP, some type of higher-level API seems 
> necessary to preserve sanity.
>
> Maybe omap_hwmod_smart_idle_enable() and omap_hwmod_smart_idle_disable(), 
> mimicking API styles like clk_enable()/clk_disable(), etc.?  Care to spin 
> something like that?

Sounds good, Coming right up....

Kevin
