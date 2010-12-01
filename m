From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] OMAP: DMA: prevent races while setting M idle mode to nostandby
Date: Wed, 1 Dec 2010 14:21:34 +0200
Message-ID: <201012011421.34412.peter.ujfalusi@nokia.com>
References: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>  <20101130132347.13286.40388.sendpatchset@ahunter-work.research.nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:40547 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab0LAMWA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 07:22:00 -0500
In-Reply-To: <20101130132347.13286.40388.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter Adrian (Nokia-MS/Helsinki)" <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Manjunatha GK <manjugk@ti.com>, Santosh Shilimkar <Santosh.shilimkar@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Tuesday 30 November 2010 15:23:47 Hunter Adrian (Nokia-MS/Helsinki) wrote:
> From 8c0f4490d93b67326ff24f6ce1c7e925b08d96b3 Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Mon, 22 Nov 2010 11:32:48 +0200
> Subject: [PATCH 1/2] OMAP: DMA: prevent races while setting M idle mode to
> nostandby
> 
> In a couple of OMAP errata cases, sDMA M idle mode must be
> set temporarily to nostandby.  If two DMA users were to do
> that at the same time, a race condition would arise.
> Prevent that by using a spin lock and counting up/down the
> number of times nostandby is set/reset.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
