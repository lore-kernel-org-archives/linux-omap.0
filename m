From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Date: Thu, 15 Dec 2005 17:01:30 +0100
Message-ID: <43A1935A.4020902@drzeus.cx>
References: <20051213213208.303580000@localhost.localdomain> <439F4AD6.9090203@indt.org.br> <439FC4A6.4010900@drzeus.cx> <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com> <43A11204.2070403@drzeus.cx> <20051215091220.GA29620@flint.arm.linux.org.uk> <43A136F1.3040700@drzeus.cx> <20051215100657.GC32490@flint.arm.linux.org.uk> <20051215134436.GB6211@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750783AbVLOQBh@vger.kernel.org>
In-Reply-To: <20051215134436.GB6211@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>, Anderson Lizardo <anderson.lizardo@gmail.com>, Anderson Briglia <anderson.briglia@indt.org.br>, Anderson Lizardo <anderson.lizardo@indt.org.br>, linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org, Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org

Russell King wrote:
> Reading through the specs I have here, block sizes seem to be all over
> the place.  The MMC card specs seem to imply that any block size can
> be set, from 0 bytes to 2^32-1 bytes.
>
> The PXA MMC interface specification allows the block size to be anything
> from 1 to 1023 bytes, excluding CRC.  It is unclear whether a value of 0
> means 1024.
>
> The MMCI specification allows the block size to be specified as a power
> of two, from 1 to 2048 bytes, excluding CRC.
>
> Pierre - can you comment on wbsd's capabilities please?
>
>   

wbsd can do 1 to 4087 (it wants CRC bytes in the size so it goes to 4095
including those). Which means I probably set incorrect sg limits... I
guess I should fix that.

sdhci, which I'm currently developing, can do up to 0x7FFF. The register
is 16-bits, but the upper bit never sticks so I assume it cannot be used.

Rgds
Pierre
