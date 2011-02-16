From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Wed, 16 Feb 2011 14:31:12 +0200
Message-ID: <20110216143112.6f756a94.jhnikula@gmail.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
	<20110215171652.601c9c68.jhnikula@gmail.com>
	<20110215172931.3a6e45a8.jhnikula@gmail.com>
	<AANLkTi=3PCBOvFtd1T-=tDjXcs+_0opKqxVps+StCZqf@mail.gmail.com>
	<20110216134523.ba5d3917.jhnikula@gmail.com>
	<AANLkTiniGdh2_=eFjSaLsQ4VVG1Eh0F=0Tex-KNKspBf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37131 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab1BPMaq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 07:30:46 -0500
Received: by eye27 with SMTP id 27so722588eye.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:30:44 -0800 (PST)
In-Reply-To: <AANLkTiniGdh2_=eFjSaLsQ4VVG1Eh0F=0Tex-KNKspBf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, 16 Feb 2011 17:24:30 +0530
"Gulati, Shweta" <shweta.gulati@ti.com> wrote:

> > Note proof of concept patch only. I omitted the comments and don't do
> > explicit SR disable and I'd clean up the error paths in twl4030_power_init
> > a bit before this (e.g. printing error codes). Not sure either is the
> > twl4030-power.c right place for this or core.
> You missed commit log which says that "T2 bit is required to enable I2C_SR
> path of voltage control" it is not at all enabling SR, voltage scale
> APIs VPforceupdate/ VCbypass
> needs this path to be enabled.
> And calling APIs twl_i2c_read/write in driver codebase does n't ensure correct
> ordering of flag changes and twl_read/write.

Ah, yeah. I forgot to comment that I tried shortly also to run this
enable code from workqueue ~60 s after bootup and indeed SR didn't work
if those autocomp sysfs nodes were set before setting the TWL SR bit and
I believe same holds for voltage scaling too as you say.

What I'm thinking is there actually need for some higher level
control for these that quarantees the right order independently from
when each module are initialized.

-- 
Jarkko
