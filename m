From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
Date: Wed, 27 Jun 2012 09:17:45 -0700
Message-ID: <20120627161745.GO3483@atomide.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
 <20120627133950.GJ3483@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34907 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757962Ab2F0QRs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 12:17:48 -0400
Content-Disposition: inline
In-Reply-To: <20120627133950.GJ3483@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tony Lindgren <tony@atomide.com> [120627 06:44]:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120614 07:37]:
> > On Mon, Jun 11, 2012 at 18:52:54, Hiremath, Vaibhav wrote:
> > > As omap1 and omap2 will never be compiled together, due to
> > > different compiler flags, so we can simply make
> > > cpu_class_is_omap2() = true, for all non-omap1 platforms.
> > > 
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > ---
> > >  arch/arm/plat-omap/include/plat/cpu.h |    3 +--
> > >  1 files changed, 1 insertions(+), 2 deletions(-)
> > > 
> > 
> > Tony,
> > 
> > Ping???
> 
> Thanks applying into devel-am33xx branch.

Actually looks like this fails for the dynamic detection
case with omap1_defconfig.. Looks like you did not build
test your patch with omap1_defconfig? Please do it for
every patch!

It seems we need something better though for multi zImage
too, we can't really rely on CONFIG_ARCH_OMAP1 or
CONFIG_ARCH_OMAP2PLUS here to determine anything.

Anyways, dropping this for now, let's try to come up
with something better.

Tony
