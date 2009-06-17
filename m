From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: MMC: Add mux for pins
Date: Wed, 17 Jun 2009 14:39:32 -0700
Message-ID: <878wjqy1yj.fsf@deeprootsystems.com>
References: <1244846488-28313-1-git-send-email-vikram.pandita@ti.com>
	<20090615081242.GE4474@atomide.com>
	<5C07676A-0A93-48DE-B4C0-5A6709BE34A8@gmail.com>
	<20090615110431.GO4474@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D146A@dbde02.ent.ti.com>
	<87y6rs2nu0.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D14A4@dbde02.ent.ti.com>
	<20090617081206.GD6605@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D18B1@dbde02.ent.ti.com>
	<87my86yau1.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D18C6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:53658 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208AbZFQVjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 17:39:33 -0400
Received: by wf-out-1314.google.com with SMTP id 26so302601wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 14:39:35 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F53D18C6@dbde02.ent.ti.com> (Vikram Pandita's message of "Thu\, 18 Jun 2009 00\:08\:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hugo Vincent <hugo.vincent@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>
>>>>If some pins are always needed, and don't have alternative pinouts, then
>>>>the common pins could be muxed in devices.c.
>>>
>>> This is the algo we can use for MMC pin muxing in that case:
>>>
>>> MMC1: No pin has mux clash
>>> 	Mux all 10 pins in devices.c
>>
>>Is this common across 34xx and 35xx?
>
> Yes this is common.
> Both are same OMAP3 marketed differently.

Yes, but they are in different packages, so I was curious if the pin
muxing is identical across the different packages.

Kevin
