From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 16:51:33 +0530
Message-ID: <CAAL8m4zN7iRAWcV32+z+MrFcgaOnk_r-npA9uLLS+S7w1O2LYg@mail.gmail.com>
References: <1327055619.1921.57.camel@deskari> <CAAL8m4xNj=-=tz7Fkv_MQzvQy5iNj9n10=00KAi0=ixtQ1GVVA@mail.gmail.com>
 <1327057644.1921.59.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61363 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751733Ab2ATLVz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 06:21:55 -0500
Received: by lahc1 with SMTP id c1so251741lah.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 03:21:54 -0800 (PST)
In-Reply-To: <1327057644.1921.59.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, Rajendra Nayak <rnayak@ti.com>

On Fri, Jan 20, 2012 at 4:37 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Fri, 2012-01-20 at 16:19 +0530, Govindraj wrote:
>> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > Hi,
>> >
>> > I'm testing v3.3-rc1 on OMAP3 overo, and I'm having problems probably
>> > related to PM.
>> >
>> > First, when I boot up, the console (via USB serial) is very laggy, it
>> > often takes many seconds until the key pressed appears so it's more or
>> > less unusable.
>>
>> can you try enabling CONFIG_CPU_IDLE ?
>
> Enabling CPU_IDLE does remove the problems. I don't know what it's
> supposed to do, but it seems to keep the MPU and DSS in ON state all the
> time, so the problem disappears.

3.3-rc1 has uart runtime patches merged we have removed uart dependency
for system to enter low powers states and used pm_qos calls,
but pm_qos api's seem do get activated only by enabling  config_cpu_idle.

Question to kevin/Paul,

Shouldn't system be doing wfi if cpu_idle is not enabled ?

since we are mapping omap3_pm_idle to pm_idle thread
system enters low power states even if config_cpu_idle is not enabled.
Is this expected behavior?

--
Thanks,
Govindraj.R
