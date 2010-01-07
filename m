From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: problem with n810 boot up
Date: Thu, 7 Jan 2010 09:40:59 -0600
Message-ID: <201001070941.05201.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <201001061810.49763.luke@dashjr.org> <4B45FCF4.5030409@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from vps2.mechanicalrealm.com ([66.216.20.21]:45332 "EHLO
	zinan.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab0AGPlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 10:41:20 -0500
In-Reply-To: <4B45FCF4.5030409@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <alecrim@gmail.com>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

On Thursday 07 January 2010 09:25:40 am Francisco Alecrim wrote:
> Luke-Jr wrote:
> > On Wednesday 06 January 2010 05:59:48 pm you wrote:
> >> Luke-Jr wrote:
> >>> Also, note my rootfs is Gentoo, not Maemo. Maemo will depend on DSME
> >>> which is not being started with my modded linuxrc.
> >>
> >> I'm using Mamona. Anyway,I did some tests before rootfs execution and I
> >> got the same problem. My current init contain only "exec /bin/sh".
> >> Device just turn power-off without error message.  :(
> >
> > Well, give me a place to push my git tree and try that :)
> 
> If you have some custom changes to linux-omap kernel work correctly with
> N8x0+Gentoo, you can share it using http://gitorious.org/ . It's gonne
> be nice!

Hmm, for some reason I thought Gitorious had a storage limit... guess not! :)
Pushing to http://gitorious.org/~Luke-Jr/n8x0
It's taking a while :/
