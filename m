From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 0/3] ARM: dts: omap5-uevm: fixup wrong regulator
 configuration
Date: Mon, 29 Jul 2013 23:52:54 -0700
Message-ID: <20130730065253.GE7656@atomide.com>
References: <51F67D7D.9070003@ti.com>
 <1375117383-19285-1-git-send-email-nm@ti.com>
 <51F6EA23.50803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60921 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab3G3Gw6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 02:52:58 -0400
Content-Disposition: inline
In-Reply-To: <51F6EA23.50803@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <benoit.cousson@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, l-o <linux-omap@vger.kernel.org>, dt list <devicetree@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, J Keerthy <j-keerthy@ti.com>

* Benoit Cousson <benoit.cousson@gmail.com> [130729 15:24]:
> Hi Nishanth,
> 
> Thanks for the quick update.
> 
> On 29/07/2013 19:03, Nishanth Menon wrote:
> > Due to wrong older revision of documentation used as reference, we
> > seem to have a bunch of LDOs wrongly configured on OMAP5 uEVM. This
> > series is based power tree on production board 750-2628-XXX platform.
> > Unfortunately, the wrong voltages may be detrimental to OMAP5 as they
> > supply hardware blocks at voltages that are out of specification.
> >
> > Also available at:
> > based on v3.11-rc1 tag
> > http link: https://github.com/nmenon/linux-2.6-playground/commits/push/omap5-palmas-fixes-v2
> > git link: git://github.com/nmenon/linux-2.6-playground.git
> > branch: push/omap5-palmas-fixes-v2
> >
> > Changes since V1:
> >  - squash of patches
> >  - picked up Ack from Keerthy
> >  - based on v3.11-rc3 tag
> >
> > V1: http://marc.info/?t=137407980100008&r=1&w=2
> >
> > Nishanth Menon (3):
> >   ARM: dts: omap5-uevm: document regulator signals used on the actual
> >     board
> >   ARM: dts: omap5-uevm: fix regulator configurations mandatory for SoC
> >   ARM: dts: omap5-uevm: update optional/unused regulator configurations
> >
> >  arch/arm/boot/dts/omap5-uevm.dts |   78 ++++++++++++++++++++++++--------------
> >  1 file changed, 49 insertions(+), 29 deletions(-)
> >
> > Regards,
> > Nishanth Menon
> 
> For the whole series:
> 
> Acked-by: Benoit Cousson <benoit.cousson@gmail.com>

Thanks, I've applied these into omap-for-v3.11/fixes-omap5
and will send a pull request for these today as these seem
quite urgent fixes.

Regards,

Tony
