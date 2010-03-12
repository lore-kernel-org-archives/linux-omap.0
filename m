From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 12/19] omap: Fix gpio_resume_after_retention
Date: Thu, 11 Mar 2010 18:04:44 -0600
Message-ID: <A24693684029E5489D1D202277BE894453FB1216@dlee02.ent.ti.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
 <20100311234834.4500.12726.stgit@baageli.muru.com>
 <A24693684029E5489D1D202277BE894453FB11F8@dlee02.ent.ti.com>
 <20100311235640.GW2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47265 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263Ab0CLAEw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 19:04:52 -0500
In-Reply-To: <20100311235640.GW2900@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, March 11, 2010 5:57 PM
> To: Aguirre, Sergio
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 12/19] omap: Fix gpio_resume_after_retention
> 
> * Aguirre, Sergio <saaguirre@ti.com> [100311 15:47]:
> > Hi Tony,
> >
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > Sent: Thursday, March 11, 2010 5:49 PM
> > > To: linux-arm-kernel@lists.infradead.org
> > > Cc: Aguirre, Sergio; linux-omap@vger.kernel.org
> > > Subject: [PATCH 12/19] omap: Fix gpio_resume_after_retention
> > >
> > > From: Tony Lindgren <Aguirre>
> >
> > Something funky mix happened with the authorship here :)
> >
> > Should be:
> >
> > From: Sergio Aguirre <saaguirre@ti.com>
> 
> Thanks, updated patch below.
> 
> I think this issue is related to applying patches from
> patchwork.kernel.org with email addresses in Lastname, Firstname
> format..

Hmm... I see.

I normally send my patches with this alias:

alias gsend='git send-email --smtp-server /usr/bin/msmtp --from "Sergio Aguirre <saaguirre@ti.com>" --envelope-sender="Sergio Aguirre <saaguirre@ti.com>"'

and then just do:

gsend --to='linux-omap@vger.kernel.org' patches/forLO_20100311/0001-mypatch.patch

But somehow the patch ends up (I'm guessing through TI LDAP server) changing that to "Aguirre, Sergio"...

and also Patchworks seems to continue display my old fullname: "Aguirre Rodriguez, Sergio Alberto"... I guess it's in a static data cache somewhere, maybe?

Does anyone know how to overcome this kind of scenario, and force what --from param says?

Regards,
Sergio

> 
> Tony
