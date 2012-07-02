From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: cm-t35: add mt9t001 camera sensor
 support
Date: Mon, 2 Jul 2012 01:15:38 -0700
Message-ID: <20120702081537.GE1122@atomide.com>
References: <1339592110-14312-1-git-send-email-lifshitz@compulab.co.il>
 <1339592110-14312-2-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38850 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab2GBIPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 04:15:40 -0400
Content-Disposition: inline
In-Reply-To: <1339592110-14312-2-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

* Dmitry Lifshitz <lifshitz@compulab.co.il> [120613 06:00]:
> Setup pinmux for CPI and register the mt9t001 camera sensor
> in ISP subsystem.

Applying both into devel-board branch. Note that we are phasing
out the board-*.c files with device tree support, so only minimal
changes will be applied to the board-*.c files at this point.

Regards,

Tony
