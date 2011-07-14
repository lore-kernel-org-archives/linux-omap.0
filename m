From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2 4/5] TEMP: OMAP3: beagle rev-c4: enable OPP6
Date: Thu, 14 Jul 2011 14:16:15 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DB11D0A@dbde02.ent.ti.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
 <1310565638-13140-5-git-send-email-t-kristo@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024DB119F6@dbde02.ent.ti.com>
 <1310627438.4331.98.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58907 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894Ab1GNIqW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 04:46:22 -0400
In-Reply-To: <1310627438.4331.98.camel@sokoban>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kristo, Tero" <t-kristo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, "Hilman, Kevin" <khilman@ti.com>

> -----Original Message-----
> From: Kristo, Tero 
> Sent: Thursday, July 14, 2011 12:41 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; 
> broonie@opensource.wolfsonmicro.com; Girdwood, Liam; Hilman, Kevin
> Subject: RE: [PATCHv2 4/5] TEMP: OMAP3: beagle rev-c4: enable OPP6
> 
> On Wed, 2011-07-13 at 19:49 +0200, Premi, Sanjeev wrote:
> > > 
> Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 
> 0115040-6. Kotipaikka: Helsinki
>  
> -----Original Message-----
> 
> > > From: linux-omap-owner@vger.kernel.org 
> > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Kristo, Tero
> > > Sent: Wednesday, July 13, 2011 7:31 PM
> > > To: linux-omap@vger.kernel.org
> > > Cc: broonie@opensource.wolfsonmicro.com; Girdwood, Liam; 
> Hilman, Kevin
> > > Subject: [PATCHv2 4/5] TEMP: OMAP3: beagle rev-c4: enable OPP6
> > > 
> > > Beagleboard rev-c4 has a speed sorted OMAP3530 chip which can 
> > > run at 720MHz.
> > > 
> > > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > > ---

[snip]...[snip]

> > 
> > [sp] Basic support for 720MHz was already closed early this year.
> >      See: http://marc.info/?l=linux-omap&m=129735630928696&w=2
> > 
> >      I cannot check the current tree status right now; but I assume
> >      the patch should already be in.
> > 
> 
> Yea, I heard this was agreed upon, however it is not in the tree yet.
> Thus I just added this patch in the set for testing purposes... and
> tagged as TEMP.

I noticed this today morning. Will be reposting it today after rebase.

~sanjeev

> 
> > ~sanjeev
> > 
> > > -- 
> > > 1.7.4.1
> > > 
> > > 
> > > Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 
> > > 0115040-6. Kotipaikka: Helsinki
> > >  
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe 
> > > linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> 
> 
> 