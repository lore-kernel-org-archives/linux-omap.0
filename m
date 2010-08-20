From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v6 1/3] ARM: OMAP: Beagle: revision detection
Date: Fri, 20 Aug 2010 15:03:28 +0300
Message-ID: <20100820150328.c18681ce.jhnikula@gmail.com>
References: <1282271926-2676-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40094 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0HTMDI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 08:03:08 -0400
Received: by ewy23 with SMTP id 23so2018036ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Aug 2010 05:03:03 -0700 (PDT)
In-Reply-To: <1282271926-2676-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Thu, 19 Aug 2010 21:38:44 -0500
Robert Nelson <robertcnelson@gmail.com> wrote:

> Due to the omap3530 ES3.0 Silicon being used on both the
> B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx() 
> routines to differentiate the Beagle Boards.
> 
> However gpio pins 171,172,173 where setup for this prupose, so 
> lets use them.
> 
> Changes:
> for older U-Boot's, use omap_mux_init_gpio()
> keep Beagle Rev in board-omap3beagle.c
> gpio_free on gpio request failure
> 
> Tested on Beagle Revisions: B5, C2, C4, and xMA
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> ---

To this set:

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
