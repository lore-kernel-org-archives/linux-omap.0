From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Date: Wed, 14 Dec 2005 08:07:18 +0100
Message-ID: <439FC4A6.4010900@drzeus.cx>
References: <20051213213208.303580000@localhost.localdomain> <439F4AD6.9090203@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751291AbVLNHH1@vger.kernel.org>
In-Reply-To: <439F4AD6.9090203@indt.org.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: Anderson Lizardo <anderson.lizardo@indt.org.br>, linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org, Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org

Anderson Briglia wrote:
> [resending summary because our first attempt failed]
> 
> 
> - Password caching: when inserting a locked card, the driver should try to
>   unlock it with the currently stored password (if any), and if it fails,
>   revoke the key containing it and fallback to the normal "no password present"
>   situation.
> 

Would it be possible to use the id of the card as a search key for the
password? That way several passwords can coexist.

> - Currently, some host drivers assume the block length will always be a power
>   of 2. This is not true for the MMC_LOCK_UNLOCK command, which is a block
>   command that accepts arbitratry block lengths. We have made the necessary
>   changes to the omap.c driver (present on the linux-omap tree), but the same
>   needs to be done for other hosts' drivers.
> 

The MMC layer is designed that way, so it's hardly surprising that
drivers have been coded for it. I'm assuming you've removed blksz_bits
in favor of something in bytes?

Rgds
Pierre
