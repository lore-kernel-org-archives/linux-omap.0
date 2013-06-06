From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info clean up
Date: Thu, 06 Jun 2013 15:27:21 -0700
Message-ID: <87zjv2ooxi.fsf@linaro.org>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
	<1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35900 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab3FFW1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 18:27:25 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so1323000pdj.26
        for <linux-omap@vger.kernel.org>; Thu, 06 Jun 2013 15:27:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 6 Jun 2013 04:00:39 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>, Sricharan R <r.sricharan@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> On Wed, 29 May 2013, Santosh Shilimkar wrote:
>
>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>> 
>> AM33XX only supports DT boot mode and with addition of
>> extracting module resources like, irq, dma and address space
>> from DT block, so now we can remove duplicate information from
>> hwmod data file.
>
> OK, guess I'll take your word for it that it all works.  The
> BeagleBone-white with appended DTB hasn't booted here since v3.7.
> And the BeagleBone-black with discrete DTB doesn't boot at all with
> current mainline, only with the TI vendor kernel & DTB...

Anyone care to shed light on what's missing for BeagleBone boot with
mainline currently?  

I've also not been able to boot a mainline kernel on the BeagleBone for
some time.

Kevin
