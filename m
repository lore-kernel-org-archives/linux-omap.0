From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
Date: Wed, 29 Sep 2010 15:24:22 -0700
Message-ID: <87tyl8rxwp.fsf@deeprootsystems.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44102 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0I2WYY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 18:24:24 -0400
Received: by pxi10 with SMTP id 10so307847pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 15:24:24 -0700 (PDT)
In-Reply-To: <20100928201844.GI3117@atomide.com> (Tony Lindgren's message of
	"Tue, 28 Sep 2010 13:18:44 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Charulatha Varadarajan <charu@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj R." <govindraj.raja@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100928 11:25]:
>> Tony,
>> 
>> The following pull request will bring hwmod driver conversions for
>> watchdog, UART and i2c drivers.  It is based on your omap-for-linus
>> branch.
>> 
>> The i2c driver is waiting for final signoff/ack from the upstream
>> subsystem maintainers, but are otherwise ready to go for broader
>> testing.  After I get the final ack, I will update the branch for a
>> final pull.
>> 
>> In the meantime, I'd like to get them into l-o master (or omap-testing)
>> for broader testing.
>
> Tried pulling it but I'm getting tons of these errors on omap2:

Tony, 

Can you pull the latest version of my pm-hwmods branch from:
ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-hwmods

This version has the updated patch from Rajendra for i2c as well as some
UART3 fixes for a problem he noticed on 2430 as well.

Before this is final, I'm still waiting on two things:

1) ack from Ben Dooks for the drivers/i2c change
2) additional patch from Charu to prevent reset when
   CONFIG_OMAP_WATCHDOG=n

Kevin
