From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3]  Updates for tea5761 (take #3)
Date: Mon, 23 Jun 2008 13:42:53 +0300
Message-ID: <20080623104252.GH7741@atomide.com>
References: <1213119732-13198-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.178] ([63.208.196.178]:64426 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753738AbYFWKm1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 06:42:27 -0400
Content-Disposition: inline
In-Reply-To: <1213119732-13198-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@indt.org.br>

* Eduardo Valentin <edubezval@gmail.com> [080610 20:46]:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> Hi guys,
> 
> Following recommendation from v4l people, I'm sending
> this update to our tea5761 driver.
> 
> They already had a tuner for this device which communicates
> through i2c.
> 
> I needed to update it because there were some register mis-utilization.
> 
> Here is a series which updates their tuner and our driver.
> 
> After acks and merging here in linux-omap I'll send it to v4l again.

Pushing these today.

Tony

> 
> Cheers,
> 
> Eduardo Valentin (3):
>   tea5761: Add init and sleep callbacks on tea5761 tuner
>   tea5761 tuner: fix registers utilization
>   radio-tea5761: Update driver
> 
>  drivers/media/common/tuners/tea5761.c |   55 +++-
>  drivers/media/radio/Kconfig           |    1 +
>  drivers/media/radio/Makefile          |    2 +
>  drivers/media/radio/radio-tea5761.c   |  570 ++++++++++++++++-----------------
>  4 files changed, 329 insertions(+), 299 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
