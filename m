From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] OMAP: hwmod: add read/write API for SYSCONFIG
Date: Wed, 13 Jan 2010 18:26:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001131822440.4769@utopia.booyaka.com>
References: <1262993213-19866-1-git-send-email-khilman@deeprootsystems.com> <1262993213-19866-2-git-send-email-khilman@deeprootsystems.com> <1262993213-19866-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41282 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab0ANB0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 20:26:05 -0500
In-Reply-To: <1262993213-19866-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin, 

On Fri, 8 Jan 2010, Kevin Hilman wrote:

> Some HW blocks have errata which requires selective enabling/disabling
> of SYSCONFIG bits.  In particular, some blocks have known issues with
> smart-idle so smart-idle has to be disabled under certain conditions.

...

> RFC: would an API to only touch smart-idle be more appropriate? Maybe 
> omap_hwmod_smart_idle_enable(oh, bool enable)?

This idea sounds good.  Since the SYSCONFIG bit fields can change and move 
around depending on the chip and IP, some type of higher-level API seems 
necessary to preserve sanity.

Maybe omap_hwmod_smart_idle_enable() and omap_hwmod_smart_idle_disable(), 
mimicking API styles like clk_enable()/clk_disable(), etc.?  Care to spin 
something like that?


- Paul
