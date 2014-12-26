From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 08:13:49 -0800
Message-ID: <20141226161349.GC12409@atomide.com>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
 <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
 <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <549BE333.9060709@compulab.co.il>
 <549D5CC0.2090408@linaro.org>
 <20141226152620.GF17430@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16446 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbaLZQNz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 11:13:55 -0500
Content-Disposition: inline
In-Reply-To: <20141226152620.GF17430@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Igor Grinberg <grinberg@compulab.co.il>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [141226 07:29]:
> On Fri, Dec 26, 2014 at 03:04:00PM +0200, Grygorii.Strashko@linaro.org wrote:
> > >>>
> > >>> Tony, your call
> > 
> > May be it will be good thing to split this patch. That way more
> > information will be stored in commit log about which set of options
> > gives us what benefits.  And also, It will allow to continue with
> > agreed changes.  ?
> 
> can be done, but then again, it's just a defconfig change. Tony, your
> call.
> 
> > >> I think we should move omap2plus_defconfig to be mostly modular and
> > >> usable for distros as a base. Most distros prefer to build almost
> > >> everything as loadable modules. And my preference is that we should
> > >> only keep the minimum rootfs for devices and serial support as
> > >> built-in and rely on initramfs for most drivers. And slowly move
> > >> also the remaining built-in drivers to be loadable modules.
> > >>
> > >> The reasons for having drivers as loadable modules are many. It
> > >> allows distros to use the same kernel for all the devices without
> > >> bloating the kernel. It makes developing drivers easier as just the
> > >> module needs to be reloaded. And loadable modules protect us from
> > >> cross-framework spaghetti calls in the kernel as the interfaces are
> > >> clearly defined.
> > >>
> > >> Are there people really using SATA as rootfs right now on omaps?
> > > 
> > > Yes. That is exactly my point.
> > > 
> > 
> > From my side I'd like to note that I know about few ongoing projects
> > on DRA7x EVM where SATA is used as rootfs - now It is the fast
> > possible way to start Android.
> 
> now this is something different. This is evidence that there are people
> relying on SATA on rootfs. I'll leave to Tony again.

OK sounds like people are really using SATA as rootfs, so we might as
well keep it built in then. And it does not affect the PM on the devices
that do have PM working, that has been a problem with having some
drivers built-in.

We can still work towards making the current rootfs device drivers
into loadable modules in the long term :)

Regards,

Tony
