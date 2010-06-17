From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] OMAP: hwmod: Fixes and OMAP2&3 data update
Date: Thu, 17 Jun 2010 08:48:05 -0700
Message-ID: <87d3vpoe2y.fsf@deeprootsystems.com>
References: <1274736194-30652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54866 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab0FQPsO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 11:48:14 -0400
Received: by pvg6 with SMTP id 6so30971pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 08:48:13 -0700 (PDT)
In-Reply-To: <1274736194-30652-1-git-send-email-b-cousson@ti.com> (Benoit Cousson's message of "Mon\, 24 May 2010 23\:23\:12 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Benoit Cousson <b-cousson@ti.com> writes:

> Add the missing braces in hwmod fw and clean the data for 
> OMAP2420, 2430 and 3430.
>
> The brace fix was tested on OMAP4 PAB.
> Please note that the data changes were built for the 3 platforms
> but not tested on board.
>
> The series is based on l-o master. 

Adding this series to my pm-wip/hwmods branch so it's included with all the
other hwmod changes being used for hwmod development.

Kevin

>
>
> Benoit Cousson (2):
>   OMAP: hwmod: Fix the missing braces
>   OMAP2&3: hwmod: Remove _hwmod prefix in name string
>
>  arch/arm/mach-omap2/omap_hwmod.c           |    9 ++++++---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++---
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
>  4 files changed, 16 insertions(+), 13 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
