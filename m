From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: problem with n810 boot up
Date: Wed, 6 Jan 2010 17:40:07 -0600
Message-ID: <201001061740.17161.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <20100106224520.GA29239@gandalf> <4B45167F.8020605@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from vps2.mechanicalrealm.com ([66.216.20.21]:44979 "EHLO
	zinan.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533Ab0AFXkb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 18:40:31 -0500
In-Reply-To: <4B45167F.8020605@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <alecrim@gmail.com>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

On Wednesday 06 January 2010 05:02:23 pm you wrote:
> I'm using the flags (no-omap-wd,no-retu-wd,no-lifeguard-reset)
> recommended by Kalle[1]. This's not the problem. :(

AFAIK, no-retu-wd disables *pinging* the retu WD (which itself cannot be 
disabled). I'd try removing that one.

Also, note my rootfs is Gentoo, not Maemo. Maemo will depend on DSME which is 
not being started with my modded linuxrc.
