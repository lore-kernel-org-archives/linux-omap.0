From: john stultz <johnstul@us.ibm.com>
Subject: Re: [regression] 2.6.39-rc1 - Beagleboard usbnet broken
Date: Mon, 4 Apr 2011 18:52:53 -0700
Message-ID: <BANLkTi=-LoPdE3U9__MRi4j4L_c8zk5VpA@mail.gmail.com>
References: <4D998DC9.3040109@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33878 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab1DEBwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 21:52:55 -0400
In-Reply-To: <4D998DC9.3040109@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Mon, Apr 4, 2011 at 2:22 AM, Mark Jackson <mpfj-list@mimc.co.uk> wrote:
> Running 2.6.38 on my beagleboard, I can boot using nfs:-
[snip]
> I have just tried out 2.6.39-rc1, and the usbnet is no longer detected:-

Yea, I hit something similar, where on the beagleboard I only see the
root hubs, and not any of the devices (no usb, no keyboard, etc).

I bisected it down to:
commit 9e64bb1e9f0613093b3e34ac5402fcfef0dcc35a
Author: Keshava Munegowda <keshava_mgowda@ti.com>
Date:   Tue Mar 1 20:08:19 2011 +0530

    arm: omap: usb: Invoke usbhs core device initialization

thanks
-john
