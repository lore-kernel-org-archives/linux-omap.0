From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Date: Tue, 13 Dec 2005 14:03:53 -0800
Message-ID: <200512131403.53983.david-b@pacbell.net>
References: <20051213213208.303580000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030255AbVLMWD7@vger.kernel.org>
In-Reply-To: <20051213213208.303580000@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Lizardo <anderson.lizardo@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, Anderson Briglia <anderson.briglia@indt.org.br>, Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hey, cool ... glad to see that's ready now!
I'll have to give it a try when I have a spare moment.

Is there a writeup on how to hook this up with the key retention
infrastructure?  I know many folk are unfamiliar with that, and
I seem to recall a need for some userspace tweaks.  (Like SHA1
hashing of passphrases to generate MMC keys, and maybe storing
keys in some per-user file using some user interface.)

- Dave
