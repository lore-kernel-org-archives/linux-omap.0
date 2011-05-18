From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap3: boot message is not an error
Date: Wed, 18 May 2011 10:57:03 +0200
Message-ID: <87pqngxu74.fsf@ti.com>
References: <1305644565-26233-1-git-send-email-premi@ti.com>
	<1305653621.2694.4.camel@vence>
	<20110518084552.1e65f00f.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58911 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755174Ab1ERI5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 04:57:19 -0400
Received: by wyg36 with SMTP id 36so1318021wyg.24
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 01:57:17 -0700 (PDT)
In-Reply-To: <20110518084552.1e65f00f.jhnikula@gmail.com> (Jarkko Nikula's
	message of "Wed, 18 May 2011 08:45:52 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

Jarkko Nikula <jhnikula@gmail.com> writes:

> On Tue, 17 May 2011 19:33:41 +0200
> Kevin Hilman <khilman@ti.com> wrote:
>
>> Hi Sanjeev,
>> 
>> On Tue, 2011-05-17 at 20:32 +0530, Sanjeev Premi wrote:
>> > With current level, it shows up on the console
>> > despite using 'silent' in bootargs.
>> > 
>> > Signed-off-by: Sanjeev Premi <premi@ti.com>
>> > ---
>> > 
>> >  1) Couldn't find better text on commit message.
>> >     Any suggestions?
>> > 
>> >  2) Though pm34xx.x is changed, the change itself
>> >     is no related to power management. Hence, did
>> >     annotate "pm:"
>> 
>> Well, it's a change to PM core code, so PM prefix is fine.  How about:
>> 
>> OMAP3: PM: boot message is not an error, use pr_info
>> 
>> Also, please Cc linux-arm-kernel, and I will queue this fix for 2.6.40.
> ...  
>> >  arch/arm/mach-omap2/pm34xx.c |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> > 
> Does this bootup info print here bring any benefit for pm developers
> and users?
>
> For me it looks it can be removed as the pm34xx.c is always compiled
> and initialized for CONFIG_ARCH_OMAP3 so IMHO only error prints from
> pm34xx.c are relevant.

Good point.  It's probably better to simply remove the printk.

Kevin
