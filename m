From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: problem with n810 boot up
Date: Wed, 6 Jan 2010 18:10:39 -0600
Message-ID: <201001061810.49763.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <201001061740.17161.luke@dashjr.org> <4B4523F4.7080504@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from vps2.mechanicalrealm.com ([66.216.20.21]:39627 "EHLO
	zinan.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932752Ab0AGALA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:11:00 -0500
In-Reply-To: <4B4523F4.7080504@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <alecrim@gmail.com>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

On Wednesday 06 January 2010 05:59:48 pm you wrote:
> Luke-Jr wrote:
> > Also, note my rootfs is Gentoo, not Maemo. Maemo will depend on DSME
> > which is not being started with my modded linuxrc.
> 
> I'm using Mamona. Anyway,I did some tests before rootfs execution and I
> got the same problem. My current init contain only "exec /bin/sh".
> Device just turn power-off without error message.  :(

Well, give me a place to push my git tree and try that :)
