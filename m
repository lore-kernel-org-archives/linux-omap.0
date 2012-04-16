From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Mon, 16 Apr 2012 10:45:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204161045370.29048@utopia.booyaka.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com> <1334579125-15566-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab2DPQpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 12:45:49 -0400
In-Reply-To: <1334579125-15566-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

On Mon, 16 Apr 2012, Tarun Kanti DebBarma wrote:

> We do not use iclk anywhere in the dmtimer driver and so removing it.
> Hence removing the timer iclk entries from OMAP4 clkdev table as well.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Thanks, queued for 3.5.

- Paul
