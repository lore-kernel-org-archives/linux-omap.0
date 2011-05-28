From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP: L3 interconnect: Error reporting cleanups
Date: Sat, 28 May 2011 13:33:49 +0530
Message-ID: <4DE0AC65.8000202@ti.com>
References: <20110528032408.GA24868@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33182 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751331Ab1E1IDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 28 May 2011 04:03:55 -0400
Received: by mail-gy0-f177.google.com with SMTP id 20so1181458gyh.36
        for <linux-omap@vger.kernel.org>; Sat, 28 May 2011 01:03:54 -0700 (PDT)
In-Reply-To: <20110528032408.GA24868@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org

Todd,

On 5/28/2011 8:54 AM, Todd Poynor wrote:
> * Make variables static.
>
> * Define L3 TARG instance offsets, and read/write STDERRLOG registers
>    relative to those offsets, rather than defining STDERRLOG_MAIN
>    instance offsets and accessing other registers via offsets from
>    that register.
>
> * Use ffs() to find error source from the L3_FLAGMUX_REGERRn
>    register.
>
> * Remove extra l3_base[] entry.
>
> * Modify L3 custom error message for consistency with standard
>    error message.
>
> Signed-off-by: Todd Poynor<toddpoynor@google.com>
> ---
>
> V2 updated for feedback from Santosh (thanks!).
>
Thanks Todd.
Will add this patch along with other patches
on interconnect files.

Regards
Santosh
