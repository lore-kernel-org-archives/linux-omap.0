From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/09] OMAP:GPIO:Implement GPIO in HWMOD way
Date: Mon, 10 May 2010 08:14:35 -0700
Message-ID: <87pr13okkk.fsf@deeprootsystems.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5387A73@dbde02.ent.ti.com>
	<20100507153204.GB387@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52739 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0EJPOt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 11:14:49 -0400
Received: by mail-vw0-f46.google.com with SMTP id 17so147317vws.19
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 08:14:49 -0700 (PDT)
In-Reply-To: <20100507153204.GB387@atomide.com> (Tony Lindgren's message of "Fri\, 7 May 2010 08\:32\:05 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren <tony@atomide.com> writes:

> * Varadarajan, Charulatha <charu@ti.com> [100506 23:52]:
>> Tony/ Kevin,
>> 
>> > -----Original Message-----
>> > From: Varadarajan, Charulatha
>> > Sent: Thursday, April 22, 2010 9:25 PM
>> > To: linux-omap@vger.kernel.org
>> > Cc: Nayak, Rajendra; paul@pwsan.com; tony@atomide.com;
>> > khilman@deeprootsystems.com; Varadarajan, Charulatha
>> > Subject: [PATCH 00/09] OMAP:GPIO:Implement GPIO in HWMOD way
>> > 
>> > This patch series implements GPIO as an early platform driver.
>> > It makes OMAP2PLUS specific GPIO to get adapted to HWMOD FW.
>> > OMAP1 specific GPIO is implemented as early platform device.
>> > 
>> > This patch series is created on "origin/pm-wip/hwmods". 
>> 
>> Planning to send few more patches for adapting some other
>> drivers to HWMOD FW. 
>> Which tree should those patches be created on?
>> LO mainline? or hwmods branch? or runtime branch?
>
> All the patches should be against the most recent tag
> in Linus' mainline tree, currently v2.6.34-rc6.
>
> If there are some dependencies to other patches, we need
> to get those upstream immediately.

Please use pm-wip/runtime, which is currently based on v2.6.34-rc6
+ PM changes already submitted for 2.6.35 (3 patches)

In addition, this has the in-progress UART + MMC hwmod changes.

Kevin
