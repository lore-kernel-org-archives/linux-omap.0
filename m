From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 3/5] Add MMC password protection (lock/unlock) support
 V3
Date: Tue, 10 Jan 2006 17:45:36 -0400
Message-ID: <43C42B00.60206@indt.org.br>
References: <43C2E0A2.3090701@indt.org.br> <20060109224204.GH19131@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932365AbWAJVqJ@vger.kernel.org>
In-Reply-To: <20060109224204.GH19131@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux@arm.linux.org.uk, ext David Brownell <david-b@PACBELL.NET>, Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Russell King wrote:

>On Mon, Jan 09, 2006 at 06:16:02PM -0400, Anderson Briglia wrote:
>  
>
>>+	dev = bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
>>+	if (!dev)
>>+		goto error;
>>+	card = dev_to_mmc_card(dev);
>>+	
>>+	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */
>>+               if (mmc_card_locked(card)) {
>>+                       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_UNLOCK);
>>+                       mmc_remove_card(card);
>>+                       mmc_register_card(card);
>>+               }
>>+	       else
>>+		       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
>>    
>>
>
>I really don't like this - if the MMC card is not locked, we set a
>password on it.  If it's locked, we unlock it.
>
>That's a potential race condition if you're trying to unlock a card
>and the card is changed beneath you while you slept waiting for
>memory - you end up setting that password on the new card.
>
>It's far better to have separate "unlock this card" and "set a
>password on this card" commands rather than trying to combine the
>two operations.
>  
>
Ok.

>Also, removing and re-registering a card is an offence.  These
>things are ref-counted, and mmc_remove_card() will drop the last
>reference - so the memory associated with it will be freed.  Then
>you re-register it.  Whoops.
>
>If you merely want to try to attach a driver, use device_attach()
>instead.
>  
>
If we use device_attach(), the mmc_block driver is not informed about
the card's unlocking. I did some tests, using device_attach() instead of
those mmc functions and seems that the mmc_block driver tries to use a
invalid device reference. What do you suggest on this case?

>Also, what if you have multiple MMC cards?  I have a board here
>with two MMC slots.  I'd rather not have it try to set the same
>password on both devices.
>  
>
Sorry, but this series of patches only support one mmc host. I'll update
the TODO section of the summary e-mail.

Anderson Briglia
INdT - Manaus
