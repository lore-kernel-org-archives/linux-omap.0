From: Tony Lindgren <tony@atomide.com>
Subject: Re: Some patches need reposting, inbox cleared, patchwork cleared
Date: Mon, 16 Nov 2009 12:59:48 -0800
Message-ID: <20091116205948.GQ3684@atomide.com>
References: <20091113003851.GN24837@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8605@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C860A@dbde02.ent.ti.com>
 <20091113180323.GC3684@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA689287@dbde02.ent.ti.com>
 <20091113181550.GD3684@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA689291@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA6892A1@dbde02.ent.ti.com>
 <20091114010800.GK3684@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8C3A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64387 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbZKPU7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 15:59:45 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8C3A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aggarwal, Anuj <anuj.aggarwal@ti.com> [091116 03:37]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Saturday, November 14, 2009 6:38 AM
> > To: Pandita, Vikram
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: Some patches need reposting, inbox cleared, patchwork cleared
> > 
> > * Pandita, Vikram <vikram.pandita@ti.com> [091113 11:06]:
> > > Tony
> > >
> > > >-----Original Message-----
> > > >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of
> > > >Pandita, Vikram
> > > >>From: Tony Lindgren [mailto:tony@atomide.com]
> > > >>> I just verified booting zoom3 on l-o master, and its working fine.
> > > >>
> > > >>OK good. Can you also try booting this patch from Felipe on 3630:
> > > >>
> > > >>http://patchwork.kernel.org/patch/59540/
> > > >
> > > >Patch does not apply. Rebasing now and testing.
> > >
> > > Rebased Patch (attached) boots up fine now on 3630 Zoom3 board.
> > >
> > > Logs:
> > > CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
> > > CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> > > Machine: OMAP Zoom3 board
> > > Memory policy: ECC disabled, Data cache writeback
> > > OMAP3630 ES1.0 (l2cache iva sgx neon isp )
> > >
> > 
> > OK, thanks applying it.
> Tony,
> 
> I am not able to see the following patch in the list:
> 
> OMAP3EVM: Use the twl4030_setup_data for headset pop-removal
> http://marc.info/?l=linux-omap&m=125368984011630&w=2
> 
> Can you apply it please?

It looks like it should go in via the ASoC, so not taking it.

>From MAINTAINERS file:

SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
M:      Liam Girdwood <lrg@slimlogic.co.uk>
M:      Mark Brown <broonie@opensource.wolfsonmicro.com>
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
L:      alsa-devel@alsa-project.org (moderated for non-subscribers)
W:      http://alsa-project.org/main/index.php/ASoC
S:      Supported
F:      sound/soc/
F:      include/sound/soc*

Regards,

Tony
