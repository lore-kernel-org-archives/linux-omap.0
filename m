From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
Date: Thu, 02 Feb 2012 10:40:04 -0800
Message-ID: <87obthcc57.fsf@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
	<1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:58414 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757109Ab2BBSkB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 13:40:01 -0500
Received: by pbdd12 with SMTP id d12so2628878pbd.23
        for <linux-omap@vger.kernel.org>; Thu, 02 Feb 2012 10:40:00 -0800 (PST)
In-Reply-To: <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Thu, 2 Feb 2012 19:33:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> hwmod setup already does a reset and sets the OCP sysconfig
> registers appropriately. Avoid doing a reset again and overriding
> the OCP sysconfig settings in the system timer init code.

That is true for OMAP4, but have you verified if this is indeed a
duplicate reset on  OMAP2/3?

Kevin
