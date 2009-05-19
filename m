From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
Date: Tue, 19 May 2009 09:57:14 -0700
Message-ID: <874ovh6nf9.fsf@deeprootsystems.com>
References: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen@nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162038BED5CF1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f134.google.com ([209.85.222.134]:53198 "EHLO
	mail-pz0-f134.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZESQ5P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 12:57:15 -0400
Received: by pzk40 with SMTP id 40so310806pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 09:57:16 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BED5CF1@dlee02.ent.ti.com> (Richard Woodruff's message of "Mon\, 18 May 2009 14\:23\:11 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Niilo Minkkinen <ext-niilo.1.minkkinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Niilo Minkkinen
>> Sent: Monday, May 18, 2009 9:54 AM
>
>> Omap3 MUSB AUTOIDLE functionality configured through OTG_SYSCONFIG
>> register prevents the device from going into retention.
>> This is a workaround (by Richard Woodruff/TI), as his comment :
>> > A new MUSB bug which is a match to data below was identified very
>> > recently (on hardware and in simulation).
>> > This bug is in 3430 and not 3630.
>> > As a priority test (and as new default) you should have engineers
>> > disable autoidle for MUSB block.
>> > This is the workaround which will show up in next errata.
>>
>> Signed-off-by: Niilo Minkkinen <ext-niilo.1.minkkinen@nokia.com>
>
> Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
>
> Yes this is needed for 34xx. Side note is this cost around 1mW of power during active mode of MUSB. When device is not active cost is not significant.  System impact depends on duty cycle of MUSB in usecase.
>

While this makes its way upstream, I'll pull into PM branch.

Kevin
