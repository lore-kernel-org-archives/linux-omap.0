From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 5/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Date: Fri, 17 Nov 2006 16:13:14 +0000
Message-ID: <20061117161314.GF28514@flint.arm.linux.org.uk>
References: <455DB547.5060407@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933693AbWKQQNW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <455DB547.5060407@indt.org.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>, ext David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 17, 2006 at 09:12:39AM -0400, Anderson Briglia wrote:
> +	if (mmc_card_locked(card) && !strncmp(data, "erase", 5)) {
> +		/* forced erase only works while card is locked */
> +		spin_lock(&mmc_lock);
> +		mmc_lock_unlock(card, NULL, MMC_LOCK_MODE_ERASE);
> +		spin_unlock(&mmc_lock);

mmc_lock_unlock can sleep; holding a spinlock while sleeping is illegal
and is a serious bug.  Inappropriate locking?  What's this lock trying
to achieve?

I don't see any requirement for locking here - mmc_lock_unlock() claims
the host, and if that succeeds, it has exclusive access via that host to
the card.  No one else will be able to talk on the bus until
mmc_lock_unlock() releases it's claim on the host.  So I suspect that
whatever locking you require is already in place.

Ditto for each other instances.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
