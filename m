From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: Booting n8x0 on mainline without UART
Date: Tue, 22 Feb 2011 11:35:09 +0100
Message-ID: <1298370909.6998.9.camel@maggie>
References: <3064ff5376f174fcd54b321764d8e2a0@mail.gmail.com>
	 (sfid-20110222_061127_909158_FFFFFFFFF3439231)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:45162 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048Ab1BVKfS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 05:35:18 -0500
In-Reply-To: <3064ff5376f174fcd54b321764d8e2a0@mail.gmail.com> (sfid-20110222_061127_909158_FFFFFFFFF3439231)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, 2011-02-22 at 10:41 +0530, Anand Gadiyar wrote: 
> I'm trying to boot up the mainline kernel on an n800 device. I don't have
> a functional UART up and running - so I cannot see any console messages.

I don't know about the n800, but for the n810 there are quite some
patches needed to get it working correctly.

https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches-2.6.37

Not all of those patches are strictly required for basic bootup, though.

-- 
Greetings Michael.

