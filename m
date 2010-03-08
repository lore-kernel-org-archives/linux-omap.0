From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC part1/2 merge v2 RESEND][PATCH 01/10] OMAP3: serial: Check for zero-based physical addr
Date: Mon, 08 Mar 2010 13:40:05 -0800
Message-ID: <874okqtruy.fsf@deeprootsystems.com>
References: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
	<1268069332-14082-2-git-send-email-saaguirre@ti.com>
	<20100308182443.GD6630@gandalf>
	<A24693684029E5489D1D202277BE894453E4CF84@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:56289 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab0CHVkL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 16:40:11 -0500
Received: by fxm19 with SMTP id 19so6829568fxm.21
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 13:40:10 -0800 (PST)
In-Reply-To: <A24693684029E5489D1D202277BE894453E4CF84@dlee02.ent.ti.com> (Sergio Aguirre's message of "Mon\, 8 Mar 2010 14\:28\:21 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

"Aguirre, Sergio" <saaguirre@ti.com> writes:

>> -----Original Message-----
>> From: Felipe Balbi [mailto:me@felipebalbi.com]
>> Sent: Monday, March 08, 2010 12:25 PM
>> To: Aguirre, Sergio
>> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Pandita, Vikram; Paul
>> Walmsley; Tony Lindgren
>> Subject: Re: [RFC part1/2 merge v2 RESEND][PATCH 01/10] OMAP3: serial:
>> Check for zero-based physical addr
>> 
>> On Mon, Mar 08, 2010 at 11:28:43AM -0600, Sergio Aguirre wrote:
>> > @@ -727,6 +733,10 @@ void __init omap_serial_init_port(int port)
>> >  	pdev = &uart->pdev;
>> >  	dev = &pdev->dev;
>> >
>> > +	/* Don't proceed if there's no clocks available */
>> > +	if (!uart->ick || !uart->fck)
>> > +		return;
>> 
>> with that loop getting the clocks I would expect this not to happen. If
>> it happens, then I would guess it deserves a
>> BUG_ON(!uart->ick || !uart->fck)
>
> Yeah, makes sense.
>
> Will fix.

But please use WARN_ON() check intead of BUG*.  Don't need to panic
the whole kernel for this.

Kevin
