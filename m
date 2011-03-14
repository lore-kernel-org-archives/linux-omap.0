From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: alsa-soc: Remove restrictive check for cpu type
Date: Mon, 14 Mar 2011 19:55:54 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C2469E6@dbde02.ent.ti.com>
References: <1300109513-29002-1-git-send-email-premi@ti.com>
	<20110314155542.b60bd852.jhnikula@gmail.com>
 <20110314160040.c15c0c8d.jhnikula@gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C2469DA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56965 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab1CNO0I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 10:26:08 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C2469DA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Monday, March 14, 2011 7:47 PM
> To: Jarkko Nikula
> Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org; 
> linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH] omap3: alsa-soc: Remove restrictive 
> check for cpu type
> 
> > -----Original Message-----
> > From: Jarkko Nikula [mailto:jhnikula@gmail.com] 
> > Sent: Monday, March 14, 2011 7:31 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org; 
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH] omap3: alsa-soc: Remove restrictive 
> > check for cpu type
> > 
> > On Mon, 14 Mar 2011 15:55:42 +0200
> > Jarkko Nikula <jhnikula@gmail.com> wrote:
> > 
> > > On Mon, 14 Mar 2011 19:01:53 +0530
> > > Sanjeev Premi <premi@ti.com> wrote:
> > > 
> > > > Current check for cpu type is too restrictive leading to
> > > > failures for other silicons in same family.
> > > > 
> > > > The problem was found while testing audio playback on
> > > > AM37x and AM35x processors. But should exist on OMAP36xx
> > > > as well.
> > > > 
> > > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > > > ---
> > > >  sound/soc/omap/omap-mcbsp.c |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > 
> > > There are two other cpu_is_omap343x tests as well. Care to 
> > check them
> > > too?
> > > 
> > Sorry, only one additional test. I forgot the commit 2686e07 "ASoC:
> > McBSP: get hw params from McBSP driver" that is coming via 
> linux-omap
> > and which removes one test.
> 
> Checking now...

Other check shouldn't be there are well... Had asked someone (off-this
-list) to help me test the change - but seems to be in todo.

Will test it myself and post updated patch today...

> 
> ~sanjeev
> 
> > 
> > -- 
> > Jarkko
> > --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 