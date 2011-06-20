From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
Date: Mon, 20 Jun 2011 15:09:36 +0530
Message-ID: <4DFF1558.4020509@ti.com>
References: <20110620091754.357.56441.stgit@kaulin> <20110620092341.357.14183.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:49688 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751633Ab1FTJjm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jun 2011 05:39:42 -0400
Received: by mail-yw0-f53.google.com with SMTP id 21so1864391ywm.12
        for <linux-omap@vger.kernel.org>; Mon, 20 Jun 2011 02:39:41 -0700 (PDT)
In-Reply-To: <20110620092341.357.14183.stgit@kaulin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On 6/20/2011 2:53 PM, Tony Lindgren wrote:
> This removes the support for setting the wake-up timer for debugging.
>
> Later on we can reserve gptimer1 for PM code only and have similar
> functionality.
>
> Signed-off-by: Tony Lindgren<tony@atomide.com>
> Reviewed-by: Kevin Hilman<khilman@ti.com>
> ---

Kevin cleaned up this with a better patch.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50015.html

May be we can use that patch instead of this.

Regards
Santosh
