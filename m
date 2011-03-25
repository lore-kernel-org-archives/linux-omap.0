From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or missing MAC
 addresses for eth0 and wlan0
Date: Fri, 25 Mar 2011 16:23:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1103251615380.11889@xanadu.home>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <20110324212737.14936.21228.stgit@otae.warmcat.com> <78b7faad4cdc37c6b507c008fde18ef3@mail.gmail.com> <AANLkTineUsH=Qz83YKJy8YZ1KSE1si-RddQ9eBsPjMdk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49775 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1CYUX0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 16:23:26 -0400
Received: by vxi39 with SMTP id 39so1062183vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 13:23:25 -0700 (PDT)
In-Reply-To: <AANLkTineUsH=Qz83YKJy8YZ1KSE1si-RddQ9eBsPjMdk@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Kridner <jkridner@beagleboard.org>
Cc: Hema Kalliguddi <hemahk@ti.com>, Andy Green <andy@warmcat.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, arnd@arndb.de, David Anders <x0132446@ti.com>, Sebastien Jan <s-jan@ti.com>, tony@atomide.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Green <andy.green@linaro.org>

On Fri, 25 Mar 2011, Jason Kridner wrote:

> I very much like this approach.  I believed the ability to use the die
> ID to get a unique code was reasonable approach and that is why I
> didn't get an EEPROM put onto the BeagleBoard, though Gerald is
> looking at adding one on a future revision because the lack of one
> wasn't well received.  Minor questions below.

If this code had been available and/or the procedure well documented 
before then I believe the reception would have been better.

> The use of the OMAP die id below makes this OMAP specific and the list
> referenced below of the devices to be referenced makes it Panda
> specific.  Is there a way to make the list board specific, but to make
> these functions that will be used across many OMAP platforms reusable?
>  I believe that this current code will result in a lot of
> cut-and-paste.  My preference is that this is accepted and that we
> make this more general when we add this to other OMAP platforms, but
> it'd be great to capture your suggestions on how to do so before those
> cut-and-paste patch sets start coming in.

It is true that this might get copied.  But as I suggested to Andy, it 
is best to wait and see how often this happens before generalizing the 
approach.  Consolidation is easier when you can see what is actually 
common and what is board specific.  Otherwise it is easy to 
fall into the over-engineering trap.


Nicolas
