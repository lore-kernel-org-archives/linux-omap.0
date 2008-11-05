From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 clock: fix non-CORE DPLL rate assignment bugs
Date: Wed, 05 Nov 2008 15:43:43 -0800
Message-ID: <49122FAF.1020109@deeprootsystems.com>
References: <alpine.DEB.2.00.0810171617420.3833@utopia.booyaka.com> <49075870.9020804@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:45350 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbYKEXnq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 18:43:46 -0500
Received: by rv-out-0506.google.com with SMTP id k40so292558rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 05 Nov 2008 15:43:45 -0800 (PST)
In-Reply-To: <49075870.9020804@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, rick@efn.org, timo.t.kokkonen@nokia.com, sakari.poussa@nokia.com

Kevin Hilman wrote:
> Paul Walmsley wrote:
>> Commit 8b1f0bd44fe490ec631230c8c040753a2bda8caa introduced a bug that
>> caused non-CORE DPLL rates to be incorrectly set on boot in
>> omap3_noncore_dpll_enable().  Debugged by Tomi Valkeinen
>> <tomi.valkeinen@nokia.com> - thanks Tomi.
>>
>> Also fix omap3_noncore_dpll_set_rate() to assign clk->rate after a
>> DPLL reprogram.
>>
>> Tested on 3430SDP.
> 
> FYI, This patch breaks the ability to come out of retention in dynamic 
> idle, but I haven't yet discovered why.
> 

It appears this is related to the UART patches being used in the PM 
branch, and not this patch.

I have a (forthcoming) set of UART updates that will allow the UART to 
disable its clocks and enable the chip to hit retention.

Kevin


