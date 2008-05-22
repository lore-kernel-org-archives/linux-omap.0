From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: MMC/SD cards hotplug scenario
Date: Fri, 23 May 2008 01:16:39 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C0015799CFD8@dbde02.ent.ti.com>
References: <004e01c8bb09$989fac00$538918ac@ent.ti.com>
	<20080521073017.GB23427@flint.arm.linux.org.uk>
	<005d01c8bb25$63345fe0$538918ac@ent.ti.com>
 <20080521203202.6d84a02b@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:45190 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbYEVTuP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 15:50:15 -0400
In-Reply-To: <20080521203202.6d84a02b@mjolnir.drzeus.cx>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <drzeus@drzeus.cx>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Pierre,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Pierre
> Ossman
> Sent: Thursday, May 22, 2008 12:02 AM
> To: Chikkature Rajashekar, Madhusudhan
> Cc: 'Russell King - ARM Linux'; linux-omap@vger.kernel.org; linux-arm-kernel@lists.arm.linux.org.uk
> Subject: Re: MMC/SD cards hotplug scenario
>
> On Wed, 21 May 2008 15:01:00 +0530
> "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com> wrote:
>
> > What I meant here is that reinsertion of the card does not seem to result in reinitialization of
> the card consistently.
>
> Previously, that has always been because of bad interactions with the
> block layer. 2.6.24 should be more resilient though.
>
> >
<snip>

> The obscene amount of noise here seems to be caused by ext2 being
> extremely persistent. This is generally a good thing for your data
> though. :)
>
> What is missing is a decent way for a block device to tell the upper
> layers that is gone with no hope of ever coming back. Right now we just
> tell it that there was a write error, which just makes the upper layers
> retry and retry.
>
In this scenario, do you think it would be right to kill the ongoing copy from application space, say for example an UI is running for MMC copy and when the card is removed the app gets notified may be through hotplug event or signaling and then app just kills the process that is issuing this copy request. This will prevent long running errors. Just a thought,

Regards,
Khasim
