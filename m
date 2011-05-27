From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH/RFC 4/4] OMAP2: PM debug: move wakeup timer into clockevent
 code
Date: Fri, 27 May 2011 10:48:25 +0530
Message-ID: <4DDF3421.30308@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com> <1306450971-27732-5-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:54155 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750804Ab1E0FSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 01:18:33 -0400
Received: by ywh1 with SMTP id 1so715957ywh.29
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 22:18:32 -0700 (PDT)
In-Reply-To: <1306450971-27732-5-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

On 5/27/2011 4:32 AM, Kevin Hilman wrote:
> Move suspend wakeup timer from suspend path to be triggered based
> on clockevent suspend path.
>
> When gptimers are eventually converted to be a driver, the wakeup
> timer feature can be made to be a driver-specific feature using the
> driver's suspend method.
>
Excellent idea and patch. Never crossed my mind that we could
have used "CLOCK_EVT_MODE_SHUTDOWN" instead of our long old
hack.

Regards
Santosh



