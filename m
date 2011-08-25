From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH RFC] OMAP2PLUS: Enable HIGHMEM
Date: Thu, 25 Aug 2011 14:12:56 +0530
Message-ID: <4E560B10.1010806@ti.com>
References: <1307016381-21878-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42952 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750979Ab1HYInG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 04:43:06 -0400
Received: by ywa12 with SMTP id 12so1914134ywa.34
        for <linux-omap@vger.kernel.org>; Thu, 25 Aug 2011 01:43:04 -0700 (PDT)
In-Reply-To: <1307016381-21878-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

On Thursday 02 June 2011 05:36 PM, Santosh Shilimkar wrote:
> HIGMEM support is kernel is quite mature now and we have boards
> like ZOOM, PANDA, SDP where 1 GB memories are installed.
>
> Enable HIGMEM to make use of the additional memory.
>
> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> ---
> This won't boards which doesn't have excess memory. Tested
> on OMAP4430 SDP
>
>   arch/arm/mach-omap2/Kconfig |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
Any comments.
I almost forgot about the post. Thanks to imx patch on LAKML, i
looked at it again.

If you are ok, I can repost it with LAKML in CC.

Regards
Santosh


