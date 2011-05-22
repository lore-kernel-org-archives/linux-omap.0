From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] cleanup regulator supply definitions in mach-omap2 to
 use REGULATOR_SUPPLY
Date: Mon, 23 May 2011 06:56:38 +0800
Message-ID: <20110522225636.GC15882@opensource.wolfsonmicro.com>
References: <1306101529-22013-1-git-send-email-green@linuxhacker.ru>
 <20110522224510.GA15858@opensource.wolfsonmicro.com>
 <13FCB0DC-28DB-4AC5-A08A-D8A71AA8D031@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49217 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755384Ab1EVW4n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 May 2011 18:56:43 -0400
Content-Disposition: inline
In-Reply-To: <13FCB0DC-28DB-4AC5-A08A-D8A71AA8D031@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, May 22, 2011 at 06:49:26PM -0400, Oleg Drokin wrote:

> If I end-up with a new version of the patch, what do you think would be best as a divisor
> between the patches? Just have ~half of changes split into another patch or do you have any other ideas?

Split the changes to not set .dev out from the changes to use
REGULATOR_SUPPLY().  It's much easier to read big block changes like
this when you get a big set of exactly the same change rather than a mix
of different changes.
