From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC part1/2 merge][PATCH 06/10] omap3: serial: Fix uart4 handling for 3630
Date: Mon, 08 Mar 2010 08:52:21 -0800
Message-ID: <87fx4awybe.fsf@deeprootsystems.com>
References: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
	<1267625925-22616-7-git-send-email-saaguirre@ti.com>
	<87sk8ez96n.fsf@deeprootsystems.com>
	<A24693684029E5489D1D202277BE894453D6866B@dlee02.ent.ti.com>
	<A24693684029E5489D1D202277BE894453D68DC8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f200.google.com ([209.85.222.200]:35001 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab0CHQwY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 11:52:24 -0500
Received: by pzk38 with SMTP id 38so1129126pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 08:52:23 -0800 (PST)
In-Reply-To: <A24693684029E5489D1D202277BE894453D68DC8@dlee02.ent.ti.com> (Sergio Aguirre's message of "Mon\, 8 Mar 2010 10\:44\:16 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Aguirre, Sergio" <saaguirre@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Aguirre, Sergio
>> Sent: Friday, March 05, 2010 5:12 PM
>> To: Kevin Hilman
>> Cc: linux-omap@vger.kernel.org
>> Subject: RE: [RFC part1/2 merge][PATCH 06/10] omap3: serial: Fix uart4
>> handling for 3630
>> 
>> 
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Friday, March 05, 2010 4:38 PM
>> 
>> <snip>
>> 
>> > > @@ -694,6 +698,10 @@ void __init omap_serial_early_init(void)
>> > >
>> > >  		if (cpu_is_omap44xx())
>> > >  			p->irq += 32;
>> > > +
>> > > +		/* IRQ for UART4 in omap3630 is 80 */
>> > > +		if (cpu_is_omap3630() && (i == 3))
>> > > +			p->irq = 80;
>> >
>> > Should add a symbolic name to irqs.h and use it here, instead
>> > of hard-coded constant.
>> 
>> Sounds like a nice idea! Thanks!
>> 
>> I'll update the patchset and resend.
>
> Actually, I have been thinking on a patch to remove all magic numbering, also for OMAP4... I'll think about it and include it in the next version.

Don't spend too much time on this.

Soon, this serial core will be converted over to hwmod (RFC patches
already posted) so all the IRQ and base address stuff will be
handled by hwmod.

Kevin



