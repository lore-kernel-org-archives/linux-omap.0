From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc6-omap-git 5/5] move drivers/i2c/chips/twl4030-usb.c
Date: Mon, 1 Dec 2008 23:57:22 -0800
Message-ID: <200812012357.23227.david-b@pacbell.net>
References: <200812011321.56222.david-b@pacbell.net> <5d5443650812012239m580489fel23532a2217b8ff70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:27004 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751725AbYLBH5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 02:57:25 -0500
In-Reply-To: <5d5443650812012239m580489fel23532a2217b8ff70@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap@vger.kernel.org

On Monday 01 December 2008, Trilok Soni wrote:
> Any plan of moving menelaus.c from i2c/chips directory? I think we can
> move this driver under regulator framework too.

Whoever makes time to move that, and tps65010.c, to drivers/mfd
will earn Official Karma Points.  :)

Further updating those drivers to use the regulator framework,
and maybe even partitioning them a bit more (rtc-menelaus.c etc)
would be a Fine Thing too.  But I know that from at least Jean's
perspective, just emptying stuff out of i2c/chips is good.

- Dave

