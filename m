From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 6/6] omap2/3/4: Add Kconfig option to compile in typical
 omap	features
Date: Thu, 1 Jul 2010 16:04:32 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5E41BDF@dbde02.ent.ti.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
 <20100629114738.16008.62006.stgit@baageli.muru.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5DB6FC3@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5DB7026@dbde02.ent.ti.com>
 <20100630061726.GQ2822@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5E4124A@dbde02.ent.ti.com>
 <20100630072443.GW2822@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44493 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755044Ab0GAKek convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 06:34:40 -0400
In-Reply-To: <20100630072443.GW2822@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, June 30, 2010 12:55 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 6/6] omap2/3/4: Add Kconfig option to compile in
> typical omap features
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100630 09:41]:
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > Sent: Wednesday, June 30, 2010 11:47 AM
> > > To: Shilimkar, Santosh
> > > Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH 6/6] omap2/3/4: Add Kconfig option to compile in
> > > typical omap features
> > >
> > > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100629 17:40]:
> > > > > >
> > > > > With your series OMAP4 build breaks because of PM and SMP
> > > dependencies.
> > > > > To ensure that build doesn't break on OMAP4, I needed below
> change.
> > > With
> > > > > This change I tried your series and it boots OK on OMAP4430 SDP
> > >
> > > Hmm the build does not break for me?
> > >
> > Looks like I am missing something here. How do you build OMAP4 alone
> with
> > these new changes ??
> 
> Use your old config file, or just unselect CONFIG_ARCH_OMAP2
> and CONFIG_ARCH_OMAP3. Note that if you now do:
> 
> $ yes "" | ARCH=arm make oldconfig
> 
> with your old omap4 only config file, then by default the
> typical features get added by default. So what you probably
> want to do is (untested):
> 
> $ echo "# CONFIG_ARCH_OMAP2PLUS_TYPICAL is not set" >> .config
> $ yes "" | ARCH=arm make oldconfig
> 
> Then it should not change your old config file.
> 
The above method works Tony. The series boot tested with 4430 SDP

Regards,
Santosh
