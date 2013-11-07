From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 07 Nov 2013 16:36:42 +0100
Message-ID: <527BB38A.1060609@gmail.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com> <CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com> <527A7E20.4040107@ti.com> <527B95E3.9060802@ti.com> <527B9673.60400@gmail.com> <527BAF63.10308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:65476 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab3KGPgp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Nov 2013 10:36:45 -0500
Received: by mail-bk0-f41.google.com with SMTP id na10so350250bkb.14
        for <linux-omap@vger.kernel.org>; Thu, 07 Nov 2013 07:36:43 -0800 (PST)
In-Reply-To: <527BAF63.10308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, joelf@ti.com, Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: Matt Porter <matt@ohporter.com>, balajitk@ti.com, s.neumann@raumfeld.com, Sekhar Nori <nsekhar@ti.com>, Russ Dill <Russ.Dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 11/07/2013 04:18 PM, Nishanth Menon wrote:
> Tested this on a vendor V3.12 tag based kernel:
> 
> Test patch: http://pastebin.com/AmnktQ7B
> test: echo -n "1">/sys/power/pm_print_times; rtcwake -d /dev/rtc0 -m
> mem -s 5
> 
> 
> with the current patch: http://pastebin.com/RujarRLV
> suspend_late and resume_early: http://pastebin.com/RujarRLV

These two are identical.

> suspend_noirq and resume_noirq: http://pastebin.com/nKfbm7Mj

And I can't see any difference between this one and the first one,
except for slightly different timings. Am I missing anything?

> one needs to be careful of the sequence - donot forget that
> omap_device also does stuff in the background to every SoC device in
> noirq - sequence is paramount. you would want to ensure edma is saving
> after every single dependent device is done with it's stuff and
> guarenteed to never request any further transaction, and resume is
> done before any of the dependent devices need edma. but edma is also a
> peripheral that omap_device and generic runtime pm framework deals
> with - so ensure sequences consider that as well.

So, what would you say which sequence is correct then? :)


Thanks,
Daniel



