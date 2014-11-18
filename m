From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq handling
Date: Tue, 18 Nov 2014 19:31:44 +0300
Message-ID: <5D39428D-F359-4F04-8ACC-D607011B88B9@gmail.com>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com> <1416014452-6712-2-git-send-email-al.kochet@gmail.com> <20141115014859.GC808@saruman> <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com> <20141115034756.GA2917@saruman> <20141115035328.GA3289@saruman> <A47891AC-7453-43F0-9196-5133A1525C68@gmail.com> <20141116154558.GA7422@saruman> <20141117144152.GA12644@katana> <20141118160059.GI8223@saruman>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:56940 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbaKRQbt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 11:31:49 -0500
In-Reply-To: <20141118160059.GI8223@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Alexander Kochetkov <al.kochet@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>


> Still, as of now we can't consider what Alexander mentions a bug. Good
> to get it sorted out, but not -rc material.
> 

Actually, I focused on fixing issues then i2c-omap acts as master in a multi master environment.
And must say, that current linux/mainline driver work perfectly with minor fixes.

I could take a look how to switch the driver into mixed master/slave mode, but later.

Sad to say, I encountered undocumented i2c- hardware issue.
In short: BB-bit doesn't reflect I2C-bus state after soft reset if SDA or SCL line was low during reset
until i2c-controller again detect START or STOP condition on the wire.

More over, if SDA was low during reset, than next submitted transfer will not start ("controller timeout"),
if SCL was low during reset, than next submitted transfer will start and corrupt signals on wire :(

I'm checking it now. And going to post results to ti forum.

BB-bit reflect I2C-bus state, between power-down/power-up modes.

Alexander.