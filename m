From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
Date: Sat, 15 Sep 2012 05:49:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209150548480.5261@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com> <alpine.DEB.2.00.1209150527080.3370@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48184 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab2IOFt5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Sep 2012 01:49:57 -0400
In-Reply-To: <alpine.DEB.2.00.1209150527080.3370@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 15 Sep 2012, Paul Walmsley wrote:

> The problem was resolved by creating recalc_rate function pointers for the 
> APLLs that return sys_ck if the APLL is bypassed, or the APLL rate if it's 
> locked, for both 2420 and 2430.

One correction - the APLL recalc functions return a zero rate if stopped, 
not the bypass rate.  This appears to be the case, from a close reading of 
the TRM.

- Paul
