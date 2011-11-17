From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] MTD: nand: Making  MTD_NAND_OMAP2 depend on
 ARCH_OMAP2PLUS
Date: Fri, 18 Nov 2011 00:15:36 +0200
Message-ID: <1321568138.2272.30.camel@koala>
References: <1321420680-4677-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43528 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1KQWPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Nov 2011 17:15:41 -0500
Received: by bke11 with SMTP id 11so2637131bke.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 14:15:39 -0800 (PST)
In-Reply-To: <1321420680-4677-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2011-11-16 at 10:48 +0530, Shubhrajyoti D wrote:
> Making  MTD_NAND_OMAP2 depend on ARCH_OMAP2PLUS instead of
> oring with ARCH2/3/4.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Pushed to l2-mtd-2.6, thanks!

Artem.

