From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 4/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_sysfs.diff
Date: Mon, 04 Dec 2006 12:16:13 -0400
Message-ID: <457449CD.3040108@indt.org.br>
References: <45646457.1060203@indt.org.br> <45680555.1000406@drzeus.cx> <456ACC9E.2030105@indt.org.br> <45709B95.9000009@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937007AbWLDQNS@vger.kernel.org>
In-Reply-To: <45709B95.9000009@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, ext David Brownell <david-b@pacbell.net>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ext Pierre Ossman wrote:
> Anderson Briglia wrote:
>> Hi Pierre,
>>
>> ext Pierre Ossman wrote:
>>> Patch looks ok. But I never got an answer what the difference between
>>> "change" and "assign" is.
>> You're right, the command is the same, but the difference is the
>> password's
>> length and password itself sent to the card.
>> According to MMC spec 4.1, when a password replacement is done, the
>> length value
>> (PWD_LEN) shall include both passwords, the old and the new one, and
>> the password
>> (PWD) shall include the old (currently) followed by the new password.
> 
> So shouldn't this be something that userspace handles?
> 

I merged the code for "change" and "assign". But the action (returned from kernel
to user space application continues as "change" and "assign" separately.

Anderson Briglia
