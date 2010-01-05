From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: problem with n810 boot up
Date: Tue, 5 Jan 2010 17:46:56 -0600
Message-ID: <201001051747.02221.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <4B43CA48.3070009@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from vps2.mechanicalrealm.com ([66.216.20.21]:41688 "EHLO
	zinan.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab0AEXrQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 18:47:16 -0500
In-Reply-To: <4B43CA48.3070009@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <alecrim@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

On Tuesday 05 January 2010 05:24:56 pm Francisco Alecrim wrote:
> Luke-Jr wrote:
> > Tested on Nokia N810 in Linux-OMAP tree. Mainline is not bootable yet.
> 
> I'm with some problems to boot-up latest l-o(commit
> abb74381235a05f15a3b07e9e3831034942c67fb) with n810. The error message
> can be found below and full boot output in the end of email.
> 
> dsme: No correct bootreason found, entering the malfunction state

That's DSME, part of Maemo userland. You can possibly write a LD_PRELOAD 
workaround if you want to run it anyway...

> What rootfs do you use? Did you change initfs?

Gentoo. I modified my initfs to chainload its init if a new kernel is running.

Unfortunately, I have come to the realisation that moving forward with the 
Linux port to N8x0 would take me more time than simply spending the same time 
doing paid work and buying a N900* or Pandora instead. So short some other 
reimbursement for porting Linux to N8x0 (like maybe a promise of BME sources 
or a N900 after the rest is done to finish the job), I'm probably not going to 
spend any more time on it. :(

Luke

* N900 is supposedly mostly mainlined already, and supposedly Nokia will 
actually finish the job with unlike N8x0; it also has nicer hardware, even if 
you just ignore the cellular capabilities
