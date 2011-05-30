From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD init
Date: Mon, 30 May 2011 12:53:08 +0200
Message-ID: <67E1DA9A-6E02-4C87-91FE-11C0FF656A5F@dominion.thruhere.net>
References: <1306375016-707-1-git-send-email-nm@ti.com> <1306375016-707-4-git-send-email-nm@ti.com> <87oc2p82q0.fsf@ti.com> <4DDF4E4D.6060008@ti.com> <87oc2ox7bm.fsf@ti.com> <BANLkTi==jZV13S1tzuRbWuoJytCZCBeWQg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60077 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1E3KxM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 06:53:12 -0400
Received: by wya21 with SMTP id 21so2538704wya.19
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 03:53:11 -0700 (PDT)
In-Reply-To: <BANLkTi==jZV13S1tzuRbWuoJytCZCBeWQg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>


Op 29 mei 2011, om 23:04 heeft Steve Calfee het volgende geschreven:

> For instance Beagleboard xm uboot
> cannot access the ethernet because it is usb based, and uboot cannot
> access its own environment in flash - because it is running from a new
> microsd based flash system. 

U-boot has supported reading from SD cards for some years now. You can even write to them from inside uboot if you wish.