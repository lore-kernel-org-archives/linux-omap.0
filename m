From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] OMAP2/4: PM: Boot message is not an error/info,	and not
 helpful, remove it
Date: Mon, 30 May 2011 17:36:00 +0400
Message-ID: <4DE39D40.2060500@ru.mvista.com>
References: <1306751527-15929-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40264 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab1E3Nhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 09:37:40 -0400
Received: by eyx24 with SMTP id 24so1350143eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 06:37:39 -0700 (PDT)
In-Reply-To: <1306751527-15929-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org

Hello.

Santosh Shilimkar wrote:

> The commit '99aa18278e' removed the boot messege for OMAP3. Do the same

    Please specify that commit's summary in parens -- for the human readers.
Oh, and you don't need quotes around commit ID too.

> for OMAP2 and OMAP4 since it's really just noise in the boot log
> and PM init is always called.

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

WBR, Sergei

