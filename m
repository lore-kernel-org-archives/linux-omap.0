From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 0/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Date: Sat, 18 Nov 2006 22:42:02 +0100
Message-ID: <455F7E2A.60009@drzeus.cx>
References: <455DB1FB.1060403@indt.org.br> <200611181117.54242.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754009AbWKRVlz@vger.kernel.org>
In-Reply-To: <200611181117.54242.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Anderson Briglia <anderson.briglia@indt.org.br>, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> I thought the MMC vendors expected to see the actual user-typed
> password get SHA1-hashed into a value which would take up the whole
> buffer?  In general that's a good idea, since it promotes use of
> longer passphrases (more information) over short ones (easy2crack).
>   

This sounds like policy though, so it is something user space should
concern itself with. We should just provide the infrastructure.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
