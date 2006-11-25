From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
Date: Sat, 25 Nov 2006 09:53:28 +0100
Message-ID: <45680488.8030508@drzeus.cx>
References: <4564640B.1070004@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934284AbWKYIxX@vger.kernel.org>
In-Reply-To: <4564640B.1070004@indt.org.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, ext David Brownell <david-b@pacbell.net>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Seems I missed this...

Anderson Briglia wrote:
> +
> +    err = mmc_card_claim_host(card);
> +    if (err != MMC_ERR_NONE)
> +        goto out;
> +

As I said before, no locking in the command abstractions. The host
should be claimed somewhere further up the chain (in
mmc_lockable_store() right now).

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
