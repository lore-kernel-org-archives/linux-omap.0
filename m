From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 0/3] ARM: OMAP: clk-next-omap emergency fixes
Date: Fri, 17 Jan 2014 13:37:29 -0800
Message-ID: <20140117213729.4167.55693@quantum>
References: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59259 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbaAQVhn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2014 16:37:43 -0500
Received: by mail-gg0-f174.google.com with SMTP id g10so1446952gga.5
        for <linux-omap@vger.kernel.org>; Fri, 17 Jan 2014 13:37:40 -0800 (PST)
In-Reply-To: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Quoting Tero Kristo (2014-01-17 12:25:37)
> Hi,
> 
> Quick emergency band-aid for the build breakages introduced in clk-next
> by Mike. I didn't have time to test this out (Nishanth will provide some
> logs) and I will leave the decision whether/how to use these patches or not
> to Tony + Mike.
> 
> I also pushed a test branch based on top of clk-next here:
> tree: https://github.com/t-kristo/linux-pm.git
> branch: clk-next-omap-fixes

Thanks Tero. I force updated the clk tree with the right branch, so
these should not be necessary now.

Regards,
Mike

> 
> -Tero
> 
