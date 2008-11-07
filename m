From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [patch 2.6.28-rc3-omap git] hsmmc gpio updates
Date: Fri, 7 Nov 2008 10:46:53 -0800
Message-ID: <5e088bd90811071046p2afc06davdf0ea77bde287f23@mail.gmail.com>
References: <200811062115.30519.david-b@pacbell.net>
	 <5e088bd90811070619h73120f30ye7608e2aaff5e514@mail.gmail.com>
	 <200811070950.50033.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:28495 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882AbYKGSqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 13:46:55 -0500
Received: by ey-out-2122.google.com with SMTP id 6so600527eyi.37
        for <linux-omap@vger.kernel.org>; Fri, 07 Nov 2008 10:46:53 -0800 (PST)
In-Reply-To: <200811070950.50033.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, Nov 7, 2008 at 9:50 AM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 07 November 2008, Steve Sakoman wrote:
>> Nice work!  Overo uses TWL4030 gpio-0 for card detect (just like
>> Beagle) and GPIO-54 for WP.
>>
>> Would you like me to prepare a patch to add on top of yours or would
>> you prefer to add it to yours (if you have a revision planned)?
>
> Patch on top of this, please; I have no revision planned.
> Don't forget to set up the mmc_cd bitmask too!

OK, will do.

> How can WP work for a Micro-SD card though?  I don't see a
> switch on any of mine...

Darn good question!  I never have either.  But from looking at the
schematic there appears to be a pin for it on the microSD socket and
Gordon has it connected to GPIO-54.  I'll have to ask him about that .
. .

Steve
