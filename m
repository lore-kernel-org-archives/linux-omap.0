From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [PATCH] ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz
Date: Sat, 24 Jan 2009 22:09:22 +0100
Message-ID: <C28EC916-AC18-4D09-8F2F-A9CF1A80DF88@beagleboard.org>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net> <196A1830-3227-48D0-B3BE-C7D935601BF5@beagleboard.org> <A73F0912-41CB-43F7-BE84-A4B91183B66B@beagleboard.org> <200901241230.34735.david-b@pacbell.net>
Mime-Version: 1.0 (iPhone Mail 5G77)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:34659 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634AbZAXVQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2009 16:16:07 -0500
Received: by ik-out-1112.google.com with SMTP id c28so639686ika.5
        for <linux-omap@vger.kernel.org>; Sat, 24 Jan 2009 13:16:04 -0800 (PST)
In-Reply-To: <200901241230.34735.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Jason Kridner <jkridner@beagleboard.org>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Beagle Board <beagleboard@googlegroups.com>



Op 24 jan 2009 om 21:30 heeft David Brownell <david-b@pacbell.net> het  
volgende geschreven:\

> On Saturday 24 January 2009, Jason Kridner wrote:
>>
>> Given that this port is only used on the DVI port for the  
>> BeagleBoard,
>> I believe it is appropriate to set it to 100kHz as Koen has done.
>
> That's what I meant to say (kHz not MHZ!) ... except, also add a
> comment saying why the (un-obvious) restriction is being made.
>

In the .c file or commit message?

Regards,

Koen


> Though I did note that since it's a nice level-shifted I2C, some
> folk may want to use it for non-DDC purposes [1], where a 100 KHz
> limit might not always be wanted.
>
> - Dave
>
> [1] http://www.paintyourdragon.com/uc/i2c/index.html
>
