From: Tony Lindgren <tony@atomide.com>
Subject: Re: HSMMC pending fixes
Date: Wed, 10 Sep 2008 17:05:06 -0700
Message-ID: <20080911000506.GX21163@atomide.com>
References: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com> <13B9B4C6EF24D648824FF11BE8967162036217F3A9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54096 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbYIKAF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 20:05:26 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036217F3A9@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Woodruff, Richard <r-woodruff2@ti.com> [080818 14:09]:
> Hi,
> 
> > owner@vger.kernel.org] On Behalf Of Jarkko Lavinen
> 
> 
> > 2: Disable smartidle mode while suspending (workaround)
> 
> This was the work around we had in internal trees for a long time.
> 
> However Madhu C. recently updated this based on an internal investigation.  It is required to reset the command pin to clear the system for sleep.  This allows retention to work.
> 
> The non-idle work around when profiled showed it was taking a huge amount of time for the clock re-enable to work.  This actually would noticeably reduce MMC throughput when doing aggressive clock cutting in the driver and increase power usage.
> 
> +       } else {
> +               OMAP_HSMMC_WRITE(host->base, SYSCTL,
> +                       OMAP_HSMMC_READ(host->base, SYSCTL) | SRD);
> +               while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD) ;
> 
> If you use a really long time out then perhaps it doesn't matter.  But if you try and be aggressive it will hurt you.

Pushing all except the workaround. Madhu, can you please send a patch
for what Richard is describing?

Thanks,

Tony
