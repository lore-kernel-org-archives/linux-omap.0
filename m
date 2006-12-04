From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
Date: Mon, 04 Dec 2006 21:23:17 +0100
Message-ID: <457483B5.8060205@drzeus.cx>
References: <4564640B.1070004@indt.org.br> <45680308.4040809@drzeus.cx> <45746CD3.1000604@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937371AbWLDUXW@vger.kernel.org>
In-Reply-To: <45746CD3.1000604@indt.org.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, ext David Brownell <david-b@pacbell.net>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Anderson Briglia wrote:
>
> Actually they represent the bits regarding the modes and it is used
> when we
> have to send the LOCK/UNLOCK mode on the command data block, according
> to the MMC Spec.
> If you take a look at mmc_lock_unlock function, we use those modes to
> set the right bit
> when composing the command data block.
> This definition makes the code more legible and simple.

In that case you need to change the code to make sure it is clear that
it is bits and not values. Also, your definition for
MMC_LOCK_MODE_UNLOCK is wrong.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
