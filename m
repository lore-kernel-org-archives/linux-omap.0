From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Wed, 31 Oct 2012 10:05:43 +0100
Message-ID: <1803719.beylA4kOPP@vostro.rjw.lan>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com> <alpine.DEB.2.00.1210301400100.12697@utopia.booyaka.com> <CAORVsuX_8ryT7jmPWoQ+Lb1ztmQC-E59j64Qt1hzvsEkQ7=w+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48047 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161030Ab2JaJBj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 05:01:39 -0400
In-Reply-To: <CAORVsuX_8ryT7jmPWoQ+Lb1ztmQC-E59j64Qt1hzvsEkQ7=w+g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wednesday, October 31, 2012 04:34:21 AM Jean Pihet wrote:
> Paul,
> 
> - Added Rafael for the PM QoS discussion -
> 
> On Tue, Oct 30, 2012 at 10:04 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 30 Oct 2012, Paul Walmsley wrote:
> >
> >> Based on a very quick look, I'd say the original patch 3db11fe is broken.
> >> I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is
> >> honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for
> >> omap2plus_defconfig.
> >
> > So in fact to follow up on this, looks like one of two changes are needed:
> >
> > 1. Revert 3db11fe
> >
> > or
> >
> > 2. If CONFIG_CPU_IDLE=n, the driver needs to call disable_hlt() in place
> > of the pm_qos constraint add, and call enable_hlt() in place of the pm_qos
> > constraint remove.
> I do not think this is correct. Using disable_hlt is a too radical
> solution and will prevent the idle completely, this is not what we
> want.
> 
> Rafael, what do you think?

Well, I agree.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
