From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 5/5] ARM: omap4: Kill private do_wfi macro.
Date: Fri, 09 Sep 2011 22:34:14 +0530
Message-ID: <4E6A470E.9010703@ti.com>
References: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com> <1315582012-23507-6-git-send-email-nbowler@elliptictech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50906 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759502Ab1IIREW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 13:04:22 -0400
Received: by mail-yi0-f47.google.com with SMTP id 28so996312yia.6
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 10:04:21 -0700 (PDT)
In-Reply-To: <1315582012-23507-6-git-send-email-nbowler@elliptictech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nick Bowler <nbowler@elliptictech.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Friday 09 September 2011 08:56 PM, Nick Bowler wrote:
> The do_wfi macro duplicates the functionality of the wfi macro in common
> ARM code.  Use the common version instead.
>
> Signed-off-by: Nick Bowler<nbowler@elliptictech.com>
> ---
> Compile tested in both ARM and Thumb-2 mode.

Thanks but this is already handle in my PM series.

https://patchwork.kernel.org/patch/624761/

Regards
Santosh
