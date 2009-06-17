From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: MMC: Add mux for pins
Date: Wed, 17 Jun 2009 11:27:50 -0700
Message-ID: <87my86yau1.fsf@deeprootsystems.com>
References: <1244846488-28313-1-git-send-email-vikram.pandita@ti.com>
	<20090615081242.GE4474@atomide.com>
	<5C07676A-0A93-48DE-B4C0-5A6709BE34A8@gmail.com>
	<20090615110431.GO4474@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D146A@dbde02.ent.ti.com>
	<87y6rs2nu0.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D14A4@dbde02.ent.ti.com>
	<20090617081206.GD6605@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D18B1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:47752 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbZFQS2a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 14:28:30 -0400
Received: by pxi27 with SMTP id 27so554944pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 11:28:33 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F53D18B1@dbde02.ent.ti.com> (Vikram Pandita's message of "Wed\, 17 Jun 2009 23\:14\:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hugo Vincent <hugo.vincent@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>
>>If some pins are always needed, and don't have alternative pinouts, then
>>the common pins could be muxed in devices.c.
>
> This is the algo we can use for MMC pin muxing in that case:
>
> MMC1: No pin has mux clash
> 	Mux all 10 pins in devices.c 

Is this common across 34xx and 35xx?

> MMC2: MUX CLK,CMD,D0-D3 in devices.c: D4-D7 have mux clash
> 	In case board needs 8 bit support,
> 	then in devices.c print KERN_WARNING "Configure MMC2:D4-D7 mux in board file"

I don't think you need a KERN_WARNING, what if the board code does this
later?  Probably a comment in the code would suffice.

> MMC3: All pins have mux clash: No mux done in devices.c
> 	In case board specifies MMC3 usage, 
> 	then in devices.c print KERN_WARNING "Configure MMC3 mux in board file"
>
> Let me know if this is final and I can submit a patch.

Kevin


