From: Angelo Arrifano <miknix@gmail.com>
Subject: Re: [APPLIED] [PATCH 3/3] [ARM] omap850: Use ck_ref clock for omap850.
Date: Tue, 22 Sep 2009 23:39:44 +0100
Message-ID: <4AB95230.4090409@gmail.com>
References: <notify-1253656568@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:39524 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZIVWdk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 18:33:40 -0400
Received: by ey-out-2122.google.com with SMTP id d26so48227eyd.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 15:33:43 -0700 (PDT)
In-Reply-To: <notify-1253656568@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> This patch has been applied to the linux-omap
> by youw fwiendly patch wobot.
> 
> Branch in linux-omap: omap-fixes
> 
> Initial commit ID (Likely to change): 16f038289768a16888e0131471f7c7eb841d36bf

Just a notice, this patch *as-is* will probably break the tree.

Current linux-omap still doesn't have a CK_7XX definition, which is
introduced by "[RFC] OMAP1: Massive clean up of omap730/omap850 code"

Sorry,
- Angelo
> 
> PatchWorks
> http://patchwork.kernel.org/patch/45810/
> 
> Git (Likely to change, and takes a while to get mirrored)
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=16f038289768a16888e0131471f7c7eb841d36bf
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
