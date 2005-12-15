From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Date: Thu, 15 Dec 2005 10:06:57 +0000
Message-ID: <20051215100657.GC32490@flint.arm.linux.org.uk>
References: <20051213213208.303580000@localhost.localdomain> <439F4AD6.9090203@indt.org.br> <439FC4A6.4010900@drzeus.cx> <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com> <43A11204.2070403@drzeus.cx> <20051215091220.GA29620@flint.arm.linux.org.uk> <43A136F1.3040700@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422684AbVLOKHK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43A136F1.3040700@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Anderson Lizardo <anderson.lizardo@gmail.com>, Anderson Briglia <anderson.briglia@indt.org.br>, Anderson Lizardo <anderson.lizardo@indt.org.br>, linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org, Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 15, 2005 at 10:27:13AM +0100, Pierre Ossman wrote:
> The spec I have says that this is a single block command. So such
> trickery would not work. It isn't explicit about padding so it might be
> possible to pad the data (since password length is specified in the
> data). If not, then we either ignore this function or have a system
> where we can detect limited hosts and print warnings.

What we need is someone with the real MMC spec to tell us about the
requirements here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
