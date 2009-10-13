From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
Date: Tue, 13 Oct 2009 10:15:11 -0700
Message-ID: <20091013171511.GS12700@atomide.com>
References: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com> <7A436F7769CA33409C6B44B358BFFF0C012A856FA5@dlee02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC35608702FA0D37E8@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BB254E67@dbde02.ent.ti.com> <4AD452F1.7000309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59557 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760654AbZJMRP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 13:15:58 -0400
Content-Disposition: inline
In-Reply-To: <4AD452F1.7000309@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sanjeev Premi <premi@ti.com>

* Nishanth Menon <menon.nishanth@gmail.com> [091013 03:44]:
> Shilimkar, Santosh said the following on 10/13/2009 05:03 AM:
> > Has anybody tried building latest linux-omap master ? The build is breaking for other OMAP processors.
> >
> > CC      arch/arm/mach-omap2/id.o
> > arch/arm/mach-omap2/id.c: In function 'omap3_cpuinfo':
> > arch/arm/mach-omap2/id.c:269: error: implicit declaration of function 'cpu_is_omap3630'
> > make[1]: *** [arch/arm/mach-omap2/id.o] Error 1
> > make: *** [arch/arm/mach-omap2] Error 2
> >
> > This is because of " 0a9b95f21995aa3cdda82ebc6e77b0b2ab401861"
> > 	omap: Introduce OMAP3630
> >
> > Below patch from Vikram fixes the build break.
> >   
> ouch.. my bad.. thanks for answering my question. I am guessing we need
> this coz of is_omap3630() translation..
> Ack for the patch from me.

To me it looks like all the 35x defines need the same treatment.

Tony
