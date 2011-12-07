From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 11/11] arm:omap:am33xx: Add am335x support in generic omap_hwmod
Date: Tue, 06 Dec 2011 16:09:02 -0800
Message-ID: <87d3c15jkx.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-12-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33398 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754753Ab1LGAJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Dec 2011 19:09:10 -0500
Received: by mail-gy0-f170.google.com with SMTP id g16so5364295ghb.15
        for <linux-omap@vger.kernel.org>; Tue, 06 Dec 2011 16:09:09 -0800 (PST)
In-Reply-To: <1321809555-13833-12-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Sun, 20 Nov 2011 22:49:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

+Rajendra,

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> AM335X is bit different than OMAP3/4 architecture when it comes to
> PRCM module, for example, the way module is enabled/disabled.
> Although it is closer to OMAP4 architecure but the register offset
> and PRCM partitions won't match, so we need to seperate API's
> for AM335X.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Seems like this one can be addressed similarily to the way Rajendra
proposed addressing the powerdomain issue so that OMAP4 code can be
largely reused.

Kevin 
