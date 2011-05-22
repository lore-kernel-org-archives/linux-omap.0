From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] cleanup regulator supply definitions in mach-omap2 to
 use REGULATOR_SUPPLY
Date: Mon, 23 May 2011 06:45:12 +0800
Message-ID: <20110522224510.GA15858@opensource.wolfsonmicro.com>
References: <1306101529-22013-1-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54907 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752795Ab1EVWpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 May 2011 18:45:18 -0400
Content-Disposition: inline
In-Reply-To: <1306101529-22013-1-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>, Nishant Kamat <nskamat@ti.com>, Steve Sakoman <steve@sakoman.com>, Mikkel Christensen <mlc@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Sun, May 22, 2011 at 05:58:49PM -0400, green@linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> Also drop old style supply.dev assignments common in hsmmc init
> as no longer needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Note that it'd be better to split into two patches as it makes review
easier.
