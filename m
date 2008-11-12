From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH v2 0/6] OMAP: Make OMAP LDP boot succussfuly
Date: Wed, 12 Nov 2008 16:58:52 +0800
Message-ID: <1226480332.24669.38.camel@localhost>
References: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34172 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbYKLIw4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 03:52:56 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mAC8qtfF000198
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 00:52:55 -0800 (PST)
In-Reply-To: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Any other comments ?

Stanley.

On Tue, 2008-11-11 at 19:50 +0800, Stanley.Miao wrote:
> Changes since v1:
> 
> 1, fix all the patch format problem.
> 
> 2, split the defconfig patch from code patches.
> 
> 3, put a twl4030keypad bug fix into a single patch.
> 
> 4, Add a "persistent" bit in the keypad map, and prune off "#ifdef(OMAP_LDP)"
> from the keypad driver.
> 
> 
> Now there is only basic support for OMAP LDP in linux-omap-2.6, LDP can't boot
> up, even crash at boot time(because of omap_hdq problem).
> 
> Add the following patches to fix the boot crash and let LDP boot succussfuly.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
