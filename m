From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/14] omap: Map only available sram memory
Date: Mon, 4 Oct 2010 17:34:38 -0700
Message-ID: <20101005003438.GC3117@atomide.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <AANLkTi=PM1x7zXbSMRxBHVZ5Z2+4iwebvbiGizca_rC8@mail.gmail.com>
 <20101001225303.GF3117@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE18C@dbde02.ent.ti.com>
 <AANLkTi=zmgSCCg71NsYMte9K-yeyb1i0VxCA4i_9Y8D-@mail.gmail.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE61A@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE85B@dbde02.ent.ti.com>
 <AANLkTi=wbRKvjTmVwE+Svx1SGS1HgAh74KcN_Y6Xwmin@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65391 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab0JEAeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 20:34:50 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=wbRKvjTmVwE+Svx1SGS1HgAh74KcN_Y6Xwmin@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Grazvydas Ignotas <notasas@gmail.com> [101004 16:35]:
> > Looks like for you " is_sram_locked" function is failing. There was a patch
> > in my series from Vikram which was fixing this API.
> >
> > Do you have this patch applied when you are trying this out ?
> > http://www.spinics.net/linux/lists/arm-kernel/msg98697.html
> 
> Well it looks like this only happens on linux-next (was using
> next-20101001 version) with this defconfig:
> http://notaz.gp2x.de/misc/pnd/config_next_101001_2
> 
> this has yours and Vikram's patch you mentioned in. Using
> omap2plus_defconfig on linux-next or this "bad" defconfig on
> linux-omap boots fine, strange.

Maybe you need to disable CONFIG_SMP still in for-next?

At least one patch is still missing there, that's the TLB
broadcast patch we have in omap-testing and sitting in
Russell's patch system.

Regards,

Tony
