From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4+: Move SRAM data to DT
Date: Tue, 3 Sep 2013 08:07:56 -0700
Message-ID: <CA+Bv8XZ4sxze7-vGK67yO3ujy+ASAffnT84mFkq8vNP8pG3Cgw@mail.gmail.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
	<1377598305-15539-3-git-send-email-rnayak@ti.com>
	<CA+Bv8XaK3fBkRZjN8dCzi9dt9C3SVe2nT746Szzb_F=69w=fMw@mail.gmail.com>
	<1378218919.5891.3.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:59319 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab3ICPH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 11:07:56 -0400
Received: by mail-qe0-f48.google.com with SMTP id t9so2424202qeq.35
        for <linux-omap@vger.kernel.org>; Tue, 03 Sep 2013 08:07:56 -0700 (PDT)
In-Reply-To: <1378218919.5891.3.camel@weser.hi.pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, bcousson@baylibre.com, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Tue, Sep 3, 2013 at 7:35 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 03.09.2013, 06:56 -0700 schrieb Russ Dill:
>> On Tue, Aug 27, 2013 at 3:11 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>> > Use drivers/misc/sram.c driver to manage SRAM on all DT only
>> > OMAP platforms (am33xx, am43xx, omap4 and omap5) instead of
>> > the existing private implementation.
>> >
>> > Address and size related data  is removed from mach-omap2/sram.c
>> > and now passed to drivers/misc/sram.c from DT.
>> >
>> > Users can hence use general purpose allocator apis instead of
>> > OMAP private ones to manage and use SRAM.
>> >
>> > Currently there are no users on SRAM on these platfoms.
>> >
>> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>
>> I was trying to experiment with this on am33xx, but I noticed that the
>> ioremap region is not marked exec, so it cannot be used to run code.
>
> Could you outline a use-case where you would need to execute code from
> SRAM while running in a linux system? I'm curious what you would use
> this for.

Code that needs to disable or reconfigure the memory controller is the
common use case. Some suspend/resume code even goes beyond that and
performs steps that must be done *after* the memory controller has
powered down, such as putting PLLs in bypass, etc.
