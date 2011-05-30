From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH/RFC 3/4] OMAP3: PM debug: remove register dumping
Date: Mon, 30 May 2011 12:48:46 +0530
Message-ID: <4DE344D6.5070103@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com> <1306450971-27732-4-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59978 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754263Ab1E3HSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 03:18:52 -0400
Received: by mail-gx0-f179.google.com with SMTP id 1so1341566gxk.10
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 00:18:51 -0700 (PDT)
In-Reply-To: <1306450971-27732-4-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

On 5/27/2011 4:32 AM, Kevin Hilman wrote:
> Remove OMAP3-specific register dumping feature from PM debug layer.
> This is removed because:
>
> - it's ugly
> - it's OMAP3-specific, and will obviously not scale to OMAP4+
> - userspace /dev/mem-based tools (like omapconf) can do this much better
>
Fully agree and indeed it doesn't scale for OMAP4.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>




