From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.15-rc4
Date: Thu, 8 May 2014 15:00:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405081456560.23579@utopia.booyaka.com>
References: <alpine.DEB.2.02.1405080417150.23579@utopia.booyaka.com> <CAGhQ9Vx_dJTn20S1OngAks1KvZkH=MUWEh-4bv5ciM7PhofJ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42711 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924AbaEHPAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 11:00:42 -0400
In-Reply-To: <CAGhQ9Vx_dJTn20S1OngAks1KvZkH=MUWEh-4bv5ciM7PhofJ8Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel-build-reports@lists.linaro.org

Hello Joachim,

On Thu, 8 May 2014, Joachim Eastwood wrote:

> On 8 May 2014 06:23, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > Here are some basic OMAP test results for Linux v3.15-rc4.
> > Logs and other details at:
> >
> >     http://www.pwsan.com/omap/testlogs/test_v3.15-rc4/20140505112251/
> >
> >
> > Test summary
> > ------------
> <snip>
> >
> > The eMMC on the 4460 VAR-SOM-OM has failed; I guess it's run out of
> > reserve blocks to reallocate.  Now it's time to find yet another way
> > to boot it.
> 
> I have some patches for u-boot which makes it possible to use the
> on-board LAN7500 USB Ethernet controller for tftp.

That's great!

> Since you have a VAR-SOM-OM44 module maybe you could test my dts patches for it?
> I will post a new version of the patch set early next week. I can cc you.

I'd like to load the rootfs off the external SD slot.  Looks like you 
might be adding support for that with your recent DT patches?

> Do you have the VAR-DVK-OM44 eval board?

Yes.


- Paul
