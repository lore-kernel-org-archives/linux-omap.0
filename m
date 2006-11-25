From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 1/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_ignore_locked.diff
Date: Sat, 25 Nov 2006 09:39:04 +0100
Message-ID: <45680128.5000506@drzeus.cx>
References: <45646330.9010402@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757895AbWKYIi7@vger.kernel.org>
In-Reply-To: <45646330.9010402@indt.org.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, ext David Brownell <david-b@pacbell.net>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Anderson Briglia wrote:
> When a card is locked, only commands from the "basic" and "lock card"
> classes
> are accepted. To be able to use the other commands, the card must be
> unlocked
> first.
>
> This patch prevents the device drivers from trying to run privileged
> class
> commands on locked MMC cards, which will fail anyway.
>

You still need to change the commit message, but otherwise the patch
looks ok.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
