From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 5/6] ARM: OMAP4: hwmod_data: Do not get DSP out of
 reset at boot time
Date: Wed, 29 Feb 2012 09:46:25 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202290946070.10984@utopia.booyaka.com>
References: <1330096546-20477-1-git-send-email-t-kristo@ti.com>  <1330096546-20477-6-git-send-email-t-kristo@ti.com>  <alpine.DEB.2.00.1202280330140.11716@utopia.booyaka.com> <1330441528.2116.46.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46117 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286Ab2B2Qq1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 11:46:27 -0500
In-Reply-To: <1330441528.2116.46.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Tue, 28 Feb 2012, Tero Kristo wrote:

> Just tried the CSWR set on top of your branch with this patch reverted
> and it works nicely. I'll drop this patch out from the next version.

Excellent, thanks for the test.


- Paul
