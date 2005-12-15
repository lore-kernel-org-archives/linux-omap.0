From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Date: Thu, 15 Dec 2005 10:27:13 +0100
Message-ID: <43A136F1.3040700@drzeus.cx>
References: <20051213213208.303580000@localhost.localdomain> <439F4AD6.9090203@indt.org.br> <439FC4A6.4010900@drzeus.cx> <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com> <43A11204.2070403@drzeus.cx> <20051215091220.GA29620@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422642AbVLOJ2J@vger.kernel.org>
In-Reply-To: <20051215091220.GA29620@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>, Anderson Lizardo <anderson.lizardo@gmail.com>, Anderson Briglia <anderson.briglia@indt.org.br>, Anderson Lizardo <anderson.lizardo@indt.org.br>, linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org, Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org

Russell King wrote:
>
> You seem to have ignored my message on why this is required.  The MMCI
> driver requires that all transfers be a multiple of 1 << blksz_bits.
> So, if you want to transfer (eg) 9 bytes, it must be transferred as 9
> one byte blocks.  So set blksz_bits to 0 and blocks to 9.
>
>   

I haven't seen any such comments from you, so I haven't ignored anything.

The spec I have says that this is a single block command. So such
trickery would not work. It isn't explicit about padding so it might be
possible to pad the data (since password length is specified in the
data). If not, then we either ignore this function or have a system
where we can detect limited hosts and print warnings.

Rgds
Pierre
