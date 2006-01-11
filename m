From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 1/5] Add MMC password protection (lock/unlock) support
 V3
Date: Wed, 11 Jan 2006 15:27:55 -0400
Message-ID: <43C55C3B.3090207@indt.org.br>
References: <43C2E064.90500@indt.org.br> <20060109222902.GF19131@flint.arm.linux.org.uk> <43C5052C.4050804@indt.org.br> <20060111144424.GA20523@flint.arm.linux.org.uk> <20060111181459.GF4422@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932203AbWAKT1R@vger.kernel.org>
In-Reply-To: <20060111181459.GF4422@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>, drzeus-list@drzeus.cx, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Russell King <rmk+lkml@arm.linux.org.uk> [060111 06:44]:
> 
>>On Wed, Jan 11, 2006 at 09:16:28AM -0400, Anderson Briglia wrote:
>>
>>>Russell King wrote:
>>>
>>>
>>>>On Mon, Jan 09, 2006 at 06:15:00PM -0400, Anderson Briglia wrote:
>>>> 
>>>>
>>>>
>>>>>When a card is locked, only commands from the "basic" and "lock card" classes
>>>>>are accepted. To be able to use the other commands, the card must be unlocked
>>>>>first.
>>>>>   
>>>>>
>>>>
>>>>I don't think this works as you intend.
>>>>
>>>>When a card is initially inserted, we discover the cards via mmc_setup()
>>>>and mmc_discover_cards().  This means that we'll never set the locked
>>>>status for newly inserted cards.
>>>> 
>>>>
>>>
>>>mmc_setup() calls mmc_check_cards(). Our patch adds the necessary code
>>>to mmc_check_cards() to set the locked state when the card is locked.
>>
>>Not in Linus' kernel, it doesn't.
>>
>>If you're working off the OMAP tree, bear in mind that I've found in
>>the past that they have a large number of wrong or inappropriate
>>changes to the MMC layer in there.  They don't regularly merge either,
>>and they certainly don't forward any bug fixes for review in a timely
>>manner.
> 
> 
> I agree the omap MMC driver should be cleaned-up and finally merged.
> 
> Anderson, since you are already patching it, do you want to take care of
> cleaning it up a bit and posting it here?

OK Tony. I'll do it and post here asap.

Regards,

Anderson Briglia
INdT - Manaus
