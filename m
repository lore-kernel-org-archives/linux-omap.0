From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/PATCH] arm: omap2plus: kill section mismatches
Date: Thu, 07 Apr 2011 13:51:49 +0530
Message-ID: <4D9D741D.2040304@ti.com>
References: <1302163511-32510-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:52027 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752346Ab1DGIWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 04:22:09 -0400
Received: by yia13 with SMTP id 13so916605yia.6
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 01:22:06 -0700 (PDT)
In-Reply-To: <1302163511-32510-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 4/7/2011 1:35 PM, Felipe Balbi wrote:
> Those were very simple to fix and while we should
> be putting effort on code consolidation, having
> a noisy compilation is very painful and makes it
> more difficult to see newer warnings introduced
> by re-factoring other code.
>
> Signed-off-by: Felipe Balbi<balbi@ti.com>
> ---
I did post one for section mismatch already :)
http://www.spinics.net/lists/linux-omap/msg49557.html


Regards
Santosh
