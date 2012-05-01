From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V5 3/3] ARM: OMAP: Make OMAP clocksource source selection using kernel param
Date: Tue, 01 May 2012 10:03:49 -0700
Message-ID: <8762cfj0ju.fsf@ti.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
	<1335362340-14960-4-git-send-email-hvaibhav@ti.com>
	<alpine.DEB.2.00.1204260904580.10308@utopia.booyaka.com>
	<79CD15C6BA57404B839C016229A409A83E9FF819@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204261330010.10308@utopia.booyaka.com>
	<alpine.DEB.2.00.1204261636340.10308@utopia.booyaka.com>
	<79CD15C6BA57404B839C016229A409A83EA000B5@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:38481 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756174Ab2EARDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 13:03:52 -0400
Received: by ghrr20 with SMTP id r20so3229719ghr.27
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 10:03:51 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA000B5@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Fri, 27 Apr 2012 05:31:07 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> On Fri, Apr 27, 2012 at 04:08:07, Paul Walmsley wrote:
>> On Thu, 26 Apr 2012, Paul Walmsley wrote:
>> 
>> > Okay, thanks for testing.  Please do update this patch to use 
>> > omap_hwmod_enable(), etc.; see for example omap_dm_timer_init_one().
>> 
>> And, just to be explicit, the ioremap(), clk_get(), and clk_enable() 
>> should no longer be needed for OMAP2+, once you add the 
>> omap_hwmod_enable().
>> 
>
> What about OMAP1 architecture? Will it work? 

You'll need to move the ioremap/clk* usage into OMAP1 code
(mach-omap1/timer32k.c), and move the omap_hwmod_enable() into OMAP2+
code (mach-omap2/timer.c).

Then make the omap_init_clocksource_32k() just take the base address.

If counter_32k were a real driver (and it should be) this is how things
would work.  For example, the GPIO driver is shared between OMAP1 and
OMAP2+ and any SoC specific init is done in the SoC specific device init
code instead of the driver.

Hope this helps,

Kevin

