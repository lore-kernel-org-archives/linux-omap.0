From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 6/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V5
Date: Sun, 29 Oct 2006 10:57:42 +0100
Message-ID: <45447B16.10708@drzeus.cx>
References: <20061020164914.012378000@localhost.localdomain> <20061020165139.911232000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932152AbWJ2J5p@vger.kernel.org>
In-Reply-To: <20061020165139.911232000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
List-Id: linux-omap@vger.kernel.org

Carlos Aguiar wrote:
> Removes an unused function: mmc_omap_switch_callback() and
> changed IRQ comparison in omap.c
>   

This looks completely unrelated to password support.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
