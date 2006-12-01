From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
Date: Fri, 01 Dec 2006 22:20:10 +0100
Message-ID: <45709C8A.1010701@drzeus.cx>
References: <4564640B.1070004@indt.org.br> <45680308.4040809@drzeus.cx> <456AEC16.3010009@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161815AbWLAVUI@vger.kernel.org>
In-Reply-To: <456AEC16.3010009@indt.org.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, ext David Brownell <david-b@pacbell.net>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Anderson Briglia wrote:
> ext Pierre Ossman wrote:
>>
>> This definition makes them look like bits, which is not how they are
>> used.
>
> How can I improve this? Defining using integers directly?
>

Precisely.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
