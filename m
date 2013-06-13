From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [v4 2/3] arm: gpmc: Low power transition support
Date: Thu, 13 Jun 2013 13:19:58 -0700
Message-ID: <87bo79bw5t.fsf@linaro.org>
References: <1371032708-9242-1-git-send-email-pekon@ti.com>
	<1371032708-9242-3-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:61234 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab3FMUUD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 16:20:03 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so6790552pab.35
        for <linux-omap@vger.kernel.org>; Thu, 13 Jun 2013 13:20:02 -0700 (PDT)
In-Reply-To: <1371032708-9242-3-git-send-email-pekon@ti.com> (Pekon Gupta's
	message of "Wed, 12 Jun 2013 15:55:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, avinash philip <avinashphilip@ti.com>

Pekon Gupta <pekon@ti.com> writes:

> From: avinash philip <avinashphilip@ti.com>
>
> With GPMC converted to platform driver recently, adds low power
> transition support in driver itself.

The subject/changelog should be clear that this is support for
suspend/resume.

Kevin
