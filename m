From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH/RFC 1/4] OMAP3: PM debug: remove sleep_while_idle feature
Date: Mon, 30 May 2011 12:45:43 +0530
Message-ID: <4DE3441F.6070807@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com> <1306450971-27732-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:58933 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753868Ab1E3HPu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 03:15:50 -0400
Received: by gwj16 with SMTP id 16so1385619gwj.9
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 00:15:49 -0700 (PDT)
In-Reply-To: <1306450971-27732-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

On 5/27/2011 4:32 AM, Kevin Hilman wrote:
> Remove the OMAP-specific PM debug 'sleep_while_idle' feature which is
> currently available as an OMAP-specific debugfs entry.
>
> This duplicates existing ARM-generic functionality available as a
> boot-time option using the boot cmdline option 'hohlt'.
>
> If runtime configuration of this is needed, then adding a debugfs
> entry for the ARM-generic hlt/nohlt interface should be added.
>
> Signed-off-by: Kevin Hilman<khilman@ti.com>

This makes it easy for future OMAP PM code as well.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
