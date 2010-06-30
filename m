From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] omap2/3/4: Add Kconfig option to compile in
 typical omap	features
Date: Wed, 30 Jun 2010 10:24:44 +0300
Message-ID: <20100630072443.GW2822@atomide.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
 <20100629114738.16008.62006.stgit@baageli.muru.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5DB6FC3@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5DB7026@dbde02.ent.ti.com>
 <20100630061726.GQ2822@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5E4124A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54176 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab0F3HYh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 03:24:37 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5E4124A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100630 09:41]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Wednesday, June 30, 2010 11:47 AM
> > To: Shilimkar, Santosh
> > Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 6/6] omap2/3/4: Add Kconfig option to compile in
> > typical omap features
> > 
> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100629 17:40]:
> > > > >
> > > > With your series OMAP4 build breaks because of PM and SMP
> > dependencies.
> > > > To ensure that build doesn't break on OMAP4, I needed below change.
> > With
> > > > This change I tried your series and it boots OK on OMAP4430 SDP
> > 
> > Hmm the build does not break for me?
> >
> Looks like I am missing something here. How do you build OMAP4 alone with
> these new changes ??

Use your old config file, or just unselect CONFIG_ARCH_OMAP2
and CONFIG_ARCH_OMAP3. Note that if you now do:

$ yes "" | ARCH=arm make oldconfig

with your old omap4 only config file, then by default the
typical features get added by default. So what you probably
want to do is (untested):

$ echo "# CONFIG_ARCH_OMAP2PLUS_TYPICAL is not set" >> .config
$ yes "" | ARCH=arm make oldconfig

Then it should not change your old config file.

To see how the boards and features show up, you can also play
with it with make xconfig:

System Type -> TI OMAP2/3/4 Specific Features

Uncheck TI OMAP2 and TI OMAP3 so only TI OMAP4 is selected.

Regards,

Tony
