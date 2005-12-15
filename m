From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Date: Thu, 15 Dec 2005 07:49:40 +0100
Message-ID: <43A11204.2070403@drzeus.cx>
References: <20051213213208.303580000@localhost.localdomain>	 <439F4AD6.9090203@indt.org.br> <439FC4A6.4010900@drzeus.cx> <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964789AbVLOGtt@vger.kernel.org>
In-Reply-To: <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Lizardo <anderson.lizardo@gmail.com>
Cc: Anderson Briglia <anderson.briglia@indt.org.br>, Anderson Lizardo <anderson.lizardo@indt.org.br>, linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org, Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org

Anderson Lizardo wrote:

>Probably using the entire 128-bit CID for the key description would
>waste too much space though, so we are thinking about using just some
>CID fields to build a smaller unique ID. The key retention service has
>quotas for how much space a keyring can use for payload and key
>description, so we should try to keep the description as short as
>possible. If a collision occurs and the password is wrong, we can
>simply invalidate the key and ask for the password again.
>
>  
>

For SD cards we can also use the RCA, which tends to be a bit random.
Perhaps a generic hash function so that we can extend and tweak this
algorithm in one place?

>I actually just did the following change to the OMAP code (drivers/mmc/omap.c):
>
>-
>-	block_size = 1 << data->blksz_bits;
>+	/*  password protection: we need to send the exact block size to the
>+	 *  card (password + 2), not a 2-exponent. */
>+	if (req->cmd->opcode == MMC_LOCK_UNLOCK)
>+		block_size = data->sg[0].length;
>+	else
>+		block_size = 1 << data->blksz_bits;
>
>Given that for the LOCK_UNLOCK command the sg_len will always be 1, we
>can get the block size directly from the first entry of the
>scatterlist. For other block operations, the blksz_bits value is used
>as usual.
>
>  
>

I can't say that I approve of this code. It's my firm belief that
drivers that are protocol aware are horribly broken.

>Maybe removing blksz_bits and using the block size directly would be
>better? Is there any host/card which expects to always receive a
>power-of-2 block size for block operations?
>  
>

Sounds like a much better solution. Hacking around problems instead of
solving them usually lead to even more problems.

I haven't studied all drivers in detail, but I believe all of them
should be able to handle the transistion.

Rgds
Pierre
