From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 1/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Date: Fri, 17 Nov 2006 17:41:29 +0100
Message-ID: <455DE639.6080308@drzeus.cx>
References: <455DB297.1040009@indt.org.br> <20061117160951.GD28514@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933709AbWKQQlW@vger.kernel.org>
In-Reply-To: <20061117160951.GD28514@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux-kernel@vger.kernel.org, ext David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Russell King wrote:
> On Fri, Nov 17, 2006 at 09:01:11AM -0400, Anderson Briglia wrote:
>   
>>  #define MMC_CAP_BYTEBLOCK	(1 << 2)	/* Can do non-log2 block 
>>  sizes */
>> +#define MMC_CAP_LOCK_UNLOCK	(1 << 3)	/* Host password support 
>> capability */
>>     
>
> What's the point of this capability.  If the host can do BYTEBLOCK transfers
> it can send the password commands.
>
>   

This has been pointed out in the past. Anderson, please make sure you
address all the previous concerns before sending out a new patch set.
This just creates extra work for us.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
