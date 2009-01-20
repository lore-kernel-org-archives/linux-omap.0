From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3v4] Runtime check for OMAP35x
Date: Tue, 20 Jan 2009 12:53:02 -0800
Message-ID: <871vux66oh.fsf@deeprootsystems.com>
References: <1232120769-7569-1-git-send-email-premi@ti.com>
	<87mydmn9z3.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301C69A03AD@dbde02.ent.ti.com>
	<87ljt66lal.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301C69A054A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:6891 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbZATUxI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2009 15:53:08 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3277399rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2009 12:53:05 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301C69A054A@dbde02.ent.ti.com> (Sanjeev Premi's message of "Tue\, 20 Jan 2009 22\:11\:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

>> > <snip>--<snip>
>> >
>> >> > +#ifdef CONFIG_ARCH_OMAP35XX
>> >> > +static struct omap_globals omap35xx_globals = {
>> >> > +	.class	= OMAP35XX_CLASS,
>> >> > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
>> >> > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
>> >> > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
>> >> > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
>> >> > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
>> >> > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
>> >> > +};
>> >> 
>> >> This is exactly the same as omap34xx_globals.  Why is this needed?
>> >
>> 
>> > [sp] I have tried to add minimal support for OMAP35x. Since OMAP34x 
>> > and OMAP35x seem to be compatible today, this structure 
>> seems same. As 
>> > more code for specific OMAP35x variants comes in, I expect this to 
>> > change.
>> >
>> > The key difference here (as against OMAP34x) is use of 
>> OMAP35XX_CLASS; 
>> > which helps in identifying the different OMAP variants. We 
>> could have 
>> > 're-used' OMAP35XX_CLASS, it I wouldn't be right as this 
>> definition is 
>> > used to print the CPU name and Si version in id.c.
>> >
>> > With this patch, boot log with show (for example) "OMAP3530 ES2.1"
>> > on the OMAP3530 EVM - which can be considered same as 
>> OMAP3430 ES2.1; 
>> > but with 3503, 3515 and 3525 the print would read 3403, 3415,
>> > 3425 resp; this definitley would not be right.
>> 
>> I was not asking about the patch as a whole, I was commenting 
>> only on the addition of the omap35xx_globals variable.  You 
>> added a new struct which is exactly the same as the 35xx 
>> struct instead of just re-using the old one with a new name 
>> as I suggested.
>> 
>> Kevin
>
> [sp] This would mean adding another #ifdef to get the right
> _CLASS. From earlier discussion, I understood that we wanted to
> remove #ifdefs so that same image can work for OMAP35x and OMAP34x.

Indeed, I hadn't noticed the new class definition.  This looks ok to
me.

Kevin



