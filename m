From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Fri, 7 Nov 2008 11:36:16 +0200
Message-ID: <6ed0b2680811070136m44b385cftf654c05cd9076798@mail.gmail.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
	 <20081106170445.GU21736@atomide.com>
	 <6ed0b2680811061219p40439337h2a6938009aa20522@mail.gmail.com>
	 <200811062154.08843.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:64883 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYKGJgS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 04:36:18 -0500
Received: by ey-out-2122.google.com with SMTP id 6so472816eyi.37
        for <linux-omap@vger.kernel.org>; Fri, 07 Nov 2008 01:36:16 -0800 (PST)
In-Reply-To: <200811062154.08843.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, Nov 7, 2008 at 7:54 AM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 06 November 2008, Grazvydas Ignotas wrote:
>> I have another SD slot connected to MMC2 via transceiver (in addition
>> to usual MMC1). I wonder how can I add support for that? The easiest
>> way is to add remaining twl_mmc2_* functions mmc-twl4030.c,
>
> I plan a followon to the patch I just sent, which will let the GPIOs
> hook up more generically and remove the need for most such non-generic
> functions.
>
>
>> and it
>> works, but this stuff would be useless for all other boards, and I
>> know you hate #ifdefs here.
>
> It would help if you explained what needed #ifdeffing, so we
> don't need to guess.
Card detect / WP handling for MMC2. If your following patches will
cover that, it will be great!

> I didn't see schematics in any easily
> found location on openpandora.org (that's your board?).
Yes, this is it. There are no public schematics yet, though.

> Do VMMC1 and GPIO-0/CD hook up to MMC1?
> Do VMMC2 and GPIO-1/CD hook up to MMC2?
Yes. There are also WP GPIOs connected from OMAP3 to both slots.

>> Another way is to just copy mmc-twl4030.c
>> and add stuff there, but that would result in lots of code
>> duplication. BTW, we also have wifi chip on MMC3.
>> Any ideas?
>
> For MMC3 you'll need to write some stuff to hook to that
> controller ... currently only MMC1 and MMC2 are set up.
ok, thanks.
