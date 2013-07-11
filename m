From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Thu, 11 Jul 2013 12:45:15 +0200
Message-ID: <51DE8CBB.4000709@denx.de>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com> <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com> <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:28751 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab3GKKpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 06:45:49 -0400
In-Reply-To: <51DE87D3.5030600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

Hi Roger,

On 07/11/2013 12:24 PM, Roger Quadros wrote:
> Stefan,
> 
> I tried it out today and it worked 5/5 times. I used a bare bones
> debian root filesystem for
> the NFS root.

Thanks for testing.

> Could it be possible that the boot scripts on your filesystem are
> somehow shutting down
> the ethernet interface? Might be worth checking on a fresh filesystem.

I'm pretty sure that its not a problem with the filesystem. I'm using
exactly this filesystem for multiple other ARM based boards as well.
And all other boards (most of them with buildin ethernet controller
instead of USB connected) have no problem mounting/booting from it.

BTW: The filesystem is from the ELDK 5.3 [1][2]. You could download/install
it yourself.

>From your log I can see, that you are using a slightly different board
than I am ("Beagle xM Rev C" vs. "Beagle Rev C1/C2/C3"). So its a
different OMAP variant. Could this perhaps make a difference? Do you
by chance have the "old" Beagleboard (non-xM) at hand for another test?

Thanks again,
Stefan

[1] http://www.denx.de/wiki/view/ELDK-5/WebHome#Section_1.6.
[2] ftp://ftp.denx.de/pub/eldk/5.3/targets/armv7a/core-image-sato-sdk-generic-armv7a.tar.gz

