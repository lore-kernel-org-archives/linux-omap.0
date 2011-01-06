From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for undefined reference to 'omap2_prm_read_mod_reg'
Date: Thu, 06 Jan 2011 10:09:50 -0800
Message-ID: <87wrmhvr81.fsf@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930248201A7E@dbde02.ent.ti.com>
	<65442ed447ba6e1fc8dab9f9d944c03a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46223 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752368Ab1AFSJy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:09:54 -0500
Received: by mail-gw0-f51.google.com with SMTP id a18so7453970gwa.38
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 10:09:54 -0800 (PST)
In-Reply-To: <65442ed447ba6e1fc8dab9f9d944c03a@mail.gmail.com> (Santosh
	Shilimkar's message of "Thu, 6 Jan 2011 20:08:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: Premi, Sanjeev [mailto:premi@ti.com]
>> Sent: Thursday, January 06, 2011 8:03 PM
>> To: Shilimkar, Santosh; linux-omap@vger.kernel.org
>> Cc: Hilman, Kevin; tony@atomide.com; linux-arm-
>> kernel@lists.infradead.org; Shilimkar, Santosh; Paul Walmsley
>> Subject: RE: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix
>> for undefined reference to 'omap2_prm_read_mod_reg'
>>
>> > -----Original Message-----
>> > From: linux-omap-owner@vger.kernel.org
>> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> > Santosh Shilimkar
>> > Sent: Wednesday, January 05, 2011 4:27 PM
>> > To: linux-omap@vger.kernel.org
>> > Cc: Hilman, Kevin; tony@atomide.com;
>> > linux-arm-kernel@lists.infradead.org; Shilimkar, Santosh;
>> > Paul Walmsley
>> > Subject: [PATCH v2 2/5] omap2plus: prm: Trvial build break
>> > fix for undefined reference to 'omap2_prm_read_mod_reg'
>>
>> [snip]
>>
>> >
>> >  #ifndef __ASSEMBLER__
>> > -
>> > +/*
>> > + * Stub omap2xxx/omap3xxx functions so that common files
>> > + * continue to build when custom builds are used
>> > + */
>> > +#if defined(CONFIG_ARCH_OMAP4) &&
>> > !(defined(CONFIG_ARCH_OMAP2) ||	\
>> > +					defined(CONFIG_ARCH_OMAP3))
>> > +static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
>> > +{
>> > +	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
>> > +		"not suppose to be used on omap4\n");
>> > +	return 0;
>> > +}
>> Looking forward, the warning of incorrect SOC may be required
>> for when kernel is build for one specific SOC.
>>
>> Wouldn't it be easy/better to have common global function:
>>
>> void wrong_soc(char* func, int soc_id)
>> {
>> 	WARN_ONCE(1, "Function %s cannot be used for %d", func,
>> soc_id);
>> }
>>
>> OR we could have soc specific functions e.g.
>>
>> void omap2xxx_only (char* func)
>> {
>> 	WARN_ONCE(1, "Function %s is specific to OMAP2XXX");
>> }
>> ..etc..
>>
>> Later these functions can be called from the stubs.
>>
>> This is prelim idea, will need to be worked upon.
>>
> Not sure. May appear like over engineering considering it's a
> stub.
> Paul can comment.

I guess Sanjeev's approach is meant eliminate duplicate strings that
waste space.

Sanjeev, did you check whether multiple copies of the exact same string
actually exist in the binary?  I'm wondering if gcc is smart enough to
only have one copy of the string (but have doubts.)

Kevin
