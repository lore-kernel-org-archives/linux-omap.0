From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Fri, 31 Oct 2008 16:35:36 -0700
Message-ID: <5e088bd90810311635p26bdd8b9n3e7429bac29bd82c@mail.gmail.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
	 <200810302012.35317.david-b@pacbell.net>
	 <5e088bd90810302105n1132c280ga39179c057e55c3f@mail.gmail.com>
	 <200810310300.24515.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:29168 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbYJaXfh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 19:35:37 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1516295rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 16:35:36 -0700 (PDT)
In-Reply-To: <200810310300.24515.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Oct 31, 2008 at 3:00 AM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 30 October 2008, Steve Sakoman wrote:
>> > Overo has its SDIO WLAN chip (libertas) hard wired to the second controller,
>> > as I understand things ... or maybe it's the third one.  :)
>>
>> Correct!  The wi2wi chip is connected to mmc2 with a 4 bit data path.
>
> With the appended patch on top of Tony's four, I get:
>
>  mmc1: new SDIO card at address 0001
>  firmware: requesting sd8686_helper.bin
>  ...
>  libertas: can't load helper firmware
>  libertas: failed to load helper firmware
>  libertas_sdio: probe of mmc1:0001:1 failed with error -2
>
> So, progress.  What's the best place to get that stuff?

I picked up a copy of the sd8686 helper and firmware from the Marvell
site (http://www.marvell.com/drivers/search.do)

I specified Linux 2.6 Fedora as the OS and used
SD-8686-LINUX26-SYSKT-9.70.3.p24-26409.P45-GPL

I copied the helper and sd8686.bin to /lib/firmware (and renamed the
helper to sd8686_helper.bin in the process)

Didn't have much more success though :-(

The error is slightly different now:

mmc1: new SDIO card at address 0001
firmware: requesting sd8686_helper.bin
libertas: failed to load helper firmware
libertas_sdio: probe of mmc1:0001:1 failed with error -84

Before beating my head against the wall too much on this, I've
requested a copy of the proper helper and firmware from wi2wi, since
it is not at all clear to me that the ones from the Marvell site are
the correct ones.

> Do we know that this driver behaves with SDIO yet?

I'm not aware of anyone else who has used the hsmmc driver with SDIO,
so I think we are pioneering.  Certainly the libertas_sdio driver
itself has been proven on other hw.

TI claims that the 1.0.2 release of the 35XX EVM software will support
the libertas_sdio driver via the EVM's mmc slot.  However, I don't see
that version of the software yet on the TI site, and my guess is that
it will be using the internal TI kernel and not linux-omap.

Steve
