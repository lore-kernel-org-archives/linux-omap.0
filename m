From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Mon, 03 Dec 2012 10:19:36 -0800
Message-ID: <87mwxvathj.fsf@deeprootsystems.com>
References: <k80da6$61d$1@ger.gmane.org>
	<CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
	<20121121183809.GZ18567@atomide.com>
	<CAK0ocyD25pRcQthN90inWy-95Yaa-B94rw724_uS5Y7FRA4qjQ@mail.gmail.com>
	<50ADBB5B.7090401@ti.com>
	<CAK0ocyCe3oJ8ynpNWpzcCFHtG3J4u7NBeNPTJK0GikFHaPAXOA@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83EB7F222@DBDE01.ent.ti.com>
	<CAK0ocyD7fGzj1GuFP7EhFYqmLv66A0phNrxV6rAL9b9ejPYfvg@mail.gmail.com>
	<CAD=GYparyZ8kB+pX+SptSaNPHD-Ey9vBC1Q4nDcTKJLenpNK=w@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83EB7FB16@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61149 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab2LCST2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Dec 2012 13:19:28 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2183139pbc.19
        for <linux-omap@vger.kernel.org>; Mon, 03 Dec 2012 10:19:28 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB7FB16@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Fri, 23 Nov 2012 06:04:03 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, Igor Mazanov <i.mazanov@gmail.com>, Tony Lindgren <tony@atomide.com>, Jean Pihet <jean.pihet@newoldbits.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> >>> +static struct omap_hwmod am33xx_debugss_hwmod = {
>> >>> +       .name           = "debugss",
>> >>> +       .class          = &am33xx_debugss_hwmod_class,
>> >>> +       .clkdm_name     = "l3_aon_clkdm",
>> >>> +       .main_clk       = "debugss_ick",
>> >>> +       .flags          =  (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
>> 
>> Setting these flags would still leave the problem where JTAG clocks
>> are on when its not required no? In that case, what is the advantage
>> of this patch?
>> 
>
> I missed to wrap it around #ifdef CONFIG_DEBUG_KERNEL. I will submit the 
> formal patch shortly.

IMO, this should not be handled in the data at all (neither clock nor
hwmod), and should be handled at runtime/boot-time, not compile time.

The solution to this is to rather to have a small bit of code that
requests the debugss clocks that are needed for JTAG debug, so the
kernel knows they are in use.

That code could then be enabled at boot time via command-line or DT
option.

Kevin
