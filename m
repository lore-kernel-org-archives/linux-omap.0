From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: FEATURES - is it good enough
Date: Fri, 20 Nov 2009 10:35:39 -0800
Message-ID: <87eint3uys.fsf@deeprootsystems.com>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
	<1258732956-18799-2-git-send-email-vikram.pandita@ti.com>
	<4B06BF4D.2090201@ti.com>
	<A24693684029E5489D1D202277BE89444DA61E77@dlee02.ent.ti.com>
	<4B06C0F0.7070007@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BBC43A27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:65351 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbZKTSff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 13:35:35 -0500
Received: by pxi42 with SMTP id 42so1947479pxi.5
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 10:35:41 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BBC43A27@dbde02.ent.ti.com> (Santosh Shilimkar's message of "Fri\, 20 Nov 2009 22\:36\:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

[...]

>> >
>> > Probably not something ot be attached in this patch, but...
>> >
>> > I'm a bit curious about something:
>> >
>> > Why touching omap3_features in OMAP4?
>> >
>> > Isn't there a omap4_features?
>> >
>> > Or even better, an omap_features?
>
> This "is_feature" suppose to take care of Errata's also, is it?

"It's not a bug it's a feature." :)

> This is errata more than a feature..... We better differentiate in
> this regard

I agree, I have a hard time calling this empty fifo read fault a
"feature."  We need a similar thing for errata.

Kevin

