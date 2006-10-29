From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 5/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V5
Date: Sun, 29 Oct 2006 10:57:05 +0100
Message-ID: <45447AF1.7090208@drzeus.cx>
References: <20061020164914.012378000@localhost.localdomain> <20061020165136.664879000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932144AbWJ2J5J@vger.kernel.org>
In-Reply-To: <20061020165136.664879000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
List-Id: linux-omap@vger.kernel.org

Carlos Aguiar wrote:
> Implement MMC password force erase, remove password, change password,
> unlock card and assign password operations. It uses the sysfs mechanism
> to send commands to the MMC subsystem. 
>   

There are some indentation problems with this patch.

Also, what's the difference between "change" and "assign"? The code
seems to do the same thing.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
