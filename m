From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2: PM debug: remove leftover debug code
Date: Fri, 05 Aug 2011 08:11:18 -0700
Message-ID: <87bow3uc4p.fsf@ti.com>
References: <1312550158-4553-1-git-send-email-michael.jones@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:57439 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753817Ab1HEPLV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 11:11:21 -0400
Received: by mail-gy0-f172.google.com with SMTP id 5so1990336gyd.31
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 08:11:20 -0700 (PDT)
In-Reply-To: <1312550158-4553-1-git-send-email-michael.jones@matrix-vision.de>
	(Michael Jones's message of "Fri, 5 Aug 2011 15:15:58 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: linux-omap@vger.kernel.org

Michael Jones <michael.jones@matrix-vision.de> writes:

> commit 20d5d5514981f9a68832bffb27a698545ecba77a left some code
> lying around which doesn't do anything. Clean it up.

Minor: when referencing a commit in a changelog, please also
add the short log.  IOW, the changelog should read:

   commit 20d5d5514981f9a68832bffb27a698545ecba77a (OMAP2: PM debug:
   remove register dumping) left some code lying around which doesn't do
   anything. Clean it up.

> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
> ---
>
> It looks to me like if you remove the register dump, the debug if's
> don't do anything at all.

You're right.

Please update the changelog and also Cc the linux-arm-kernel mailing
list on the updated patch.

After that, I'll queue it for v3.2.

Thanks,

Kevin
