From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Removes unused platform device for osk5912
Date: Mon, 8 Dec 2008 11:35:58 -0800
Message-ID: <200812081135.58610.david-b@pacbell.net>
References: <1228456391-7292-1-git-send-email-arunks@mistralsolutions.com> <20081208191251.GS7388@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:48946 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751385AbYLHTgB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 14:36:01 -0500
In-Reply-To: <20081208191251.GS7388@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arunks@mistralsolutions.com, linux-omap@vger.kernel.org, dirk.behme@de.bosch.com

On Monday 08 December 2008, Tony Lindgren wrote:
> 
> > This patch removes platform device used my ALSA driver, which
> > is now replaced with ASoC driver.
> 
> Thanks, I'll apply this to linux-omap tree. Will also expand it to
> delete similar code from other board files for the mainline queue.
> Some of the includes can disappear with this patch, BTW.

Maybe drivers/i2c/chips/tlv320aic23.c should be removed too.
I think that's a remnant of now-removed OSS infrastructure;

- Dave

