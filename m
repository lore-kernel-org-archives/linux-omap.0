From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Wed, 16 Feb 2011 18:17:34 +0530
Message-ID: <AANLkTimGZr9vbr1Z5LnN6p5v3y4MBz8iCx2G-ehsKtfV@mail.gmail.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
	<20110215171652.601c9c68.jhnikula@gmail.com>
	<20110215172931.3a6e45a8.jhnikula@gmail.com>
	<AANLkTi=3PCBOvFtd1T-=tDjXcs+_0opKqxVps+StCZqf@mail.gmail.com>
	<20110216134523.ba5d3917.jhnikula@gmail.com>
	<AANLkTiniGdh2_=eFjSaLsQ4VVG1Eh0F=0Tex-KNKspBf@mail.gmail.com>
	<20110216143112.6f756a94.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35102 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751067Ab1BPMrg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:47:36 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so688082bwz.5
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:47:35 -0800 (PST)
In-Reply-To: <20110216143112.6f756a94.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Feb 16, 2011 at 6:01 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Wed, 16 Feb 2011 17:24:30 +0530
> "Gulati, Shweta" <shweta.gulati@ti.com> wrote:
>
>> > Note proof of concept patch only. I omitted the comments and don't do
>> > explicit SR disable and I'd clean up the error paths in twl4030_power_init
>> > a bit before this (e.g. printing error codes). Not sure either is the
>> > twl4030-power.c right place for this or core.
>> You missed commit log which says that "T2 bit is required to enable I2C_SR
>> path of voltage control" it is not at all enabling SR, voltage scale
>> APIs VPforceupdate/ VCbypass
>> needs this path to be enabled.
>> And calling APIs twl_i2c_read/write in driver codebase does n't ensure correct
>> ordering of flag changes and twl_read/write.
>
> Ah, yeah. I forgot to comment that I tried shortly also to run this
> enable code from workqueue ~60 s after bootup and indeed SR didn't work
> if those autocomp sysfs nodes were set before setting the TWL SR bit and
> I believe same holds for voltage scaling too as you say.
>
> What I'm thinking is there actually need for some higher level
> control for these that quarantees the right order independently from
> when each module are initialized.
Yes there is a need.
Voltage control for TWL uses different ways VMODE/I2C1/I2C_SR
Most of the OMAP3+ boards uses I2C_SR, for this to function properly
SR_BIT on TWL side needs to be enabled but there could be some boards
that use VMODE  method of scaling, for those boards this bit has to be
disabled which can be done from board file that is why a flag is set to make
sure that API 'omap3_twl_set_sr_bit()' is called once and all initializations
are done in order so SR bit is set/cleared aptly.
> --
> Jarkko
>



-- 
Thanks,
Regards,
Shweta
