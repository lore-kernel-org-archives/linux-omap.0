From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Tue, 04 Dec 2012 13:39:44 -0800
Message-ID: <87pq2pa44f.fsf@deeprootsystems.com>
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
	<87mwxvathj.fsf@deeprootsystems.com>
	<79CD15C6BA57404B839C016229A409A83EBA3979@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45906 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab2LDVjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Dec 2012 16:39:33 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3053265pad.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Dec 2012 13:39:33 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EBA3979@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Tue, 4 Dec 2012 04:01:30 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, Igor Mazanov <i.mazanov@gmail.com>, Tony Lindgren <tony@atomide.com>, Jean Pihet <jean.pihet@newoldbits.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> On Mon, Dec 03, 2012 at 23:49:36, Kevin Hilman wrote:
>> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
>> 
>> >> >>> +static struct omap_hwmod am33xx_debugss_hwmod = {
>> >> >>> +       .name           = "debugss",
>> >> >>> +       .class          = &am33xx_debugss_hwmod_class,
>> >> >>> +       .clkdm_name     = "l3_aon_clkdm",
>> >> >>> +       .main_clk       = "debugss_ick",
>> >> >>> +       .flags          =  (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
>> >> 
>> >> Setting these flags would still leave the problem where JTAG clocks
>> >> are on when its not required no? In that case, what is the advantage
>> >> of this patch?
>> >> 
>> >
>> > I missed to wrap it around #ifdef CONFIG_DEBUG_KERNEL. I will submit the 
>> > formal patch shortly.
>> 
>> IMO, this should not be handled in the data at all (neither clock nor
>> hwmod), and should be handled at runtime/boot-time, not compile time.
>> 
>
> Wouldn't that become another interface/control for debug? We already have 
> various (standard) debug kernel parameters available.
>
> But I see your point, compile-time option will force users to rebuild kernel 
> just in order to disable JTAG/Debug clock.
>
>> The solution to this is to rather to have a small bit of code that
>> requests the debugss clocks that are needed for JTAG debug, so the
>> kernel knows they are in use.
>> 
>> That code could then be enabled at boot time via command-line or DT
>> option.
>> 
>
> In case of command-line, something like below???
>
> static int __init omap2_debug_clk_enable(char *str)
> {
> 	if (!str)
> 		return 0;
> 	
> 	if (!strcmp(str, "debug"))
> 		<enable debug clock>
>
> 	return 0;
> }
> early_param("debug", omap2_debug_clk_enable);

Yes, that's the idea I had in mind.  Though you don't want to override
"debug" here.  The debug option is specifically about default log levels
for the console and isn't really related to clocks.

Kevin

