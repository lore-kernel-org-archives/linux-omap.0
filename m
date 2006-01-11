From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 1/5] Add MMC password protection (lock/unlock) support
 V3
Date: Wed, 11 Jan 2006 09:16:28 -0400
Message-ID: <43C5052C.4050804@indt.org.br>
References: <43C2E064.90500@indt.org.br> <20060109222902.GF19131@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751481AbWAKNPd@vger.kernel.org>
In-Reply-To: <20060109222902.GF19131@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Russell King wrote:

>On Mon, Jan 09, 2006 at 06:15:00PM -0400, Anderson Briglia wrote:
>  
>
>>When a card is locked, only commands from the "basic" and "lock card" classes
>>are accepted. To be able to use the other commands, the card must be unlocked
>>first.
>>    
>>
>
>I don't think this works as you intend.
>
>When a card is initially inserted, we discover the cards via mmc_setup()
>and mmc_discover_cards().  This means that we'll never set the locked
>status for newly inserted cards.
>  
>
mmc_setup() calls mmc_check_cards(). Our patch adds the necessary code
to mmc_check_cards() to set the locked state when the card is locked.

>>===================================================================
>>--- linux-2.6.15-rc4.orig/drivers/mmc/mmc.c	2005-12-15 14:06:52.000000000 -0400
>>+++ linux-2.6.15-rc4/drivers/mmc/mmc.c	2005-12-15 17:00:37.000000000 -0400
>>@@ -986,10 +986,15 @@ static void mmc_check_cards(struct mmc_h
>> 		cmd.flags = MMC_RSP_R1;
>> 
>> 		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
>>-		if (err == MMC_ERR_NONE)
>>+		if (err != MMC_ERR_NONE) {
>>+			mmc_card_set_dead(card);
>> 			continue;
>>+		}
>> 
>>-		mmc_card_set_dead(card);
>>+		if (cmd.resp[0] & R1_CARD_IS_LOCKED)
>>+			mmc_card_set_locked(card);
>>+		else
>>+			card->state &= ~MMC_STATE_LOCKED;
>>    
>>
Anderson Briglia
INdT - Manaus
