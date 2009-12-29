From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] OMAP2: add USB platform data and initialization for Nokia N800 and N810
Date: Tue, 29 Dec 2009 10:55:46 +0200
Message-ID: <873a2uxip9.fsf@purkki.valot.fi>
References: <200912290152.16357.luke@dashjr.org>
	<87d41yxjx9.fsf@purkki.valot.fi> <200912290246.57663.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:43014 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbZL2Izu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 03:55:50 -0500
In-Reply-To: <200912290246.57663.luke@dashjr.org> (Luke-Jr's message of "Tue\, 29 Dec 2009 02\:46\:50 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

"Luke-Jr" <luke@dashjr.org> writes:

> On Tuesday 29 December 2009 02:29:22 am Kalle Valo wrote:
>> "Luke-Jr" <luke@dashjr.org> writes:
>> > Tested on Nokia N810 in Linux-OMAP tree. Mainline is not bootable yet.
>> 
>> What's the problem in mainline? I haven't tested n8x0 for months :(
>
> Lack of platform support, as far as I know. Until we have cbus,
> there's no way to get the LCD powered...

Oh that. I have only used serial console with mainline. Luckily Felipe
did some cbus patches, I haven't checked them yet though.

>> I think a separate file is not needed, it's not that much code. I
>> recommend to just adding it directly to board-n8x0.c. It's simple and
>> easier for everyone.
>
> Seemed simpler to manage in a separate file

Having lots of small files is difficult IMHO.

> though not as necessary as the LCD stuff (which I also have a patch
> against mainline for, but it needs tahvo...)

Nice.

>> CONFIG_MACH_NOKIA_N8X0_LCD does not look right here.
>
> Heh, looks like my isolate-and-merge-to-mainline got messed up there.
> Of course it should be CONFIG_MACH_NOKIA_N8X0_USB :)

Yeah, maybe eating too much ham caused it ;)

> Also, scripts/checkpatch.pl gave me a warning about the extern in a .c file, 
> but I couldn't figure out where else it could reasonably go. Any ideas? :/

Yes, just put everything into one file :) No need for externs then.

-- 
Kalle Valo
