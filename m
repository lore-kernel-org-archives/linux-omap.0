From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [rtc-linux] Re: [PATCH v4 0/4] pm: Add power off control
Date: Sat, 23 Nov 2013 12:23:35 -0500
Message-ID: <CANacCWxwr7s6ZvjWRbg_JGgc-Q1sJa-KJCLrSCK4BvSrmL5Eug@mail.gmail.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13EAD58C2@DBDE01.ent.ti.com>
	<CA+Bv8XbUa7xPd8V7LQCmFbbdQvORUK1X0xBPzAhKUFFjjho2jw@mail.gmail.com>
	<20131122195041.GF18968@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:34437 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab3KWRXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Nov 2013 12:23:36 -0500
Received: by mail-qa0-f41.google.com with SMTP id j5so1541223qaq.0
        for <linux-omap@vger.kernel.org>; Sat, 23 Nov 2013 09:23:36 -0800 (PST)
In-Reply-To: <20131122195041.GF18968@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: Russ Dill <Russ.Dill@ti.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Fri, Nov 22, 2013 at 2:50 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
[...]
>
> And why specifically *2* seconds, instead of *1* or *33* ?
>
> Sounds a bit like voodoo magic on this side :-)

Consider the scenario where the actual time is 00:00:01.95 secs.
Due to the 1 second resolution of the RTC, reading the registers
would return 00:00:01. By the time we get to updating the
RTC register for the shutdown by adding 1 sec (theoretically the
smallest delta) we could end up programming the time that's already
passed and in such cases the system will never shut down.

2 secs is the smallest delay that we can use to get the system
to shutdown reliably.

So it's not voodoo magic after all ;)

Regards,
Vaibhav
