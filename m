From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
Date: Tue, 05 Dec 2006 14:06:36 -0400
Message-ID: <4575B52C.70403@indt.org.br>
References: <4564640B.1070004@indt.org.br> <45680308.4040809@drzeus.cx> <45746CD3.1000604@indt.org.br> <457483B5.8060205@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S968149AbWLESDz@vger.kernel.org>
In-Reply-To: <457483B5.8060205@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, ext David Brownell <david-b@pacbell.net>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ext Pierre Ossman wrote:

> Anderson Briglia wrote:
>> Actually they represent the bits regarding the modes and it is used
>> when we
>> have to send the LOCK/UNLOCK mode on the command data block, according
>> to the MMC Spec.
>> If you take a look at mmc_lock_unlock function, we use those modes to
>> set the right bit
>> when composing the command data block.
>> This definition makes the code more legible and simple.
> 
> In that case you need to change the code to make sure it is clear that
> it is bits and not values.

Yes. As I sent another version after read your comment, I'll fix the V8 code just for this patch, ok? I don't see that 
we have to send another version.


> Also, your definition for
> MMC_LOCK_MODE_UNLOCK is wrong.

This definition:

#define MMC_LOCK_MODE_UNLOCK    (0<<2)

also tries to make the code more clear and legible. It is indicating that this bit is on the position 3 into the bits 
array, according to MMC Spec.
But, why zero? Well, the bit must be 1 for locking and 0 for unlocking. We are using the unlocking action, so we used zero.
Is there any issue using this piece of code?
If you prefer another approach we can adjust our patch.

Regards,

Anderson Briglia
