From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH] cleanup regulator supply definitions in mach-omap2 to use REGULATOR_SUPPLY
Date: Sun, 22 May 2011 18:49:26 -0400
Message-ID: <13FCB0DC-28DB-4AC5-A08A-D8A71AA8D031@linuxhacker.ru>
References: <1306101529-22013-1-git-send-email-green@linuxhacker.ru> <20110522224510.GA15858@opensource.wolfsonmicro.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:42639 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755900Ab1EVWtf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 May 2011 18:49:35 -0400
In-Reply-To: <20110522224510.GA15858@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello!

On May 22, 2011, at 6:45 PM, Mark Brown wrote:

> Note that it'd be better to split into two patches as it makes review
> easier.

If I end-up with a new version of the patch, what do you think would be best as a divisor
between the patches? Just have ~half of changes split into another patch or do you have any other ideas?

Thanks.

Bye,
    Oleg