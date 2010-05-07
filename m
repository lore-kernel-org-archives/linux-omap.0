From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/09] OMAP:GPIO:Implement GPIO in HWMOD way
Date: Fri, 7 May 2010 08:32:05 -0700
Message-ID: <20100507153204.GB387@atomide.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5387A73@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52719 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab0EGPcK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 11:32:10 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5387A73@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Varadarajan, Charulatha <charu@ti.com> [100506 23:52]:
> Tony/ Kevin,
> 
> > -----Original Message-----
> > From: Varadarajan, Charulatha
> > Sent: Thursday, April 22, 2010 9:25 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Nayak, Rajendra; paul@pwsan.com; tony@atomide.com;
> > khilman@deeprootsystems.com; Varadarajan, Charulatha
> > Subject: [PATCH 00/09] OMAP:GPIO:Implement GPIO in HWMOD way
> > 
> > This patch series implements GPIO as an early platform driver.
> > It makes OMAP2PLUS specific GPIO to get adapted to HWMOD FW.
> > OMAP1 specific GPIO is implemented as early platform device.
> > 
> > This patch series is created on "origin/pm-wip/hwmods". 
> 
> Planning to send few more patches for adapting some other
> drivers to HWMOD FW. 
> Which tree should those patches be created on?
> LO mainline? or hwmods branch? or runtime branch?

All the patches should be against the most recent tag
in Linus' mainline tree, currently v2.6.34-rc6.

If there are some dependencies to other patches, we need
to get those upstream immediately.

Regards,

Tony
