From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: Suspend broken on 3.3?
Date: Thu, 29 Mar 2012 14:44:32 +0530
Message-ID: <CAM=Q2cvpUuy4kVynOrT+Rng1OgSqRmsS9e3uTTc=_fOwUgrD_g@mail.gmail.com>
References: <WC20120322110946.6413AA@terrafix.co.uk>
	<87r4wka6bf.fsf@ti.com>
	<WC20120326134115.9815DF@terrafix.co.uk>
	<87haxaq3ua.fsf@ti.com>
	<CAMrsUd++maNjaK87bcRUqVHtz5zySujQXZK1YaMH9vnHVWCDag@mail.gmail.com>
	<878viln2t5.fsf@ti.com>
	<CAMrsUdKXZL4nT0MW=BcD53PsQFE+W1inij3XWe0e5+BjJF3odg@mail.gmail.com>
	<WC20120328153855.621724@terrafix.co.uk>
	<87vcloipow.fsf@ti.com>
	<WC20120329083556.20174D@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40385 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab2C2JOd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 05:14:33 -0400
Received: by iagz16 with SMTP id z16so2768326iag.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Mar 2012 02:14:33 -0700 (PDT)
In-Reply-To: <WC20120329083556.20174D@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Kevin Hilman <khilman@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, neilb@suse.de

Hi Joe,

> After digging a bit further I found that the problem isn't lost characters or character corruption at all...
>
> The UART is actually at 430KBaud (not 900KBaud as I mentioned earlier).
How did you verify that register read?


The data received is very bursty (i.e. sets of messages every second
or so), containing a
> sync sequence to indicate a start of packet.
>
> The received bytes should be: 0x01, 0x52, 0x41 ....rest of packet.
>
> This works 100% of the time on 3.2, but on 3.3 I sometimes (but not always) get: 0x01, 0x00, 0x52, 0x41.
>
> i.e. there is a NULL/0x00 inserted after the first character.
>
> All this is tested using a very simple userspace application thats reads data from ttyO1.
>
> Any ideas? Should I kick open a new thread as it's not really to do with suspend anymore?
Is there any flow control you are using?

>
